using System.Web.Http;

namespace EnvisionMDIService
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            config.SuppressHostPrincipal();
            config.Filters.Add(new MiAuthenticationFilter());
            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "{controller}/{action}",
                defaults: new { action = "Welcome" }
            );
        }
    }
}