using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.WebService;
using EnvisionMDI.Entity;
using EnvisionMDIService.Connection;
using System;
using System.Data;
using System.Web.Http;

namespace EnvisionMDIService.Controllers
{
    public class DataController : IeController
    {
        private const string controller_name = "Data";

        MdiDbConnection mdi_db = new MdiDbConnection(controller_name);
        ThirdPartyHttpConnection third_party_http = new ThirdPartyHttpConnection(controller_name);

        public DataController() : base(ServiceConfig.EnableTraceInbound) { }

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
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectByDataId, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectByDataId", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("SelectNonConfirmByHn")]
        public object Data_SelectNonConfirmByHn([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectNonConfirmByHn";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectNonConfirmByHn, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectNonConfirmByHn", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("SelectNonConfirmByVN")]
        public object Data_SelectNonConfirmByVN([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectNonConfirmByVN";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectNonConfirmByVN, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectNonConfirmByVN", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("SelectLastVisitByHn")]
        public object Data_SelectLastVisitByHn([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectLastVisitByHn";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectLastVisitByHn, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectLastVisitByHn", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("SelectViewByDate")]
        public object SelectViewByDate([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectViewByDate";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                json_obj_request["StartDateTime"] = Utilities.ToDateTime(json_obj_request["StartDateTime"]).Date;
                json_obj_request["EndDateTime"] = Utilities.ToDateTime(json_obj_request["EndDateTime"]).Date.Add(new TimeSpan(23, 59, 59));

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectViewByDate, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectViewByDate", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        /*
        [HttpPost]
        [ActionName("SelectViewByDateWithLocationId")]
        public object SelectViewByDateWithLocationId([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectViewByDateWithLocationId";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                json_obj_request["StartDateTime"] = Utilities.ToDateTime(json_obj_request["StartDateTime"]).Date;
                json_obj_request["EndDateTime"] = Utilities.ToDateTime(json_obj_request["EndDateTime"]).Date.Add(new TimeSpan(23, 59, 59));

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectViewByDateWithLocationId, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectViewByDateWithLocationId", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
        */

        [HttpPost]
        [ActionName("SelectNonConfirmByModalityId")]
        public object SelectNonConfirmByModalityId([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectNonConfirmByModalityId";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                json_obj_request["StartDateTime"] = Utilities.ToDateTime(json_obj_request["StartDateTime"]).Date;
                json_obj_request["EndDateTime"] = Utilities.ToDateTime(json_obj_request["EndDateTime"]).Date.Add(new TimeSpan(23, 59, 59));
                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectNonConfirmByModalityId, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectNonConfirmByModalityId", controller_name);

                    ds_mdi.AcceptChanges();

                    json_obj_response.Add(ds_mdi.Copy());
                }

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("SelectViewByHn")]
        public object SelectViewByHn([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectViewByHn";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectViewByHn, json_obj_request);

                if (Utilities.HasData(ds_mdi))
                {
                    foreach (DataTable dtt_mdi in ds_mdi.Tables)
                        dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectViewByHn", controller_name);

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
                if (!mdi_db.Execute(SqlScriptName.Data_Insert, json_obj_request))
                    return mdi_db.Ack;

                Data data = json_obj_request.To<Data>();

                if (data.IsConfirmed)
                    third_party_http.PostSetDataByDataId(mdi_db.LastInsertedId, data.OrganizationId);

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

                Data data = json_obj_request.To<Data>();
                Data data_exist = mdi_db.Data_Select(data);

                if (data_exist == null)
                {
                    return mdi_db.EventFailure
                        ? mdi_db.Ack
                        : DefaultAck.Reject(controller_name, function_name, "Data not found");
                }

                mdi_db.Parameters = null;
                if (!mdi_db.Execute(SqlScriptName.Data_Update, json_obj_request))
                    return mdi_db.Ack;

                if (data.IsConfirmed && !data_exist.IsConfirmed)
                    third_party_http.PostSetDataByDataId(data_exist.DataId, data_exist.OrganizationId);

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("UpdateReconcile")]
        public object UpdateReconcile([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_UpdateReconcile";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                mdi_db.Parameters = null;
                mdi_db.Execute(SqlScriptName.Data_UpdateReconcile, json_obj_request);

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
}