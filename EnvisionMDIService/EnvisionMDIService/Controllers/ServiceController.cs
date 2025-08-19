using EnvisionIE.Entity.Global;
using EnvisionIE.Hl7;
using EnvisionIE.Hl7.Entity;
using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.WebService;
using EnvisionMDI.Entity;
using EnvisionMDIService.Connection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text.RegularExpressions;
using System.Web.Http;

namespace EnvisionMDIService.Controllers
{
    public class ServiceController : IeController
    {
        private const string controller_name = "Service";
        private readonly string format_date = "yyyyMMdd";
        private readonly string format_datetime = "yyyyMMddHHmmss";

        MdiDbConnection mdi_db = new MdiDbConnection(controller_name);
        ThirdPartyHttpConnection third_party_http = new ThirdPartyHttpConnection(controller_name);

        public ServiceController() : base(ServiceConfig.EnableTraceInbound) { }

        private string ToUnit(string value, string defaultValue = null)
        {
            value = value ?? "";
            defaultValue = defaultValue ?? value;

            switch (value.ToLower())
            {
                case "%": return "%";
                case "bpm": return "bpm";
                case "c": return "C";
                case "cm": return "cm";
                case "kg": return "Kg";
                case "mg/dl": return "mg/dL";
                case "mmhg": return "mmHg";
                case "rpm": return "rpm";
                default: return defaultValue;
            }
        }

        [HttpPost]
        [ActionName("GetMessage")]
        public object GetMessage([FromBody] dynamic raw)
        {
            string function_name = $"{controller_name}_GetMessage";

            dynamic func(string rawText)
            {
                MiJsonObjectList json_request = new MiJsonObjectList(rawText);
                MiJsonObjectList json_response = new MiJsonObjectList();

                string event_name = json_request["EventName"].ToString().ToLower();

                switch (event_name)
                {
                    default:
                        json_response.Add(new Ack()
                        {
                            AcknowledgementCode = "AA",
                            TextMessage = "Connected"
                        });
                        break;
                    case "direct":
                        {
                            Hl7Ack hl7_ack = GetMessage(json_request);
                            json_response.Add(new Ack()
                            {
                                AcknowledgementCode = hl7_ack.AcknowledgementCode,
                                TextMessage = hl7_ack.TextMessage
                            });
                        }
                        break;
                    case "received":
                        {
                            Hl7Message hl7_message = new Hl7Message(json_request["Message"].ToString());
                            if (hl7_message.ToMsh().SendingFacility.ToLower() == "welchallyn")
                                json_response.Add(GetMessageWelchAllyn(json_request));
                            else
                            {
                                Hl7Ack hl7_ack = GetMessage(json_request);
                                json_response.Add(new Ack()
                                {
                                    AcknowledgementCode = hl7_ack.AcknowledgementCode,
                                    TextMessage = Hl7AckConverter.ToHl7(hl7_ack)
                                });
                            }
                        }
                        break;
                }

                return json_response;
            }

            return SomeThing(function_name, raw, (Func<string, dynamic>)func).ToDictionary();
        }

