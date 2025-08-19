using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.WebService;
using EnvisionMDIService.Connection;
using System;
using System.Data;
using System.Web.Http;

namespace EnvisionMDIService.Controllers
{
    public class ModalityController : IeController
    {
        private const string controller_name = "Modality";

        MdiDbConnection mdi_db = new MdiDbConnection(controller_name);
        ThirdPartyHttpConnection third_party_http = new ThirdPartyHttpConnection(controller_name);

        public ModalityController() : base(ServiceConfig.EnableTraceInbound) { }

        [HttpPost]
        [ActionName("SelectByModalityUid")]
        public object SelectByModalityUid([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectByModalityUid";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Modality_SelectByModalityUid, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Modality_SelectByModalityUid", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("SelectView")]
        public object SelectView([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectView";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Modality_SelectView, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Modality_SelectView", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("Insert")]
        public object Insert([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_Insert";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                mdi_db.Execute(SqlScriptName.Modality_Insert, json_obj_request);

                json_obj_request["ModalityId"] = mdi_db.LastInsertedId;
                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

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
                mdi_db.Execute(SqlScriptName.Modality_Update, json_obj_request);

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
}