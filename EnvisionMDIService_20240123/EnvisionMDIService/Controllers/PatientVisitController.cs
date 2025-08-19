using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.WebService;
using EnvisionMDIService.Connection;
using System;
using System.Data;
using System.Web.Http;
namespace EnvisionMDIService.Controllers
{
    public class PatientVisitController : IeController
    {
        private const string controller_name = "PatientVisit";

        MdiDbConnection mdi_db = new MdiDbConnection(controller_name);
        ThirdPartyHttpConnection third_party_http = new ThirdPartyHttpConnection(controller_name);

        public PatientVisitController() : base(ServiceConfig.EnableTraceInbound) { }

        [HttpPost]
        [ActionName("Update")]
        public object Update([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_Update";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                mdi_db.Execute(SqlScriptName.PatientVisit_Update, json_obj_request);

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
}