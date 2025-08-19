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
    public class PatientController : IeController
    {
        private const string controller_name = "Patient";

        MdiDbConnection mdi_db = new MdiDbConnection(controller_name);
        ThirdPartyHttpConnection third_party_http = new ThirdPartyHttpConnection(controller_name);

        public PatientController() : base(ServiceConfig.EnableTraceInbound) { }

        [HttpPost]
        [ActionName("SelectByHn")]
        public object SelectByHn([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectByHn";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                int organization_id = Utilities.ToInt(json_obj_request["OrganizationId"]);

                if (organization_id < 1)
                {
                    Modality modality = mdi_db.Modality_SelectByModalityUid(json_obj_request["ModalityUid"].ToString());

                    if (modality != null)
                        organization_id = modality.OrganizationId;
                }

                MiJsonObjectList json_3rd_patient = new MiJsonObjectList(third_party_http.PostGetPatient(json_obj_request["Hn"].ToString(), organization_id));

                mdi_db.Parameters = null;
                DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Patient_SelectByHn, json_obj_request);

                if (mdi_db.EventFailure)
                    json_obj_response.Add(mdi_db.Ack);
                else
                {
                    if (Utilities.HasData(ds_mdi))
                    {
                        foreach (DataTable dtt_mdi in ds_mdi.Tables)
                            dtt_mdi.TableName = dtt_mdi.TableName.Replace("Patient_SelectByHn", controller_name);

                        DataTable dtt = ds_mdi.Tables[0];

                        Utilities.DataTableAddColumn(dtt, "VisitNo", typeof(string));

                        if (!third_party_http.EventFailure)
                        {
                            foreach (DataRow dr in dtt.Rows)
                                dr["VisitNo"] = json_3rd_patient["VisitNo"].ToString();
                        }

                        ds_mdi.AcceptChanges();

                        json_obj_response.Add(ds_mdi.Copy());

                    }

                    json_obj_response.Add(mdi_db.Ack);
                    json_obj_response.Add(third_party_http.Ack.TextMessage);
                }

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }


        [HttpPost]
        [ActionName("SelectByVn")]
        public object SelectByVn([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SelectByVn";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                int organization_id = Utilities.ToInt(json_obj_request["OrganizationId"]);

                if (organization_id < 1)
                {
                    Modality modality = mdi_db.Modality_SelectByModalityUid(json_obj_request["ModalityUid"].ToString());

                    if (modality != null)
                        organization_id = modality.OrganizationId;
                }

                MiJsonObjectList json_3rd_patient = new MiJsonObjectList(third_party_http.PostGetPatientByVn(json_obj_request["VisitNo"].ToString(), organization_id));


                if (third_party_http.EventFailure)
                    json_obj_response.Add(third_party_http.Ack);
                else
                {
                    mdi_db.Parameters = null;
                    DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Patient_SelectByHn, json_3rd_patient);
                    if (mdi_db.EventFailure)
                        json_obj_response.Add(mdi_db.Ack);
                    else
                    {
                        if (Utilities.HasData(ds_mdi))
                        {
                            foreach (DataTable dtt_mdi in ds_mdi.Tables)
                                dtt_mdi.TableName = dtt_mdi.TableName.Replace("Patient_SelectByHn", controller_name);

                            DataTable dtt = ds_mdi.Tables[0];

                            Utilities.DataTableAddColumn(dtt, "VisitNo", typeof(string));

                            if (!third_party_http.EventFailure)
                            {
                                foreach (DataRow dr in dtt.Rows)
                                    dr["VisitNo"] = json_3rd_patient["VisitNo"].ToString();
                            }

                            ds_mdi.AcceptChanges();

                            json_obj_response.Add(ds_mdi.Copy());
                        }

                        json_obj_response.Add(third_party_http.Ack);
                    }
            }
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
                mdi_db.Execute(SqlScriptName.Patient_Insert, json_obj_request);

                json_obj_request["PatientId"] = mdi_db.LastInsertedId;
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
                mdi_db.Execute(SqlScriptName.Patient_Update, json_obj_request);

                json_obj_response.Add(mdi_db.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
}