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

                string hn = json_obj_request["Hn"].ToString();

                if (string.IsNullOrEmpty(hn))
                {
                    string json_his_patient_visit_text = his_http.GetPatientByVisitNo(json_obj_request["VisitNo"].ToString().PadLeft(3, '0'));

                    MiJsonObjectMultiList json_his_patient_visit = new MiJsonObjectMultiList(new MiJsonObjectList(json_his_patient_visit_text)["ListOfData"]);

                    if (json_his_patient_visit.Count > 0)
                        hn = json_his_patient_visit[0]["HN"].ToString();
                }

                string json_his_patient_text = his_http.GetPatientByHn(hn);

                if (his_http.EventFailure)
                    return his_http.Ack;

                MiJsonObjectList json_his_patient = new MiJsonObjectList(json_his_patient_text);
                hn = json_his_patient["HN"].ToString();

                if (string.IsNullOrEmpty(hn))
                    return new Ack() { AcknowledgementCode = "AR", TextMessage = "Hn {0} missing data" };

                IName name = new Name()
                {
                    Title = json_his_patient["InitialName"].ToString(),
                    FName = json_his_patient["FirstName"].ToString(),
                    LName = json_his_patient["LastName"].ToString(),
                    TitleEng = json_his_patient["InitialNameEnglish"].ToString(),
                    FNameEng = json_his_patient["FirstNameEnglish"].ToString(),
                    LNameEng = json_his_patient["LastNameEnglish"].ToString()
                };

                string patient_gender = "";
                switch (json_his_patient["Gender"].ToString())
                {
                    default: break;
                    case "1": patient_gender = "M"; break;
                    case "2": patient_gender = "F"; break;
                }
                DateTime patient_dob = Utilities.ToDateTime(json_his_patient["BirthDateTime"]);
                string patient_ssn = json_his_patient["IDCardNo"].ToString();
                string visit_no = json_his_patient["VN"].ToString();
                string admission_no = json_his_patient["AN"].ToString();

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

                json_obj_response["HN"] = json_his_patient["HN"].ToString();
                json_obj_response["VisitDate"] = Utilities.ToDateTime(json_his_patient["VisitDate"]);
                json_obj_response["VN"] = json_his_patient["VN"].ToString();
                json_obj_response["AN"] = json_his_patient["AN"].ToString();
                json_obj_response["Gender"] = json_his_patient["Gender"].ToString();
                json_obj_response["BodyWeight"] = json_obj_data["PatientWeight"].ToString();
                json_obj_response["Height"] = json_obj_data["PatientHeight"].ToString();
                json_obj_response["HNSmokingType"] = json_obj_data["SmokingStatus"].ToString();
                json_obj_response["SmokingRemarks"] = json_obj_data["SmokingHsi"].ToString();
                json_obj_response["ComaScaleE"] = json_obj_data["ComaEScore"].ToString();
                json_obj_response["ComaScaleM"] = json_obj_data["ComaMScore"].ToString();
                json_obj_response["ComaScaleV"] = json_obj_data["ComaVScore"].ToString();
                json_obj_response["ComaScaleT"] = (Utilities.ToInt(json_obj_data["ComaEScore"]) + Utilities.ToInt(json_obj_data["ComaMScore"]) + Utilities.ToInt(json_obj_data["ComaVScore"])).ToString();
                json_obj_response["CVP"] = json_obj_data["CVRiskScore"].ToString();
                json_obj_response["ComaScores"] = json_obj_data["NewsScore"].ToString();
                json_obj_response["FallRiskType"] = json_obj_data["FallRiskTypeUid"].ToString();
                
                json_obj_response["PulseRate"] = json_obj_data["PulseRate"].ToString();
                json_obj_response["Bpsys"] = json_obj_data["BloodPressure"].ToString();
                json_obj_response["BpSystolic"] = json_obj_data["BloodPressureSystolic"].ToString();
                json_obj_response["BpDiastolic"] = json_obj_data["BloodPressureDiastolic"].ToString();
                json_obj_response["O2Sat"] = json_obj_data["Spo2"].ToString();
                json_obj_response["Temperature"] = json_obj_data["Temperature"].ToString();
                json_obj_response["RespirationRate"] = json_obj_data["RespirationRate"].ToString();
                json_obj_response["PainScale"] = json_obj_data["PainScale"].ToString();
                json_obj_response["Remarks"] = json_obj_data["Comment"].ToString();

                json_obj_response["EntryByUserCode"] = (Utilities.GetFirstValue(new object[] { json_obj_data["ConfirmedByUid"].ToString(), ServiceConfig.HisEmpUidOfConfirmedResult }) ?? "").ToString();
                json_obj_response["EntryDateTime"] = Utilities.ToDateTime(json_obj_data["ModifiedOn"]);//.ToString("yyyyMMddHHmmss");

                his_http.SetData(json_obj_response);

                json_obj_response.Add(his_http.Ack);

                return json_obj_response;
            };

            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
    public class VSData
    {
        public VSData() { }

        public string ContextKey { get; set; }
        public string HN { get; set; }
        public string VisitDate { get; set; }
        public string VN { get; set; }
        public string AN { get; set; }
        /// <summary>
        /// 1 = ชาย, 2 = หญิง
        /// </summary>
        public string Gender { get; set; }
        public string EntryByUserCode { get; set; }
        public string EntryDateTime { get; set; }

        public string BodyWeight { get; set; }
        public string BpDiastolic { get; set; }
        public string Bpsys { get; set; } //New
        public string BpSystolic { get; set; }
        public string Height { get; set; }
        public string O2Sat { get; set; } //New
        public string PainScale { get; set; } //New
        public string PulseRate { get; set; }
        public string RespirationRate { get; set; }
        public string Temperature { get; set; }

        private string ANCFHSType { get; set; }
        private string BMIScaleType { get; set; }
        private string BMIValue { get; set; } //New
        private string ChestCm { get; set; }
        private string ChestExhalation { get; set; }
        private string ChestInhalation { get; set; }
        private string ComaScaleE { get; set; }
        private string ComaScaleEyesOpenType { get; set; }
        private string ComaScaleM { get; set; }
        private string ComaScaleMotorResponseType { get; set; }
        private string ComaScaleT { get; set; }
        private string ComaScaleV { get; set; }
        private string ComaScaleVerbralResponseType { get; set; }
        private string ComaScores { get; set; }
        private string CPP { get; set; }
        private string CranailExtraocularMoveDown { get; set; }
        private string CranailExtraocularMoveLeft { get; set; }
        private string CranailExtraocularMoveRight { get; set; }
        private string CranailExtraocularMoveUp { get; set; }
        private string CranailNerveFacialType { get; set; }
        private string CranailNerveGagReflexType { get; set; }
        private string CranailNerveHearingType { get; set; }
        private string CranailNervePTOSISType { get; set; }
        private string CranailNerveReflexType { get; set; }
        private string CranailNerveSwallowType { get; set; }
        private string CranailNerveVisionLeftLow { get; set; }
        private string CranailNerveVisionLeftUp { get; set; }
        private string CranailNerveVisionRightLow { get; set; }
        private string CranailNerveVisionRightUp { get; set; }
        private string Creatinine { get; set; }
        private string CrisisBpDiastolic { get; set; }
        private string CrisisBpSystolic { get; set; }
        private string CrisisO2SAT { get; set; }
        private string CrisisPulseRate { get; set; }
        private string CrisisRespirationRate { get; set; }
        private string CrisisTemperature { get; set; }
        private string CVP { get; set; }
        private string ETCO2 { get; set; }
        private string FallRiskType { get; set; }
        private string FallScore { get; set; }
        private string FatigueScores { get; set; }
        private string HeadCm { get; set; }
        private string ICP { get; set; }
        private string LeftLegMotorPowerGradeType { get; set; }
        private string LeftMotorPowerGradeType { get; set; }
        private string LeftPupilReactionType { get; set; }
        private string LeftPupilSizeType { get; set; }
        private string MAP { get; set; }
        private string NoFHS { get; set; }
        private string PostBpDiastolic { get; set; }
        private string PostBpSystolic { get; set; }
        private string PostPulseRate { get; set; }
        private string PostRespirationRate { get; set; }
        private string PostTemperature { get; set; }
        public string Remarks { get; set; }
        private string RightLegMotorPowerGradeType { get; set; }
        private string RightMotorPowerGradeType { get; set; }
        private string RightPupilReactionType { get; set; }
        private string RightPupilSizeType { get; set; }
        private string ShoulderCm { get; set; }
        private string SmokingRemarks { get; set; }
        private string TonemetryLeft { get; set; }
        private string TonemetryRight { get; set; }
        private string VentilatorFiO2 { get; set; }
        private string VentilatorFlowRate { get; set; }
        private string VentilatorMode { get; set; }
        private string VentilatorPEEP { get; set; }
        private string VentilatorPF { get; set; }
        private string VentilatorPS { get; set; }
        private string VentilatorRate { get; set; }
        private string VentilatorTV { get; set; }
        private string VisualAcuitivityLeft { get; set; }
        private string VisualAcuitivityRight { get; set; }
        private string VitalSignPerformanceStatus { get; set; }
        private string WaistLine { get; set; }
    }
}