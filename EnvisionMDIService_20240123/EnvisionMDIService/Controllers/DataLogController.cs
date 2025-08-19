using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.WebService;
using EnvisionMDIService.Connection;
using System;
using System.Data;
using System.Web.Http;

namespace EnvisionMDIService.Controllers
{
    public class DataLogController : IeController
    {
        private const string controller_name = "DataLog";


        MdiDbConnection mdi_db = new MdiDbConnection(controller_name);
        ThirdPartyHttpConnection third_party_http = new ThirdPartyHttpConnection(controller_name);

        public DataLogController() : base(ServiceConfig.EnableTraceInbound) { }

        [HttpPost]
        [ActionName("SelectByDataId")]
        public object SelectByDataId([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectByDataId";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.DataLog_SelectByDataId, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("DataLog_SelectByDataId", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
}