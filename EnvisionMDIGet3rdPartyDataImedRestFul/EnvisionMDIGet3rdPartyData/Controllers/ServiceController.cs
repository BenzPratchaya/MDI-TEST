using EnvisionIE.Entity.Global;
using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using EnvisionIEService.WebService;
using EnvisionMDIGet3rdPartyData.Connection;
using System;
using System.Data;
using System.Web.Http;

namespace EnvisionMDIGet3rdPartyData.Controllers
{
    public class ServiceController : IeController
    {
        private const string controller_name = "Service";

        HisHttpConnection his_http = new HisHttpConnection(controller_name);
        MdiDbConnection mdi_db = new MdiDbConnection(controller_name);

        public ServiceController() : base(ServiceConfig.EnableTraceInbound) { }

        [HttpPost]
        [ActionName("GetPatient")]
        public object GetPatient([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_GetPatient";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                string json_his_patient_text = his_http.GetPatientByHn(json_obj_request["Hn"].ToString());

                if (his_http.EventFailure)
                    return his_http.Ack;

                MiJsonObjectList json_his_patient = new MiJsonObjectList(json_his_patient_text);
                string hn = json_his_patient["Hn"].ToString();

                if (string.IsNullOrEmpty(hn))
                    return new Ack() { AcknowledgementCode = "AR", TextMessage = "Hn {0} missing data" };

                IName name = new Name()
                {
                    Title = json_his_patient["patient_title"].ToString(),
                    FName = json_his_patient["patient_fname"].ToString(),
                    LName = json_his_patient["patient_lname"].ToString(),
                    TitleEng = json_his_patient["patient_title_eng"].ToString(),
                    FNameEng = json_his_patient["patient_fname_eng"].ToString(),
                    LNameEng = json_his_patient["patient_lname_eng"].ToString()
                };

                string patient_gender = json_his_patient["patient_gender"].ToString();
                DateTime patient_dob = Utilities.ToDateTime(json_his_patient["patient_dob"]);
                string patient_ssn = json_his_patient["patient_ssn"].ToString();
                string visit_no = json_his_patient["visit_no"].ToString();
                string admission_no = json_his_patient["admission_no"].ToString();

                DataTable dtt_patient = mdi_db.Patient_SelectByHn(hn);

                if (Utilities.HasData(dtt_patient))
                {
                    DataRow dr_patient = dtt_patient.Rows[0];

                    name = IeServiceUtility.ThaiToEngName(name, new Name()
                    {
                        Title = dr_patient["PatientTitle"].ToString(),
                        FName = dr_patient["PatientFName"].ToString(),
                        LName = dr_patient["PatientLName"].ToString(),
                        TitleEng = dr_patient["PatientTitleEng"].ToString(),
                        FNameEng = dr_patient["PatientFNameEng"].ToString(),
                        LNameEng = dr_patient["PatientLNameEng"].ToString()
                    });

                    mdi_db.Patient_Update(
                        Utilities.ToInt(dr_patient["PatientId"]),
                        name.Title,
                        name.FName,
                        name.LName,
                        name.TitleEng,
                        name.FNameEng,
                        name.LNameEng,
                        patient_gender,
                        patient_dob,
                        patient_ssn,
                        ServiceConfig.MdiDefaultEmpIdOfModify);
                }
                else
                {
                    name = IeServiceUtility.ThaiToEngName(name);

                    mdi_db.Patient_Insert(
                        hn,
                        name.Title,
                        name.FName,
                        name.LName,
                        name.TitleEng,
                        name.FNameEng,
                        name.LNameEng,
                        patient_gender,
                        patient_dob,
                        patient_ssn,
                        ServiceConfig.MdiDefaultOrganizationId,
                        ServiceConfig.MdiDefaultEmpIdOfModify);
                }

                json_obj_response["Hn"] = hn;
                json_obj_response["PatientTitle"] = name.Title;
                json_obj_response["PatientFname"] = name.FName;
                json_obj_response["PatientLname"] = name.LName;
                json_obj_response["PatientTitleEng"] = name.TitleEng;
                json_obj_response["PatientFnameEng"] = name.FNameEng;
                json_obj_response["PatientLnameEng"] = name.LNameEng;
                json_obj_response["PatientGender"] = patient_gender;
                json_obj_response["PatientDob"] = patient_dob;
                json_obj_response["PatientSsn"] = patient_ssn;
                json_obj_response["VisitNo"] = visit_no;
                json_obj_response["AdmissionNo"] = admission_no;
                json_obj_response.Add(new Ack() { AcknowledgementCode = "AA", TextMessage = "" });

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }

        [HttpPost]
        [ActionName("SetData")]
        public object SetData([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_SetData";

            Func<string, dynamic> func = delegate (string rawText)
            {
                MiJsonObjectList json_obj_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_obj_response = new MiJsonObjectList();

                MiJsonObjectMultiList json_objs_data = new MiJsonObjectMultiList(json_obj_request["Data_1"]);

                if (json_objs_data.Count == 0)
                {
                    json_obj_response.Add(new Ack()
                    {
                        AcknowledgementCode = "AR",
                        TextMessage = string.Join("->", new string[] { controller_name, "Data", "Data not found" })
                    });

                    return json_obj_response;
                }

                MiJsonObjectList json_obj_data = json_objs_data[0];

                string json_his_patient_text = his_http.GetPatientByHn(json_obj_data["Hn"].ToString());

                if (his_http.EventFailure)
                    return his_http.Ack;

                MiJsonObjectList json_his_patient = new MiJsonObjectList(json_his_patient_text);

                json_obj_response["hn"] = json_his_patient["hn"].ToString();
                json_obj_response["visit_no"] = json_his_patient["visit_no"].ToString();
                json_obj_response["admission_no"] = json_his_patient["admission_no"].ToString();
                json_obj_response["body_weight"] = json_obj_data["PatientWeight"].ToString();
                json_obj_response["height"] = json_obj_data["PatientHeight"].ToString();

                json_obj_response["pulse_rate"] = json_obj_data["PulseRate"].ToString();
                json_obj_response["bp_systolic"] = json_obj_data["BloodPressureSystolic"].ToString();
                json_obj_response["bp_diastolic"] = json_obj_data["BloodPressureDiastolic"].ToString();
                json_obj_response["o2sat"] = json_obj_data["Spo2"].ToString();
                json_obj_response["temperature"] = json_obj_data["Temperature"].ToString();
                json_obj_response["respiraation_rate"] = json_obj_data["RespirationRate"].ToString();

                json_obj_response["entry_user_code"] = (Utilities.GetFirstValue(new object[] { json_obj_data["ConfirmedByUid"].ToString(), ServiceConfig.HisEmpUidOfConfirmedResult }) ?? "").ToString();
                json_obj_response["entry_location_code"] = json_obj_data["SubLocationUid"].ToString();
                json_obj_response["entry_datetime"] = DateTime.Now.ToString("yyyyMMddHHmmss");

                his_http.SetData(json_obj_response.ToJsonString());

                json_obj_response.Add(his_http.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
}