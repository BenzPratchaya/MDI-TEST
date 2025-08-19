using System.Web;
using System.Web.Http;

namespace EnvisionMDIGet3rdPartyData
{
    public class WebApiApplication : HttpApplication
    {
        protected void Application_Start() { GlobalConfiguration.Configure(WebApiConfig.Register); }
    }
}