        private Hl7Ack GetMessage(MiJsonObjectList json)
        {
            Hl7Ack hl7_ack = new Hl7Ack()
            {
                SendingApplication = "MDI",
                ReceivingApplication = "",
                MessageType = "ACK",
                MessageControlId = $"ACK_{DefaultValue.MessageControlId}",
                ProcessingId = "P",
                VersionId = "2.3"
            };

            Hl7Message hl7_message = new Hl7Message(json["Message"].ToString());
            Msh msh = hl7_message.ToMsh();
            hl7_ack.MessageControlId = msh.MessageControlId;
            hl7_ack.ProcessingId = msh.ProcessingId;
            hl7_ack.VersionId = msh.VersionId;

            Modality modality = mdi_db.Modality_Select(new Modality()
            {
                ModalityUid = hl7_message["ORC.18"],
                ModalityHost = json["ClientIp"].ToString()
            });

            if (modality == null)
            {
                hl7_ack.AcknowledgementCode = "AR";
                hl7_ack.TextMessage = "Modality not found";
                return hl7_ack;
            }

            if (modality.IsDeleted)
            {
                hl7_ack.AcknowledgementCode = "AR";
                hl7_ack.TextMessage = "Modality disable";
                return hl7_ack;
            }

            modality.ModalityHost = json["ClientIp"].ToString();

            MiJsonObjectList json_modality_log = new MiJsonObjectList(modality.ModalityLog);

            int patient_id = 0;
            string hn = Utilities.GetFirstValue(new object[] { hl7_message["PID.3"], hl7_message["PID.4"] }).ToString();
            string visit_no = "";

            if (string.IsNullOrEmpty(hn))
            {
                hl7_ack.AcknowledgementCode = "AR";
                hl7_ack.TextMessage = "Hn is null or empty";
                return hl7_ack;
            }

            if (hn == json_modality_log["Hn"].ToString() && Utilities.ToDateTime(json_modality_log["NextDateTime"]).Ticks > DateTime.Now.Ticks)
            {
                hl7_ack.AcknowledgementCode = "AR";
                hl7_ack.TextMessage = "Modality wait vitalsign interval";
                return hl7_ack;
            }

            MiJsonObjectList json_3rd_patient = new MiJsonObjectList(third_party_http.PostGetPatient(hn, modality.OrganizationId));

            if (!third_party_http.EventFailure)
                visit_no = json_3rd_patient["VisitNo"].ToString();

            mdi_db.Parameters = new DbParameter[] { mdi_db.Parameter("Hn", hn) };
            DataSet ds_mdi_patient = mdi_db.SelectDataSet(SqlScriptName.Patient_SelectByHn, null);

            if (Utilities.HasData(ds_mdi_patient))
                patient_id = Utilities.ToInt(ds_mdi_patient.Tables[0].Rows[0]["PatientId"]);

            if (patient_id < 1)
            {
                hl7_ack.AcknowledgementCode = "AR";
                hl7_ack.TextMessage = "Patient not found";
                return hl7_ack;
            }

            PatientVisit patient_visit = mdi_db.PatientVisit_SelectLastByPatientId(patient_id);

            Data data = null;

            if (patient_visit == null)
            {
                patient_visit = new PatientVisit()
                {
                    PatientId = patient_id,
                    VisitNo = visit_no
                };

                data = new Data();
            }
            else if (patient_visit.VisitNo != visit_no || patient_visit.CreatedOn.Date != DateTime.Today)
            {
                patient_visit.PatientVisitId = 0;
                patient_visit.VisitNo = (Utilities.GetFirstValue(visit_no, patient_visit.VisitNo) ?? "").ToString();

                data = new Data();
            }
            else
            {
                patient_visit.VisitNo = (Utilities.GetFirstValue(visit_no, patient_visit.VisitNo) ?? "").ToString();

                data = mdi_db.Data_SelectLastByPatientVisitId(patient_visit.PatientVisitId) ?? new Data();
            }


            DataLog data_log = new DataLog();

            patient_visit.LocationId = Utilities.ToInt(Utilities.GetFirstValue(new object[] { patient_visit.LocationId, modality.LocationId }));
            patient_visit.SubLocationId = Utilities.ToInt(Utilities.GetFirstValue(new object[] { patient_visit.SubLocationId, modality.SubLocationId }));
            patient_visit.PatientType = (Utilities.GetFirstValue(new object[] { hl7_message["PV1.18"], patient_visit.PatientType }) ?? "").ToString();

            bool flag_patient_visit_actived = false;
            bool flag_data_actived = false;

            try
            {
                foreach (Hl7Segment hl7_segment in hl7_message.Segments)
                {
                    if (hl7_segment.SegmentName.ToLower() != "obx")
                        continue;

                    string identifier = new Regex("[^a-zA-Z0-9]").Replace(hl7_segment["3.2"], "").ToLower();
                    string observation = hl7_segment["5.1"];
                    string unit = hl7_segment["6.2"];

                    string method = (Utilities.GetFirstValue(new object[] { hl7_segment["17.2"], hl7_segment["17.1"] }) ?? "").ToString();

                    if (string.IsNullOrEmpty(observation))
                        continue;

                    switch (identifier)
                    {
                        /*PatientVisit*/
                        case "update_patient_visit":
                            flag_patient_visit_actived = true;
                            break;
                        case "weight":
                            patient_visit.PatientWeight = Utilities.ToDecimal(observation);
                            patient_visit.PatientWeightUnit = ToUnit(unit, "kg");
                            goto case "update_patient_visit";
                        case "height":
                            patient_visit.PatientHeight = Utilities.ToDecimal(observation);
                            patient_visit.PatientHeightUnit = ToUnit(unit, "cm");
                            goto case "update_patient_visit";
                        case "bmi":
                            patient_visit.PatientBmi = Utilities.ToDecimal(observation);
                            goto case "update_patient_visit";
                        /*Data*/
                        case "update_data":
                            flag_data_actived = true;
                            break;
                        case "pulserate":
                        case "hrpulse":
                        case "hr":
                        case "pulse":
                            data_log.PulseRate = (int)(data.PulseRate = Utilities.ToInt(observation));
                            data_log.PulseUnit = data.PulseUnit = ToUnit(unit, "bpm");
                            data_log.PulseFlag = data.PulseFlag = hl7_segment["8.1"];
                            goto case "update_data";
                        case "bloodpressuresystolic":
                        case "nbps":
                            data_log.BloodPressureSystolic = (int)(data.BloodPressureSystolic = Utilities.ToInt(observation));
                            data_log.BloodPressureUnit = data.BloodPressureUnit = ToUnit(unit, Utilities.GetFirstValue(new object[] { data.BloodPressureUnit, "mmHg" }).ToString());
                            data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { method, data.BloodPressureMethod }) ?? "").ToString();
                            goto case "update_data";
                        case "bloodpressurediastolic":
                        case "nbpd":
                            data_log.BloodPressureDiastolic = (int)(data.BloodPressureDiastolic = Utilities.ToInt(observation));
                            data_log.BloodPressureUnit = data.BloodPressureUnit = ToUnit(unit, Utilities.GetFirstValue(new object[] { data.BloodPressureUnit, "mmHg" }).ToString());
                            data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { method, data.BloodPressureMethod }) ?? "").ToString();
                            goto case "update_data";
                        case "bloodpressuremean":
                        case "nbpm":
                            data_log.BloodPressureMean = (int)(data.BloodPressureMean = Utilities.ToInt(observation));
                            data_log.BloodPressureUnit = data.BloodPressureUnit = ToUnit(unit, Utilities.GetFirstValue(new object[] { data.BloodPressureUnit, "mmHg" }).ToString());
                            data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { method, data.BloodPressureMethod }) ?? "").ToString();
                            goto case "update_data";
                        case "nbplocation":
                            data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { observation.ToString(), data.BloodPressureMethod }) ?? "").ToString();
                            goto case "update_data";
                        case "spo2":
                            data_log.SpO2 = (decimal)(data.SpO2 = Utilities.ToDecimal(observation));
                            data_log.SpO2Unit = data.SpO2Unit = ToUnit(unit, "%");
                            goto case "update_data";
                        case "temperature":
                        case "temp":
                            data_log.Temperature = (decimal)(data.Temperature = Utilities.ToDecimal(observation));
                            data_log.TemperatureUnit = data.TemperatureUnit = ToUnit(unit, "C");
                            data_log.TemperatureMethod = data.TemperatureMethod = method;
                            goto case "update_data";
                        case "bloodglucose":
                        case "glucose":
                            data_log.BloodGlucose = (int)(data.BloodGlucose = Utilities.ToInt(observation));
                            data_log.BloodGlucoseUnit = data.BloodGlucoseUnit = ToUnit(unit, "mg/dL");
                            goto case "update_data";
                        case "respirationrate":
                        case "respiration":
                        case "resp":
                            data_log.RespirationRate = (int)(data.RespirationRate = Utilities.ToInt(observation));
                            goto case "update_data";
                        case "painindex":
                        case "painscale":
                        case "painscore":
                            data_log.PainScale = (int)(data.PainScale = Utilities.ToInt(observation));
                            goto case "update_data";
                    }
                }
            }
            catch (Exception ex)
            {
                hl7_ack.AcknowledgementCode = "AE";
                hl7_ack.TextMessage = "Prepare value " + ex.Message;
                return hl7_ack;
            }

            try
            {
                if (flag_patient_visit_actived || flag_data_actived)
                {
                    patient_visit.ModalityWhId = modality.ModalityId;
                    patient_visit.OrganizationId = modality.OrganizationId;
                    patient_visit.ModifiedBy = ServiceConfig.MdiEmpIdOfModify;

                    if (patient_visit.PatientBmi < 1
                        && patient_visit.PatientWeight > 0
                        && patient_visit.PatientHeight > 0)
                        patient_visit.PatientBmi = patient_visit.PatientWeight / (2 * patient_visit.PatientHeight);

                    if (patient_visit.PatientVisitId == 0)
                    {
                        if (!mdi_db.PatientVisit_Insert(patient_visit))
                        {
                            hl7_ack.AcknowledgementCode = "AE";
                            hl7_ack.TextMessage = "Patient visit create failure";
                            return hl7_ack;
                        }
                    }
                    else if (flag_patient_visit_actived)
                    {
                        if (!mdi_db.PatientVisit_Update(patient_visit))
                        {
                            hl7_ack.AcknowledgementCode = "AE";
                            hl7_ack.TextMessage = "Patient visit update failure";
                            return hl7_ack;
                        }
                    }

                    if (flag_data_actived)
                    {
                        if (data.IsConfirmed || data.ModalityVsId != modality.ModalityId)
                            data.DataId = 0;

                        data.PatientVisitId = patient_visit.PatientVisitId;
                        data.ModalityVsId = modality.ModalityId;
                        if (data.BloodPressureMean < 1 && data.BloodPressureSystolic > 0 && data.BloodPressureDiastolic > 0)
                            data.BloodPressureMean = (data.BloodPressureSystolic + (2 * data.BloodPressureDiastolic)) / 3;
                        data.BloodPressure = $"{data.BloodPressureSystolic}/{data.BloodPressureDiastolic}({data.BloodPressureMean})";
                        data.DataStatus = modality.AutoConfirm ? "C" : "N";
                        data.IsConfirmed = modality.AutoConfirm;
                        data.OrganizationId = modality.OrganizationId;
                        data.ModifiedBy = ServiceConfig.MdiEmpIdOfModify;

                        if (data.DataId == 0)
                        {
                            if (!mdi_db.Data_Insert(data))
                            {
                                hl7_ack.AcknowledgementCode = "AE";
                                hl7_ack.TextMessage = "Data create failure";
                                return hl7_ack;
                            }
                        }
                        else
                        {
                            if (!mdi_db.Data_Update(data))
                            {
                                hl7_ack.AcknowledgementCode = "AE";
                                hl7_ack.TextMessage = "Patient visit update failure";
                                return hl7_ack;
                            }
                        }

                        if (data.IsConfirmed)
                            third_party_http.PostSetDataByDataId(data.DataId, data.OrganizationId);

                        data_log.DataId = data.DataId;
                        data_log.ModalityVsId = modality.ModalityId;
                        if (data_log.BloodPressureMean < 1 && data_log.BloodPressureSystolic > 0 && data_log.BloodPressureDiastolic > 0)
                            data_log.BloodPressureMean = (data_log.BloodPressureSystolic + (2 * data_log.BloodPressureDiastolic)) / 3;
                        data_log.BloodPressure = $"{data_log.BloodPressureSystolic}/{data_log.BloodPressureDiastolic}({data_log.BloodPressureMean})";

                        mdi_db.DataLog_Insert(data_log);
                    }
                    else if (data.DataId > 0)
                    {
                        if (data.IsConfirmed)
                            third_party_http.PostSetDataByDataId(data.DataId, data.OrganizationId);
                    }
                    else if (modality.AutoConfirm)
                        third_party_http.PostSetDataByPatientVisitId(patient_visit.PatientVisitId, patient_visit.OrganizationId);

                    json_modality_log["Hn"] = hn;
                    json_modality_log["NextDateTime"] = DateTime.Now.AddSeconds(modality.VitalsignInterval);

                    modality.ModalityLog = json_modality_log.ToJsonString();

                    mdi_db.Modality_UpdateModalityLog(modality);

                    hl7_ack.AcknowledgementCode = "AA";
                    hl7_ack.TextMessage = "Success";
                    return hl7_ack;
                }
                else
                {
                    hl7_ack.AcknowledgementCode = "AA";
                    hl7_ack.TextMessage = "Undefined";
                    return hl7_ack;
                }
            }
            catch (Exception ex)
            {
                hl7_ack.AcknowledgementCode = "AE";
                hl7_ack.TextMessage = "Insert value " + ex.Message;
                return hl7_ack;
            }
        }
        private Ack GetMessageWelchAllyn(MiJsonObjectList json)
        {
            Hl7Message hl7_message = new Hl7Message(json["Message"].ToString());
            Msh msh = hl7_message.ToMsh();
            Ack ack = new Ack();

            Modality modality = mdi_db.Modality_Select(new Modality() { ModalityHost = json["ClientIp"].ToString(), ModalityUid = (Utilities.GetFirstValue( hl7_message["QRD.13"].ToString(), hl7_message["OBX.18.1"].ToString()) ?? "").ToString() });
            if (modality == null)
            {
                ack.AcknowledgementCode = "AR";
                ack.TextMessage = "Modality not found";
                return func_hl7_ack_convert();
            }
            if (modality.IsDeleted)
            {
                ack.AcknowledgementCode = "AR";
                ack.TextMessage = "Modality disable";
                return func_hl7_ack_convert();
            }

            MiJsonObjectList json_modality_log = new MiJsonObjectList(modality.ModalityLog);

            switch (msh.MessageType.ToLower())
            {
                default:
                    ack.AcknowledgementCode = "AR";
                    ack.TextMessage = "MessageType invalid";
                    return func_hl7_ack_convert();
                case "qry":
                    {
                        switch (msh.EventType.ToLower())
                        {
                            default:
                                ack.AcknowledgementCode = "AR";
                                ack.TextMessage = "EventType invalid";
                                return func_hl7_ack_convert();
                            case "a19":
                                try
                                {
                                    string hn = Utilities.ToCleanString(hl7_message["QRD.8"]);
                                    string visit_no = "";
                                    if (string.IsNullOrEmpty(hn))
                                    {
                                        ack.AcknowledgementCode = "AR";
                                        ack.TextMessage = "Hn is null or empty";
                                        return func_hl7_ack_qry_a19_convert(hn);
                                    }

                                    MiJsonObjectList json_3rd_patient = new MiJsonObjectList(third_party_http.PostGetPatient(hn, modality.OrganizationId));
                                    if (!third_party_http.EventFailure) visit_no = json_3rd_patient["VisitNo"].ToString();

                                    mdi_db.Parameters = new DbParameter[] { mdi_db.Parameter("Hn", hn) };
                                    DataSet ds_mdi_patient = mdi_db.SelectDataSet(SqlScriptName.Patient_SelectByHn, null);
                                    if (!Utilities.HasData(ds_mdi_patient))
                                    {
                                        ack.AcknowledgementCode = "AR";
                                        ack.TextMessage = "Patient not found";
                                        return func_hl7_ack_qry_a19_convert(hn);
                                    }
                                    DataRow dr_mdi_patient = ds_mdi_patient.Tables[0].Rows[0];
                                    return func_hl7_ack_qry_a19_convert(hn, visit_no, new Patient()
                                    {
                                        Hn = dr_mdi_patient["Hn"].ToString(),
                                        PatientTitle = dr_mdi_patient["PatientTitle"].ToString(),
                                        PatientFName = dr_mdi_patient["PatientFName"].ToString(),
                                        PatientMName = dr_mdi_patient["PatientMName"].ToString(),
                                        PatientLName = dr_mdi_patient["PatientLName"].ToString(),
                                        PatientTitleEng = dr_mdi_patient["PatientTitleEng"].ToString(),
                                        PatientFNameEng = dr_mdi_patient["PatientFNameEng"].ToString(),
                                        PatientMNameEng = dr_mdi_patient["PatientMNameEng"].ToString(),
                                        PatientLNameEng = dr_mdi_patient["PatientLNameEng"].ToString(),
                                        PatientGender = dr_mdi_patient["PatientDob"].ToString(),
                                        PatientDob = Utilities.ToDateTime(dr_mdi_patient["PatientDob"]),
                                        PatientSsn = dr_mdi_patient["PatientSsn"].ToString()
                                    });
                                }
                                catch (Exception ex)
                                {
                                    ack.AcknowledgementCode = "AE";
                                    ack.TextMessage = ex.Message;
                                    return func_hl7_ack_qry_a19_convert(hl7_message["QRD.8"]);
                                }
                        }
                    }
                case "oru":
                    {
                        switch (msh.EventType.ToLower())
                        {
                            default:
                                ack.AcknowledgementCode = "AR";
                                ack.TextMessage = "EventType invalid";
                                return func_hl7_ack_convert();
                            case "r01":
                                try
                                {
                                    int patient_id = 0;
                                    string hn = Utilities.ToCleanString(hl7_message["PID.3"]);
                                    string visit_no = "";
                                    if (string.IsNullOrEmpty(hn))
                                    {
                                        ack.AcknowledgementCode = "AR";
                                        ack.TextMessage = "Hn is null or empty";
                                        return func_hl7_ack_convert();
                                    }
                                    if (hn == json_modality_log["Hn"].ToString() && Utilities.ToDateTime(json_modality_log["NextDateTime"]).Ticks > DateTime.Now.Ticks)
                                    {
                                        ack.AcknowledgementCode = "AR";
                                        ack.TextMessage = "Modality wait vitalsign interval";
                                        return func_hl7_ack_convert();
                                    }

                                    MiJsonObjectList json_3rd_patient = new MiJsonObjectList(third_party_http.PostGetPatient(hn, modality.OrganizationId));
                                    if (!third_party_http.EventFailure) visit_no = json_3rd_patient["VisitNo"].ToString();

                                    mdi_db.Parameters = new DbParameter[] { mdi_db.Parameter("Hn", hn) };
                                    DataSet ds_mdi_patient = mdi_db.SelectDataSet(SqlScriptName.Patient_SelectByHn, null);
                                    if (!Utilities.HasData(ds_mdi_patient))
                                    {
                                        ack.AcknowledgementCode = "AR";
                                        ack.TextMessage = "Patient not found";
                                        return func_hl7_ack_convert();
                                    }

                                    patient_id = Utilities.ToInt(ds_mdi_patient.Tables[0].Rows[0]["PatientId"]);

                                    PatientVisit patient_visit = mdi_db.PatientVisit_SelectLastByPatientId(patient_id);
                                    Data data = null;
                                    if (patient_visit == null)
                                    {
                                        patient_visit = new PatientVisit()
                                        {
                                            PatientId = patient_id,
                                            VisitNo = visit_no
                                        };

                                        data = new Data();
                                    }
                                    else if (patient_visit.VisitNo != visit_no || patient_visit.CreatedOn.Date != DateTime.Today)
                                    {
                                        patient_visit.PatientVisitId = 0;
                                        patient_visit.VisitNo = (Utilities.GetFirstValue(visit_no, patient_visit.VisitNo) ?? "").ToString();

                                        data = new Data();
                                    }
                                    else
                                    {
                                        patient_visit.VisitNo = (Utilities.GetFirstValue(visit_no, patient_visit.VisitNo) ?? "").ToString();

                                        data = mdi_db.Data_SelectLastByPatientVisitId(patient_visit.PatientVisitId) ?? new Data();
                                    }

                                    DataLog data_log = new DataLog();
                                    patient_visit.LocationId = Utilities.ToInt(Utilities.GetFirstValue(new object[] { patient_visit.LocationId, modality.LocationId }));
                                    patient_visit.SubLocationId = Utilities.ToInt(Utilities.GetFirstValue(new object[] { patient_visit.SubLocationId, modality.SubLocationId }));
                                    patient_visit.PatientType = (Utilities.GetFirstValue(new object[] { hl7_message["PV1.18"], patient_visit.PatientType }) ?? "").ToString();

                                    bool flag_patient_visit_actived = false;
                                    bool flag_data_actived = false;
                                    foreach (Hl7Segment hl7_segment in hl7_message.Segments)
                                    {
                                        if (hl7_segment.SegmentName.ToLower() != "obx") continue;

                                        string observation = hl7_segment["5.1"];
                                        if (string.IsNullOrEmpty(observation)) continue;

                                        string identifier = new Regex("[^a-zA-Z0-9]").Replace(hl7_segment["3.2"], "").ToLower();
                                        string unit = "";// hl7_segment["6.2"];
                                        string method = (Utilities.GetFirstValue(new object[] { hl7_segment["17.2"], hl7_segment["17.1"] }) ?? "").ToString();

                                        switch (identifier)
                                        {
                                            /*PatientVisit*/
                                            case "update_patient_visit": flag_patient_visit_actived = true; break;
                                            case "weight":
                                            case "mdcattrptweight": //WelchAllyn
                                                patient_visit.PatientWeight = Utilities.ToDecimal(observation);
                                                patient_visit.PatientWeightUnit = ToUnit("kg");
                                                goto case "update_patient_visit";
                                            case "height":
                                            case "mdcattrptheight": //WelchAllyn
                                                patient_visit.PatientHeight = Utilities.ToDecimal(observation);
                                                patient_visit.PatientHeightUnit = ToUnit(unit, "cm");
                                                goto case "update_patient_visit";
                                            case "bmi":
                                                patient_visit.PatientBmi = Utilities.ToDecimal(observation);
                                                goto case "update_patient_visit";
                                            /*Data*/
                                            case "update_data": flag_data_actived = true; break;
                                            case "pulserate":
                                            case "hrpulse":
                                            case "hr":
                                            case "pulse":
                                            case "mdcpulsratenoninv": //WelchAllyn
                                                data_log.PulseRate = (int)(data.PulseRate = Utilities.ToInt(observation));
                                                data_log.PulseUnit = data.PulseUnit = ToUnit(unit, "bpm");
                                                data_log.PulseFlag = data.PulseFlag = hl7_segment["8.1"];
                                                goto case "update_data";
                                            case "bloodpressuresystolic":
                                            case "nbps":
                                            case "mdcpressbldnoninvsys": //WelchAllyn
                                                data_log.BloodPressureSystolic = (int)(data.BloodPressureSystolic = Utilities.ToInt(observation));
                                                data_log.BloodPressureUnit = data.BloodPressureUnit = ToUnit(unit, Utilities.GetFirstValue(new object[] { data.BloodPressureUnit, "mmHg" }).ToString());
                                                data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { method, data.BloodPressureMethod }) ?? "").ToString();
                                                goto case "update_data";
                                            case "bloodpressurediastolic":
                                            case "nbpd":
                                            case "mdcpressbldnoninvdia": //WelchAllyn
                                                data_log.BloodPressureDiastolic = (int)(data.BloodPressureDiastolic = Utilities.ToInt(observation));
                                                data_log.BloodPressureUnit = data.BloodPressureUnit = ToUnit(unit, Utilities.GetFirstValue(new object[] { data.BloodPressureUnit, "mmHg" }).ToString());
                                                data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { method, data.BloodPressureMethod }) ?? "").ToString();
                                                goto case "update_data";
                                            case "bloodpressuremean":
                                            case "nbpm":
                                                data_log.BloodPressureMean = (int)(data.BloodPressureMean = Utilities.ToInt(observation));
                                                data_log.BloodPressureUnit = data.BloodPressureUnit = ToUnit(unit, Utilities.GetFirstValue(new object[] { data.BloodPressureUnit, "mmHg" }).ToString());
                                                data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { method, data.BloodPressureMethod }) ?? "").ToString();
                                                goto case "update_data";
                                            case "nbplocation":
                                                data_log.BloodPressureMethod = data.BloodPressureMethod = (Utilities.GetFirstValue(new object[] { observation.ToString(), data.BloodPressureMethod }) ?? "").ToString();
                                                goto case "update_data";
                                            case "spo2":
                                            case "mdcpulsoximsato2": //WelchAllyn
                                                data_log.SpO2 = (decimal)(data.SpO2 = Utilities.ToDecimal(observation));
                                                data_log.SpO2Unit = data.SpO2Unit = ToUnit(unit, "%");
                                                goto case "update_data";
                                            case "temperature":
                                            case "temp":
                                            case "mdctemp": //WelchAllyn
                                                data_log.Temperature = (decimal)(data.Temperature = Utilities.ToDecimal(observation));
                                                data_log.TemperatureUnit = data.TemperatureUnit = ToUnit(unit, "C");
                                                data_log.TemperatureMethod = data.TemperatureMethod = method;
                                                goto case "update_data";
                                            case "bloodglucose":
                                            case "glucose":
                                                data_log.BloodGlucose = (int)(data.BloodGlucose = Utilities.ToInt(observation));
                                                data_log.BloodGlucoseUnit = data.BloodGlucoseUnit = ToUnit(unit, "mg/dL");
                                                goto case "update_data";
                                            case "respirationrate":
                                            case "respiration":
                                            case "resp":
                                            case "mdcresprate": //WelchAllyn
                                                data_log.RespirationRate = (int)(data.RespirationRate = Utilities.ToInt(observation));
                                                goto case "update_data";
                                            case "painindex":
                                            case "painscale":
                                            case "painscore":
                                            case "painlevel": //WelchAllyn
                                                data_log.PainScale = (int)(data.PainScale = Utilities.ToInt(observation));
                                                goto case "update_data";
                                        }
                                    }

                                    if (flag_patient_visit_actived || flag_data_actived)
                                    {
                                        patient_visit.ModalityWhId = modality.ModalityId;
                                        patient_visit.OrganizationId = modality.OrganizationId;
                                        patient_visit.ModifiedBy = ServiceConfig.MdiEmpIdOfModify;

                                        if (patient_visit.PatientBmi < 1
                                            && patient_visit.PatientWeight > 0
                                            && patient_visit.PatientHeight > 0)
                                            patient_visit.PatientBmi = patient_visit.PatientWeight / (2 * patient_visit.PatientHeight);

                                        if (patient_visit.PatientVisitId == 0)
                                        {
                                            if (!mdi_db.PatientVisit_Insert(patient_visit))
                                            {
                                                ack.AcknowledgementCode = "AE";
                                                ack.TextMessage = "Patient visit create failure";
                                                return func_hl7_ack_convert();
                                            }
                                        }
                                        else if (flag_patient_visit_actived)
                                        {
                                            if (!mdi_db.PatientVisit_Update(patient_visit))
                                            {
                                                ack.AcknowledgementCode = "AE";
                                                ack.TextMessage = "Patient visit update failure";
                                                return func_hl7_ack_convert();
                                            }
                                        }

                                        if (flag_data_actived)
                                        {
                                            if (data.IsConfirmed || data.ModalityVsId != modality.ModalityId)
                                                data.DataId = 0;

                                            data.PatientVisitId = patient_visit.PatientVisitId;
                                            data.ModalityVsId = modality.ModalityId;
                                            //if (data.BloodPressureMean < 1 && data.BloodPressureSystolic > 0 && data.BloodPressureDiastolic > 0)
                                            data.BloodPressureMean = (data.BloodPressureSystolic + (2 * data.BloodPressureDiastolic)) / 3;
                                            data.BloodPressure = $"{data.BloodPressureSystolic}/{data.BloodPressureDiastolic}({data.BloodPressureMean})";
                                            data.DataStatus = modality.AutoConfirm ? "C" : "N";
                                            data.IsConfirmed = modality.AutoConfirm;
                                            data.OrganizationId = modality.OrganizationId;
                                            data.ModifiedBy = ServiceConfig.MdiEmpIdOfModify;

                                            if (data.DataId == 0)
                                            {
                                                if (!mdi_db.Data_Insert(data))
                                                {
                                                    ack.AcknowledgementCode = "AE";
                                                    ack.TextMessage = "Data create failure";
                                                    return func_hl7_ack_convert();
                                                }
                                            }
                                            else
                                            {
                                                if (!mdi_db.Data_Update(data))
                                                {
                                                    ack.AcknowledgementCode = "AE";
                                                    ack.TextMessage = "Patient visit update failure";
                                                    return func_hl7_ack_convert();
                                                }
                                            }

                                            if (data.IsConfirmed)
                                                third_party_http.PostSetDataByDataId(data.DataId, data.OrganizationId);

                                            data_log.DataId = data.DataId;
                                            data_log.ModalityVsId = modality.ModalityId;
                                            if (data_log.BloodPressureMean < 1 && data_log.BloodPressureSystolic > 0 && data_log.BloodPressureDiastolic > 0)
                                                data_log.BloodPressureMean = (data_log.BloodPressureSystolic + (2 * data_log.BloodPressureDiastolic)) / 3;
                                            data_log.BloodPressure = $"{data_log.BloodPressureSystolic}/{data_log.BloodPressureDiastolic}({data_log.BloodPressureMean})";

                                            mdi_db.DataLog_Insert(data_log);
                                        }
                                        else if (data.DataId > 0)
                                        {
                                            if (data.IsConfirmed)
                                                third_party_http.PostSetDataByDataId(data.DataId, data.OrganizationId);
                                        }
                                        else if (modality.AutoConfirm)
                                            third_party_http.PostSetDataByPatientVisitId(patient_visit.PatientVisitId, patient_visit.OrganizationId);

                                        json_modality_log["Hn"] = hn;
                                        json_modality_log["NextDateTime"] = DateTime.Now.AddSeconds(modality.VitalsignInterval);

                                        modality.ModalityLog = json_modality_log.ToJsonString();
                                        mdi_db.Modality_UpdateModalityLog(modality);

                                        ack.AcknowledgementCode = "AA";
                                        ack.TextMessage = "Success";
                                        return func_hl7_ack_convert();
                                    }
                                    else
                                    {
                                        ack.AcknowledgementCode = "AA";
                                        ack.TextMessage = "Undefined";
                                        return func_hl7_ack_convert();
                                    }
                                }
                                catch (Exception ex)
                                {
                                    ack.AcknowledgementCode = "AE";
                                    ack.TextMessage = ex.Message;
                                    return func_hl7_ack_convert();
                                }
                        }
                    }
            }

            Ack func_hl7_ack_convert()
            {
                ack.TextMessage = Hl7Manager.ConcatSegment(
                    func_msh_segment("ACK"),
                    func_msa_segment());
                return ack;
            };
            Ack func_hl7_ack_qry_a19_convert(string hn, string visitNo = null, Patient patient = null)
            {
                if (patient == null)
                {
                    ack.TextMessage = Hl7Manager.ConcatSegment(
                        func_msh_segment("RSP", "K22"),
                        func_msa_segment(),
                        func_qak_segment(),
                        func_qpd_segment(hn));
                }
                else
                {
                    ack.TextMessage = Hl7Manager.ConcatSegment(
                        func_msh_segment("RSP", "K22"),
                        func_msa_segment(),
                        func_qak_segment(),
                        func_qpd_segment(hn),
                        func_pid_segment(patient),
                        func_pv1_segment(visitNo));
                }
                return ack;
            };

            string func_msh_segment(string messageType, string eventType = null)
            {
                return Hl7Manager.ConcatField(new List<string>(new string[64])
                {
                    [0] = "MSH",
                    [1] = "^~\\&",
                    [2] = msh.ReceivingApplication,
                    [3] = msh.ReceivingFacility,
                    [4] = msh.SendingApplication,
                    [5] = msh.SendingFacility,
                    [6] = DateTime.Now.ToString(format_datetime),
                    [7] = "",
                    [8] = Hl7Manager.ConcatComponent(messageType, eventType),
                    [9] = $"{messageType}_{DefaultValue.MessageControlId}",
                    [10] = msh.ProcessingId,
                    [11] = msh.VersionId,
                    [12] = "",
                    [13] = "",
                    [14] = msh.AcceptAcknowledgementType
                }.ToArray());
            }
            string func_msa_segment()
            {
                return Hl7Manager.ConcatField(new List<string>(new string[64])
                {
                    [0] = "MSA",
                    [1] = ack.AcknowledgementCode,
                    [2] = msh.MessageControlId,
                    [3] = ack.TextMessage
                }.ToArray());
            }
            string func_qak_segment()
            {
                return Hl7Manager.ConcatField(new List<string>(new string[64])
                {
                    [0] = "MSA",
                    [1] = ack.AcknowledgementCode,
                    [2] = msh.MessageControlId,
                    [3] = ack.TextMessage
                }.ToArray());
            }
            string func_qpd_segment(string hn)
            {
                return Hl7Manager.ConcatField(new List<string>(new string[64])
                {
                    [0] = "QPD",
                    [1] = "PatientQuery",
                    [2] = DateTime.Now.ToString(format_datetime),
                    [3] = $"@PID.3.1^{hn}"
                }.ToArray());
            }
            string func_pid_segment(Patient patient)
            {
                return Hl7Manager.ConcatField(new List<string>(new string[64])
                {
                    [0] = "PID",
                    [1] = "",
                    [2] = "",
                    [3] = patient.Hn,
                    [4] = "",
                    [5] = Hl7Manager.ConcatComponent(
                        patient.PatientFName,
                        patient.PatientLName,
                        patient.PatientMName,
                        "",
                        patient.PatientTitle),
                    [6] = "",
                    [7] = Utilities.ToString(patient.PatientDob.GetValueOrDefault(DateTime.MinValue), format_date),
                    [8] = patient.PatientGender
                }.ToArray());
            }
            string func_pv1_segment(string visitNo)
            {
                return Hl7Manager.ConcatField(new List<string>(new string[64])
                {
                    [0] = "PV1",
                    [1] = "",
                    [2] = "",
                    [3] = "",
                    [4] = "",
                    [5] = "",
                    [6] = "",
                    [7] = "",
                    [8] = "",
                    [9] = "",
                    [10] = "",
                    [11] = "",
                    [12] = "",
                    [13] = "",
                    [14] = "",
                    [15] = "",
                    [16] = "",
                    [17] = "",
                    [18] = "",
                    [19] = visitNo
                }.ToArray());
            }
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
                int organization_id = Utilities.ToInt(json_obj_request["OrganizationId"]);
                int data_id = Utilities.ToInt(json_obj_request["DataId"]);
                if (data_id > 0)
                    third_party_http.PostSetDataByDataId(data_id, organization_id);
                return json_obj_response;
            };
            return SomeThing(function_name, raw, func).ToDictionary();
        }
    }
}