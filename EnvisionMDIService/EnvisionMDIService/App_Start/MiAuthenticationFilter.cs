using EnvisionIE.Operational;
using EnvisionIEService.WebService;
using System;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.ServiceModel.Channels;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace EnvisionMDIService
{
    public class MiAuthenticationFilter : AuthorizeAttribute, IAuthenticationFilter
    {
        public async Task AuthenticateAsync(HttpAuthenticationContext context, CancellationToken cancellationToken)
        {
            try
            {
                string auth_parameter = "";

                HttpRequestMessage request = context.Request;

                if (SkipAuthorization(context.ActionContext))
                    return;

                string client_ip = "";

                if (request.Properties.ContainsKey("MS_HttpContext"))
                    client_ip = ((HttpContextWrapper)request.Properties["MS_HttpContext"]).Request.UserHostAddress;
                else if (request.Properties.ContainsKey(RemoteEndpointMessageProperty.Name))
                    client_ip = ((RemoteEndpointMessageProperty)request.Properties[RemoteEndpointMessageProperty.Name]).Address;
                else if (HttpContext.Current != null)
                    client_ip = HttpContext.Current.Request.UserHostAddress;

                bool allow_ip = false;

                if (!string.IsNullOrEmpty(client_ip))
                {
                    allow_ip = (!Utilities.HasData(ServiceConfig.AllowHosts) || Utilities.CheckPolicyHost(ServiceConfig.AllowHosts.ToArray(), client_ip))
                        && (!Utilities.HasData(ServiceConfig.BlockHosts) || !Utilities.CheckPolicyHost(ServiceConfig.BlockHosts.ToArray(), client_ip));

                    auth_parameter = IeTokenJwt.Create(client_ip);
                }

                AuthenticationHeaderValue authorization = request.Headers.Authorization;

                if (authorization == null)
                {
                    if (!allow_ip)
                    {
                        context.ErrorResult = new AuthenticationFailureResult("Missing autorization header", request);

                        return;
                    }
                }
                else if (authorization.Scheme != "Bearer")
                {
                    if (!allow_ip)
                    {
                        context.ErrorResult = new AuthenticationFailureResult("Invalid autorization scheme", request);

                        return;
                    }
                }
                else if (string.IsNullOrEmpty(authorization.Parameter))
                {
                    if (!allow_ip)
                    {
                        context.ErrorResult = new AuthenticationFailureResult("Missing autorization parameter", request);

                        return;
                    }
                }
                else
                    auth_parameter = authorization.Parameter;

                if (string.IsNullOrEmpty(auth_parameter))
                {
                    context.ErrorResult = new AuthenticationFailureResult("Missing credentials", request);

                    return;
                }

                context.Principal = IeTokenJwt.ValidateToken(auth_parameter);
            }
            catch (Exception ex)
            {
                context.ErrorResult = new AuthenticationFailureResult("Exception: " + ex.Message, context.Request);
            }
        }

        private static bool SkipAuthorization(HttpActionContext actionContext)
        {
            Contract.Assert(actionContext != null);

            return actionContext.ActionDescriptor.GetCustomAttributes<AllowAnonymousAttribute>().Any()
                || actionContext.ControllerContext.ControllerDescriptor.GetCustomAttributes<AllowAnonymousAttribute>().Any();
        }

        public Task ChallengeAsync(HttpAuthenticationChallengeContext context, CancellationToken cancellationToken) => Task.FromResult(0);
    }

    public class AuthenticationFailureResult : IHttpActionResult
    {
        public AuthenticationFailureResult(string reasonPhrase, HttpRequestMessage request)
        {
            ReasonPhrase = reasonPhrase;
            Request = request;
        }

        public string ReasonPhrase { get; private set; }
        public HttpRequestMessage Request { get; private set; }

        public Task<HttpResponseMessage> ExecuteAsync(CancellationToken cancellationToken) => Task.FromResult(new HttpResponseMessage(HttpStatusCode.Unauthorized)
        {
            RequestMessage = Request,
            ReasonPhrase = ReasonPhrase
        });
    }
}