using EnvisionIE.Connection.Engine;
using EnvisionIE.Entity.Global;
using EnvisionIE.Operational;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using EnvisionMDI.Entity;
using MySqlConnector;
using System;
using System.Data;
using System.Data.Common;

namespace EnvisionMDIService.Connection
{
    public enum SqlScriptName
    {
        Data_SelectByDataId,
        Data_SelectNonConfirmByModalityId,
        Data_SelectNonConfirmByHn,
        Data_SelectNonConfirmByVN,
        Data_SelectLastVisitByHn,
        Data_SelectViewByDate,
        Data_SelectViewByDateWithLocationId,
        Data_SelectViewByHn,
        Data_SelectSend3rdPartyByDataId,
        Data_SelectSend3rdPartyByPatientVisitId,

        DataLog_SelectByDataId,

        Data_Insert,
        Data_Update,
        Data_UpdateIsConfirm,
        Data_UpdateReconcile,

        Location_SelectView,
        Location_SelectByUid,
        Location_SelectViewWithDeleted,
        Location_Insert,
        Location_Update,

        Modality_SelectByModalityUid,
        Modality_SelectView,
        Modality_SelectViewWithDeleted,
        Modality_Insert,
        Modality_Update,

        Organization_SelectView,
        Organization_SelectByUid,
        Organization_SelectById,
        Organization_SelectViewWithDeleted,
        Organization_Insert,
        Organization_Update,

        Patient_SelectByHn,
        Patient_Insert,
        Patient_Update,

        PatientVisit_Update,

        SubLocation_SelectView,
        SubLocation_SelectViewByLocationId,
        SubLocation_SelectViewBySubLocationUidAndDate,
        SubLocation_SelectViewBySubLocationUidAndHn,
        SubLocation_SelectViewWithDeleted,
        SubLocation_Insert,
        SubLocation_Update,

        User_SelectLogin,
        User_SelectView,
        User_SelectViewWithDeleted,
        User_Insert,
        User_Update,

        General_SelectView,
        General_SelectViewByGroup,
        General_Insert,
        General_Update
    }
    public class MdiDbConnection : MySqlEngine, IDisposable
    {
        private const string class_name = "MdiDbConnection";

        private bool disposed = false;

        public MdiDbConnection(string controller) : base(ServiceConfig.MdiDbConnectionString)
        {
            Callback += delegate (EngineCallbackEventArgs e)
            {
                if (e.EventFailure || ServiceConfig.MdiDbEnableTrace)
                {
                    IeServiceLog.Save(new IeLog()
                    {
                        OwnerName = IeServiceConfig.ServiceName,
                        ThirdPartyName = "MdiDb",

                        Connection = e.Connection,

                        EventName = e.EventName,
                        EventData = e.EventData,

                        AcknowledgementCode = e.AcknowledgementCode,
                        TextMessage = e.TextMessage
                    });
                }
            };
        }
        ~MdiDbConnection() { Dispose(); }

        public override void Dispose()
        {
            if (disposed)
                return;

            base.Dispose();

            disposed = true;
        }

        public DataSet SelectDataSet(SqlScriptName scriptName, object obj)
        {
            IDbScript db_script = ServiceConfig.GetSqlScript(scriptName.ToString());

            if (db_script == null)
            {
                Ack.AcknowledgementCode = "AR";
                Ack.TextMessage = string.Format($"{class_name}->Script not exist");

                OnCallback(new EngineCallbackEventArgs()
                {
                    Connection = ConnectionString,
                    EventName = $"SelectDataSet",
                    EventData = EventData,
                    AcknowledgementCode = Ack.AcknowledgementCode,
                    TextMessage = Ack.TextMessage
                });

                return null;
            }
            else
                return SelectDataSet(db_script, obj);
        }
        public DataTable SelectDataTable(SqlScriptName scriptName, object obj)
        {
            IDbScript db_script = ServiceConfig.GetSqlScript(scriptName.ToString());

            if (db_script == null)
            {
                Ack.AcknowledgementCode = "AR";
                Ack.TextMessage = string.Format($"{class_name}->Script not exist");

                OnCallback(new EngineCallbackEventArgs()
                {
                    Connection = ConnectionString,
                    EventName = $"SelectDataTable",
                    EventData = EventData,
                    AcknowledgementCode = Ack.AcknowledgementCode,
                    TextMessage = Ack.TextMessage
                });

                return null;
            }
            else
                return SelectDataTable(db_script, obj);
        }
        public bool Execute(SqlScriptName scriptName, object obj, MySqlTransaction transaction = null)
        {
            IDbScript db_script = ServiceConfig.GetSqlScript(scriptName.ToString());

            if (db_script == null)
            {
                Ack.AcknowledgementCode = "AR";
                Ack.TextMessage = string.Format($"{class_name}->Script not exist");

                OnCallback(new EngineCallbackEventArgs()
                {
                    Connection = ConnectionString,
                    EventName = $"Execute",
                    EventData = EventData,
                    AcknowledgementCode = Ack.AcknowledgementCode,
                    TextMessage = Ack.TextMessage
                });

                return false;
            }
            else
                return Execute(db_script, obj, transaction);
        }

        #region Organization
        private const string select_organization_1 = @"
select
    `org`.`org_id` as OrganizationId,
    `org`.`third_party_encoding` as ThirdPartyEncoding,
    `org`.`third_party_url` as ThirdPartyUrl
from
	`gbl_env` `org`
{0}
limit
    0, 1";

        private Organization ConvertToEntityOrganization(DataRow data)
        {
            if (data == null)
                return null;

            return new Organization()
            {
                OrganizationId = Utilities.ToInt(data["OrganizationId"]),

                ThirdPartyEncoding = Utilities.ToEncoding(data["ThirdPartyEncoding"]),
                ThirdPartyUrl = data["ThirdPartyUrl"].ToString()
            };
        }

        public Organization Organization_Select(Organization entity)
        {
            Organization entity_exist = null;

            entity_exist = Organization_SelectByOrganizationId(entity.OrganizationId);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public Organization Organization_SelectByOrganizationId(int organizationId)
        {
            CleanAck();

            if (organizationId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("OrganizationId", organizationId) };
            DataTable dtt = SelectDataTable(string.Format(select_organization_1, "where `org`.`org_id` = @OrganizationId", "Organization_SelectByOrganizationId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityOrganization(dtt.Rows[0]);

            return null;
        }
        #endregion

        #region PatientVisit
        private const string select_patient_visit_1 = @"

select
	`patient_visit`.`patient_visit_id` as `PatientVisitId`,
	`patient_visit`.`patient_id` as `PatientId`,
	`patient_visit`.`location_id` as `LocationId`,
	`patient_visit`.`sub_location_id` as `SubLocationId`,
	`patient_visit`.`visit_no` as `VisitNo`,
	`patient_visit`.`pat_type` as `PatientType`,
	`patient_visit`.`modality_wh_id` as `ModalityWhId`,
	`patient_visit`.`wh_dt` as `WhDateTime`,
	`patient_visit`.`pat_weight` as `PatientWeight`,
	`patient_visit`.`weight_unit` as `PatientWeightUnit`,
	`patient_visit`.`pat_height` as `PatientHeight`,
	`patient_visit`.`height_unit` as `PatientHeightUnit`,
	`patient_visit`.`pat_bmi` as `PatientBmi`,
	`patient_visit`.`org_id` as `OrganizationId`,
	`patient_visit`.`created_on` as `CreatedOn`
from
	`mdi_patient_visit` `patient_visit`
{0}
limit 0, 1";

        private PatientVisit ConvertToEntityPatientVisit(DataRow data)
        {
            if (data == null)
                return null;

            return new PatientVisit()
            {
                PatientVisitId = Utilities.ToInt(data["PatientVisitId"]),
                PatientId = Utilities.ToInt(data["PatientId"]),
                LocationId = Utilities.ToInt(data["LocationId"]),
                SubLocationId = Utilities.ToInt(data["SubLocationId"]),

                VisitNo = data["VisitNo"].ToString(),
                PatientType = data["PatientType"].ToString(),

                ModalityWhId = Utilities.ToInt(data["ModalityWhId"]),
                WhDateTime = Utilities.ToDateTime(data["WhDateTime"]),
                PatientWeight = Utilities.ToDecimal(data["PatientWeight"]),
                PatientWeightUnit = data["PatientWeightUnit"].ToString(),
                PatientHeight = Utilities.ToDecimal(data["PatientHeight"]),
                PatientHeightUnit = data["PatientHeightUnit"].ToString(),
                PatientBmi = Utilities.ToDecimal(data["PatientBmi"]),

                OrganizationId = Utilities.ToInt(data["OrganizationId"]),
                CreatedOn = Utilities.ToDateTime(data["CreatedOn"])
            };
        }

        public PatientVisit PatientVisit_SelectLastByPatientId(int patientId)
        {
            CleanAck();

            if (patientId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("PatientId", patientId) };
            DataTable dtt = SelectDataTable(string.Format(select_patient_visit_1, @"where
	`patient_visit`.`patient_id` = @PatientId
order by
	`patient_visit`.`created_on` desc", "PatientVisit_SelectLastByPatientIdAndToDay"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityPatientVisit(dtt.Rows[0]);

            return null;
        }
        public PatientVisit PatientVisit_SelectLastByPatientIdAndVisitNo(int patientId, string visitNo)
        {
            CleanAck();

            if (patientId < 1 || string.IsNullOrEmpty(visitNo))
                return null;

            Parameters = new DbParameter[] {
                Parameter("PatientId", patientId),
                Parameter("VisitNo", visitNo)};
            DataTable dtt = SelectDataTable(string.Format(select_patient_visit_1, @"where
	`patient_visit`.`patient_id` = @PatientId
	and `patient_visit`.`visit_no` = @VisitNo
order by
	`patient_visit`.`created_on` desc", "PatientVisit_SelectByPatientIdAndVisitNo"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityPatientVisit(dtt.Rows[0]);

            return null;
        }

        public bool PatientVisit_Insert(PatientVisit entity)
        {
            CleanAck();

            Parameters = new DbParameter[] {
                Parameter("PatientId", entity.PatientId > 0 ? entity.PatientId : (object)null),
                Parameter("LocationId", entity.LocationId > 0 ? entity.LocationId : (object)null),
                Parameter("SubLocationId", entity.SubLocationId > 0 ? entity.SubLocationId : (object)null),
                Parameter("VisitNo", entity.VisitNo),
                Parameter("PatientType", entity.PatientType),
                Parameter("ModalityWhId", entity.ModalityWhId > 0 ? entity.ModalityWhId : (object)null),
                Parameter("PatientWeight", entity.PatientWeight > decimal.Zero ? entity.PatientWeight : (object)null),
                Parameter("PatientWeightUnit", entity.PatientWeightUnit),
                Parameter("PatientHeight", entity.PatientHeight > decimal.Zero ? entity.PatientHeight : (object)null),
                Parameter("PatientHeightUnit", entity.PatientHeightUnit),
                Parameter("PatientBmi", entity.PatientBmi > decimal.Zero ? entity.PatientBmi : (object)null),
                Parameter("OrganizationId", entity.OrganizationId),
                Parameter("ModifiedBy", entity.ModifiedBy)};

            entity.PatientVisitId = Execute(@"
insert into `mdi_patient_visit`
(
    `patient_id`,
    `location_id`,
    `sub_location_id`,
    `visit_no`,
    `pat_type`,
    `modality_wh_id`,
    `wh_dt`,
    `pat_weight`,
    `weight_unit`,
    `pat_height`,
    `height_unit`,
    `pat_bmi`,
    `org_id`,
    `created_by`,
    `created_on`,
    `modified_by`,
    `modified_on`
)
values
(
    @PatientId,
    @LocationId,
    @SubLocationId,
    @VisitNo,
    @PatientType,
    @ModalityWhId,
    current_timestamp(),
    @PatientWeight,
    @PatientWeightUnit,
    @PatientHeight,
    @PatientHeightUnit,
    @PatientBmi,
    @OrganizationId,
    @ModifiedBy,
    current_timestamp(),
    @ModifiedBy,
    current_timestamp()
)", "PatientVisit_Insert")
                ? LastInsertedId : 0;

            return entity.PatientVisitId > 0;
        }
        public bool PatientVisit_Update(PatientVisit entity)
        {
            CleanAck();

            Parameters = new DbParameter[] {
                Parameter("PatientVisitId", entity.PatientVisitId),
                Parameter("PatientId", entity.PatientId > 0 ? entity.PatientId : (object)null),
                Parameter("LocationId", entity.LocationId > 0 ? entity.LocationId : (object)null),
                Parameter("SubLocationId", entity.SubLocationId > 0 ? entity.SubLocationId : (object)null),
                Parameter("VisitNo", entity.VisitNo),
                Parameter("PatientType", entity.PatientType),
                Parameter("ModalityWhId", entity.ModalityWhId > 0 ? entity.ModalityWhId : (object)null),
                Parameter("PatientWeight", entity.PatientWeight > decimal.Zero ? entity.PatientWeight : (object)null),
                Parameter("PatientWeightUnit", entity.PatientWeightUnit),
                Parameter("PatientHeight", entity.PatientHeight > decimal.Zero ? entity.PatientHeight : (object)null),
                Parameter("PatientHeightUnit", entity.PatientHeightUnit),
                Parameter("PatientBmi", entity.PatientBmi > decimal.Zero ? entity.PatientBmi : (object)null),
                Parameter("OrganizationId", entity.OrganizationId),
                Parameter("ModifiedBy", entity.ModifiedBy)};

            return Execute(@"
update
    `mdi_patient_visit`
set
    `patient_id` = @PatientId,
    `location_id` = @LocationId,
    `sub_location_id` = @SubLocationId,
    `visit_no` = @VisitNo,
    `pat_type` = @PatientType,
    `modality_wh_id` = @ModalityWhId,
	`wh_dt` = current_timestamp(),
    `pat_weight` = @PatientWeight,
    `weight_unit` = @PatientWeightUnit,
    `pat_height` = @PatientHeight,
    `height_unit` = @PatientHeightUnit,
    `pat_bmi` = @PatientBmi,
    `org_id` = @OrganizationId,
    `modified_by` = @ModifiedBy,
    `modified_on` = current_timestamp()
where
    `patient_visit_id` = @PatientVisitId", "PatientVisit_Update");
        }
        #endregion

        #region Data
        private const string select_data_1 = @"
select
	`data`.`data_id` as `DataId`,
	`data`.`patient_visit_id` as `PatientVisitId`,
	`data`.`modality_vs_id` as `ModalityVsId`,
	`data`.`vs_dt` as `VsDateTime`,
	`data`.`pulse_rate` as `PulseRate`,
	`data`.`pulse_unit` as `PulseUnit`,
	`data`.`pulse_flag` as `PulseFlag`,
	`data`.`blood_pressure_systolic` as `BloodPressureSystolic`,
	`data`.`blood_pressure_diastolic` as `BloodPressureDiastolic`,
	`data`.`blood_pressure_mean` as `BloodPressureMean`,
	`data`.`blood_pressure` as `BloodPressure`,
	`data`.`blood_pressure_unit` as `BloodPressureUnit`,
	`data`.`blood_pressure_method` as `BloodPressureMethod`,
	`data`.`spo2` as `Spo2`,
	`data`.`spo2_unit` as `Spo2Unit`,
	`data`.`temperature` as `Temperature`,
	`data`.`temperature_unit` as `TemperatureUnit`,
	`data`.`temperature_method` as `TemperatureMethod`,
	`data`.`blood_glucose` as `BloodGlucose`,
	`data`.`blood_glucose_unit` as `PainScale`,
	`data`.`respiration_rate` as `RespirationRate`,
	`data`.`pain_scale` as `PainScale`,
	`data`.`data_status` as `DataStatus`,
	`data`.`comment` as `Comment`,
	`data`.`is_confirmed` as `IsConfirmed`,
	`data`.`org_id` as `OrganizationId`
from
	`mdi_data` `data`
{0}
limit
    0, 1";

        private Data ConvertToEntityData(DataRow data)
        {
            if (data == null)
                return null;

            return new Data()
            {
                DataId = Utilities.ToInt(data["DataId"]),
                PatientVisitId = Utilities.ToInt(data["PatientVisitId"]),

                ModalityVsId = Utilities.ToInt(data["ModalityVsId"]),
                VsDateTime = Utilities.ToDateTime(data["VsDateTime"]),
                PulseRate = Utilities.ToInt(data["PulseRate"]),
                PulseUnit = data["PulseUnit"].ToString(),
                PulseFlag = data["PulseFlag"].ToString(),
                BloodPressureSystolic = Utilities.ToInt(data["BloodPressureSystolic"]),
                BloodPressureDiastolic = Utilities.ToInt(data["BloodPressureDiastolic"]),
                BloodPressureMean = Utilities.ToInt(data["BloodPressureMean"]),
                BloodPressure = data["BloodPressure"].ToString(),
                BloodPressureUnit = data["BloodPressureUnit"].ToString(),
                BloodPressureMethod = data["BloodPressureMethod"].ToString(),

                SpO2 = Utilities.ToDecimal(data["SpO2"]),
                SpO2Unit = data["SpO2Unit"].ToString(),

                Temperature = Utilities.ToDecimal(data["Temperature"]),
                TemperatureUnit = data["TemperatureUnit"].ToString(),
                TemperatureMethod = data["TemperatureMethod"].ToString(),
                RespirationRate = Utilities.ToInt(data["RespirationRate"]),
                PainScale = Utilities.ToInt(data["PainScale"]),

                DataStatus = data["DataStatus"].ToString(),
                Comment = data["Comment"].ToString(),
                IsConfirmed = Utilities.ToBoolean(data["IsConfirmed"]),

                OrganizationId = Utilities.ToInt(data["OrganizationId"])
            };
        }

        public Data Data_Select(Data entity)
        {
            Data entity_exist = null;

            entity_exist = Data_SelectByDataId(entity.DataId);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public Data Data_SelectByDataId(int dataId)
        {
            CleanAck();

            if (dataId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("DataId", dataId) };
            DataTable dtt = SelectDataTable(string.Format(select_data_1, "where `data`.`data_id` = @DataId", "Data_SelectByDataId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityData(dtt.Rows[0]);

            return null;
        }
        public Data Data_SelectLastByPatientVisitId(int patientVisitId)
        {
            CleanAck();

            if (patientVisitId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("PatientVisitId", patientVisitId) };
            DataTable dtt = SelectDataTable(string.Format(select_data_1, @"where
    `data`.`patient_visit_id` = @PatientVisitId
order by
	`data`.`created_on` desc", "Data_SelectLastByPatientVisitId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityData(dtt.Rows[0]);

            return null;
        }

        public bool Data_Insert(Data entity)
        {
            CleanAck();

            Parameters = new DbParameter[] {
                Parameter("PatientVisitId", entity.PatientVisitId > 0 ? entity.PatientVisitId : (object)null),
                Parameter("ModalityVsId", entity.ModalityVsId > 0 ? entity.ModalityVsId : (object)null),
                Parameter("PulseRate", entity.PulseRate > 0 ? entity.PulseRate : (object)null),
                Parameter("PulseUnit", entity.PulseUnit),
                Parameter("PulseFlag", entity.PulseFlag),
                Parameter("BloodPressureSystolic", entity.BloodPressureSystolic > 0 ? entity.BloodPressureSystolic : (object)null),
                Parameter("BloodPressureDiastolic", entity.BloodPressureDiastolic > 0 ? entity.BloodPressureDiastolic : (object)null),
                Parameter("BloodPressureMean", entity.BloodPressureMean > 0 ? entity.BloodPressureMean : (object)null),
                Parameter("BloodPressure", entity.BloodPressure),
                Parameter("BloodPressureUnit", entity.BloodPressureUnit),
                Parameter("BloodPressureMethod", entity.BloodPressureMethod),
                Parameter("SpO2", entity.SpO2 > decimal.Zero ? entity.SpO2 : (object)null),
                Parameter("SpO2Unit", entity.SpO2Unit),
                Parameter("Temperature", entity.Temperature > decimal.Zero ? entity.Temperature : (object)null),
                Parameter("TemperatureUnit", entity.TemperatureUnit),
                Parameter("TemperatureMethod", entity.TemperatureMethod),
                Parameter("BloodGlucose", entity.BloodGlucose > 0 ? entity.BloodGlucose : (object)null),
                Parameter("BloodGlucoseUnit", entity.BloodGlucoseUnit),
                Parameter("RespirationRate", entity.RespirationRate > 0 ? entity.RespirationRate : (object)null),
                Parameter("PainScale", entity.PainScale > 0 ? entity.PainScale : (object)null),
                Parameter("DataStatus", entity.DataStatus),
                Parameter("IsConfirmed", entity.IsConfirmed),
                Parameter("OrganizationId", entity.OrganizationId),
                Parameter("ModifiedBy", entity.ModifiedBy)};

            entity.DataId = Execute(@"
insert into `mdi_data`
(
    `patient_visit_id`,
    `modality_vs_id`,
    `vs_dt`,
    `pulse_rate`,
    `pulse_unit`,
    `pulse_flag`,
    `blood_pressure_systolic`,
    `blood_pressure_diastolic`,
    `blood_pressure_mean`,
    `blood_pressure`,
    `blood_pressure_unit`,
    `blood_pressure_method`,
    `spo2`,
    `spo2_unit`,
    `temperature`,
    `temperature_unit`,
    `temperature_method`,
    `blood_glucose`,
    `blood_glucose_unit`,
    `respiration_rate`,
    `pain_scale`,
    `data_status`,
    `is_confirmed`,
    `org_id`,
    `created_by`,
    `created_on`,
    `modified_by`,
    `modified_on`
)
values
(
    @PatientVisitId,
    @ModalityVsId,
    current_timestamp(),
    @PulseRate,
    @PulseUnit,
    @PulseFlag,
    @BloodPressureSystolic,
    @BloodPressureDiastolic,
    @BloodPressureMean,
    @BloodPressure,
    @BloodPressureUnit,
    @BloodPressureMethod,
    @Spo2,
    @Spo2Unit,
    @Temperature,
    @TemperatureUnit,
    @TemperatureMethod,
    @BloodGlucose,
    @BloodGlucoseUnit,
    @RespirationRate,
    @PainScale,
    @DataStatus,
    @IsConfirmed,
    @OrganizationId,
    @ModifiedBy,
    current_timestamp(),
    @ModifiedBy,
    current_timestamp()
)", "Data_Insert")
                ? LastInsertedId : 0;

            return entity.DataId > 0;
        }
        public bool Data_Update(Data entity)
        {
            CleanAck();

            Parameters = new DbParameter[] {
                Parameter("DataId", entity.DataId),
                Parameter("PatientVisitId", entity.PatientVisitId > 0 ? entity.PatientVisitId : (object)null),
                Parameter("ModalityVsId", entity.ModalityVsId > 0 ? entity.ModalityVsId : (object)null),
                Parameter("PulseRate", entity.PulseRate > 0 ? entity.PulseRate : (object)null),
                Parameter("PulseUnit", entity.PulseUnit),
                Parameter("PulseFlag", entity.PulseFlag),
                Parameter("BloodPressureSystolic", entity.BloodPressureSystolic > 0 ? entity.BloodPressureSystolic : (object)null),
                Parameter("BloodPressureDiastolic", entity.BloodPressureDiastolic > 0 ? entity.BloodPressureDiastolic : (object)null),
                Parameter("BloodPressureMean", entity.BloodPressureMean > 0 ? entity.BloodPressureMean : (object)null),
                Parameter("BloodPressure", entity.BloodPressure),
                Parameter("BloodPressureUnit", entity.BloodPressureUnit),
                Parameter("BloodPressureMethod", entity.BloodPressureMethod),
                Parameter("SpO2", entity.SpO2 > decimal.Zero ? entity.SpO2 : (object)null),
                Parameter("SpO2Unit", entity.SpO2Unit),
                Parameter("Temperature", entity.Temperature > decimal.Zero ? entity.Temperature : (object)null),
                Parameter("TemperatureUnit", entity.TemperatureUnit),
                Parameter("TemperatureMethod", entity.TemperatureMethod),
                Parameter("BloodGlucose", entity.BloodGlucose > 0 ? entity.BloodGlucose : (object)null),
                Parameter("BloodGlucoseUnit", entity.BloodGlucoseUnit),
                Parameter("RespirationRate", entity.RespirationRate > 0 ? entity.RespirationRate : (object)null),
                Parameter("PainScale", entity.PainScale > 0 ? entity.PainScale : (object)null),
                Parameter("DataStatus", entity.DataStatus),
                Parameter("IsConfirmed", entity.IsConfirmed),
                Parameter("OrganizationId", entity.OrganizationId),
                Parameter("ModifiedBy", entity.ModifiedBy)};

            return Execute(@"
update
    `mdi_data`
set
    `patient_visit_id` = @PatientVisitId,
    `modality_vs_id` = @ModalityVsId,
    `vs_dt` = current_timestamp(),
    `pulse_rate` = @PulseRate,
    `pulse_unit` = @PulseUnit,
    `pulse_flag` = @PulseFlag,
    `blood_pressure_systolic` = @BloodPressureSystolic,
    `blood_pressure_diastolic` = @BloodPressureDiastolic,
    `blood_pressure_mean` = @BloodPressureMean,
    `blood_pressure` = @BloodPressure,
    `blood_pressure_unit` = @BloodPressureUnit,
    `blood_pressure_method` = @BloodPressureMethod,
    `spo2` = @Spo2,
    `spo2_unit` = @Spo2Unit,
    `temperature` = @Temperature,
    `temperature_unit` = @TemperatureUnit,
    `temperature_method` = @TemperatureMethod,
    `blood_glucose` = @BloodGlucose,
    `blood_glucose_unit` = @BloodGlucoseUnit,
    `respiration_rate` = @RespirationRate,
    `pain_scale` = @PainScale,
    `data_status` = @DataStatus,
    `is_confirmed` = @IsConfirmed,
    `org_id` = @OrganizationId,
    `modified_by` = @ModifiedBy,
    `modified_on` = current_timestamp()
where
    `data_id` = @DataId", "Data_Update");
        }
        #endregion

        #region DataLog
        public bool DataLog_Insert(DataLog entity)
        {
            CleanAck();

            Parameters = new DbParameter[] {
                Parameter("DataId", entity.DataId > 0 ? entity.DataId : (object)null),
                Parameter("ModalityVsId", entity.ModalityVsId > 0 ? entity.ModalityVsId : (object)null),
                Parameter("PulseRate", entity.PulseRate > 0 ? entity.PulseRate : (object)null),
                Parameter("PulseUnit", entity.PulseUnit),
                Parameter("PulseFlag", entity.PulseFlag),
                Parameter("BloodPressureSystolic", entity.BloodPressureSystolic > 0 ? entity.BloodPressureSystolic : (object)null),
                Parameter("BloodPressureDiastolic", entity.BloodPressureDiastolic > 0 ? entity.BloodPressureDiastolic : (object)null),
                Parameter("BloodPressureMean", entity.BloodPressureMean > 0 ? entity.BloodPressureMean : (object)null),
                Parameter("BloodPressure", entity.BloodPressure),
                Parameter("BloodPressureUnit", entity.BloodPressureUnit),
                Parameter("BloodPressureMethod", entity.BloodPressureMethod),
                Parameter("SpO2", entity.SpO2 > decimal.Zero ? entity.SpO2 : (object)null),
                Parameter("SpO2Unit", entity.SpO2Unit),
                Parameter("Temperature", entity.Temperature > decimal.Zero ? entity.Temperature : (object)null),
                Parameter("TemperatureUnit", entity.TemperatureUnit),
                Parameter("TemperatureMethod", entity.TemperatureMethod),
                Parameter("BloodGlucose", entity.BloodGlucose > 0 ? entity.BloodGlucose : (object)null),
                Parameter("BloodGlucoseUnit", entity.BloodGlucoseUnit),
                Parameter("RespirationRate", entity.RespirationRate > 0 ? entity.RespirationRate : (object)null),
                Parameter("PainScale", entity.PainScale > 0 ? entity.PainScale : (object)null)};

            entity.DataLogId = Execute(@"
insert into `mdi_data_log`
(
    `data_id`,
    `modality_vs_id`,
    `vs_dt`,
    `pulse_rate`,
    `pulse_unit`,
    `pulse_flag`,
    `blood_pressure_systolic`,
    `blood_pressure_diastolic`,
    `blood_pressure_mean`,
    `blood_pressure`,
    `blood_pressure_unit`,
    `blood_pressure_method`,
    `spo2`,
    `spo2_unit`,
    `temperature`,
    `temperature_unit`,
    `temperature_method`,
    `blood_glucose`,
    `blood_glucose_unit`,
    `respiration_rate`,
    `pain_scale`
)
values
(
    @DataId,
    @ModalityVsId,
    current_timestamp(),
    @PulseRate,
    @PulseUnit,
    @PulseFlag,
    @BloodPressureSystolic,
    @BloodPressureDiastolic,
    @BloodPressureMean,
    @BloodPressure,
    @BloodPressureUnit,
    @BloodPressureMethod,
    @Spo2,
    @Spo2Unit,
    @Temperature,
    @TemperatureUnit,
    @TemperatureMethod,
    @BloodGlucose,
    @BloodGlucoseUnit,
    @RespirationRate,
    @PainScale
)", "DataLog_Insert")
                ? LastInsertedId : 0;

            return entity.DataLogId > 0;
        }
        #endregion

        #region Modality
        private const string select_modality_1 = @"
select
	`modality`.`modality_id` as ModalityId,
	`modality`.`modality_uid` as ModalityUid,
	`modality`.`modality_name` as ModalityName,
	`modality`.`modality_type_alias` as ModalityTypeAlias,
	`modality`.`modality_host` as ModalityHost,
	`modality`.`modality_config` as ModalityConfig,
	`modality`.`modality_log` as ModalityLog,
	`modality`.`vitalsign_interval` as VitalsignInterval,
	`modality`.`location_id` as LocationId,
	`modality`.`sub_location_id` as SubLocationId,
	`modality`.`auto_confirm` as AutoConfirm,
	`modality`.`is_deleted` as IsDeleted,
	`modality`.`org_id` as OrganizationId
from
	`mdi_modality` `modality`
{0}
limit
    0, 1";

        private Modality ConvertToEntityModality(DataRow data)
        {
            if (data == null)
                return null;

            return new Modality()
            {
                ModalityId = Utilities.ToInt(data["ModalityId"]),
                ModalityUid = data["ModalityUid"].ToString(),
                ModalityName = data["ModalityName"].ToString(),
                ModalityTypeAlias = data["ModalityTypeAlias"].ToString(),
                ModalityHost = data["ModalityHost"].ToString(),
                ModalityConfig = data["ModalityConfig"].ToString(),
                ModalityLog = data["ModalityLog"].ToString(),
                VitalsignInterval = Utilities.ToInt(data["VitalsignInterval"]),

                LocationId = Utilities.ToInt(data["LocationId"]),
                SubLocationId = Utilities.ToInt(data["SubLocationId"]),

                AutoConfirm = Utilities.ToBoolean(data["AutoConfirm"]),
                IsDeleted = Utilities.ToBoolean(data["IsDeleted"]),

                OrganizationId = Utilities.ToInt(data["OrganizationId"])
            };
        }

        public Modality Modality_Select(Modality entity)
        {
            Modality entity_exist = null;

            entity_exist = Modality_SelectByModalityUid(entity.ModalityUid);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            entity_exist = Modality_SelectByModalityHost(entity.ModalityHost);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public Modality Modality_SelectByModalityUid(string modalityUid)
        {
            CleanAck();

            if (string.IsNullOrEmpty(modalityUid))
                return null;

            Parameters = new DbParameter[] { Parameter("ModalityUid", modalityUid) };
            DataTable dtt = SelectDataTable(string.Format(select_modality_1, "where `modality`.`modality_uid` = @ModalityUid", "Modality_SelectByModalityUid"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityModality(dtt.Rows[0]);

            return null;
        }
        public Modality Modality_SelectByModalityHost(string modalityHost)
        {
            CleanAck();

            if (string.IsNullOrEmpty(modalityHost))
                return null;

            Parameters = new DbParameter[] { Parameter("ModalityHost", modalityHost) };
            DataTable dtt = SelectDataTable(string.Format(select_modality_1, "where `modality`.`modality_host` = @ModalityHost", "Modality_SelectByModalityHost"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityModality(dtt.Rows[0]);

            return null;
        }

        public bool Modality_UpdateModalityLog(Modality entity)
        {
            CleanAck();

            Parameters = new DbParameter[] {
                Parameter("ModalityId", entity.ModalityId),
                Parameter("ModalityHost", entity.ModalityHost),
                Parameter("ModalityLog", entity.ModalityLog)};

            return Execute(@"
update
    `mdi_modality`
set
	`modality_host` = @ModalityHost,
    `modality_log` = @ModalityLog
where
    `modality_id` = @ModalityId", "Modality_UpdateModalityLog");
        }
        #endregion

        /*
        #region Organization
        private const string select_organization_1 = @"
select
    org.`org_id` as OrganizationId,
    org.`org_uid` as OrganizationUid,
    org.`org_name` as OrganizationName,
    org.`org_alias` as OrganizationAlias
from
	`gbl_env` org
{0}
limit
    0, 1";

        private Organization ConvertToEntityOrganization(DataRow data)
        {
            if (data == null)
                return null;

            return new Organization()
            {
                OrganizationId = Utilities.ToInt(data["OrganizationId"]),
                OrganizationUid = data["OrganizationUid"].ToString(),
                OrganizationName = data["OrganizationName"].ToString(),
                OrganizationAlias = data["OrganizationAlias"].ToString()
            };
        }

        public Organization Organization_Select(Organization entity)
        {
            Organization entity_exist = null;

            entity_exist = Organization_SelectByOrganizationId(entity.OrganizationId);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            entity_exist = Organization_SelectByOrganizationUid(entity.OrganizationUid);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            entity_exist = Organization_SelectByOrganizationAlias(entity.OrganizationAlias);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public Organization Organization_SelectByOrganizationId(int organizationId)
        {
            CleanAck();

            if (organizationId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("OrganizationId", organizationId) };
            DataTable dtt = SelectDataTable(string.Format(select_organization_1, "where org.`org_id` = @OrganizationId", "Organization_SelectByOrganizationId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityOrganization(dtt.Rows[0]);

            return null;
        }
        public Organization Organization_SelectByOrganizationUid(string organizationUid)
        {
            CleanAck();

            if (string.IsNullOrEmpty(organizationUid))
                return null;

            Parameters = new DbParameter[] { Parameter("OrganizationUid", organizationUid) };
            DataTable dtt = SelectDataTable(string.Format(select_organization_1, "where org.`org_uid` = @OrganizationUid", "Organization_SelectByOrganizationUid"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityOrganization(dtt.Rows[0]);

            return null;
        }
        public Organization Organization_SelectByOrganizationAlias(string organizationAlias)
        {
            CleanAck();

            if (string.IsNullOrEmpty(organizationAlias))
                return null;

            Parameters = new DbParameter[] { Parameter("OrganizationAlias", organizationAlias) };
            DataTable dtt = SelectDataTable(string.Format(select_organization_1, "where org.`org_alias` = @OrganizationAlias", "Organization_SelectByOrganizationAlias"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityOrganization(dtt.Rows[0]);

            return null;
        }
        #endregion

        #region Patient
        private const string select_patient_1 = @"
select
    patient.`patient_id` as PatientId,
    patient.`hn` as Hn,
    patient.`title` as PatientTitle,
    patient.`fname` as PatientFName,
    patient.`mname` as PatientMName,
    patient.`lname` as PatientLName,
    patient.`title_eng` as PatientTitleEng,
    patient.`fname_eng` as PatientFNameEng,
    patient.`mname_eng` as PatientMNameEng,
    patient.`lname_eng` as PatientLNameEng,

    patient.`org_id` as OrganizationId
from
	`his_patient` patient
{0}
limit
    0, 1";

        private Patient ConvertToEntityPatient(DataRow data)
        {
            if (data == null)
                return null;

            return new Patient()
            {
                PatientId = Utilities.ToInt(data["PatientId"]),
                Hn = data["Hn"].ToString(),

                PatientTitle = data["PatientTitle"].ToString(),
                PatientFName = data["PatientFName"].ToString(),
                PatientMName = data["PatientMName"].ToString(),
                PatientLName = data["PatientLName"].ToString(),
                PatientTitleEng = data["PatientTitleEng"].ToString(),
                PatientFNameEng = data["PatientFNameEng"].ToString(),
                PatientMNameEng = data["PatientMNameEng"].ToString(),
                PatientLNameEng = data["PatientLNameEng"].ToString(),

                OrganizationId = Utilities.ToInt(data["OrganizationId"])
            };
        }

        public Patient Patient_Select(Patient entity)
        {
            Patient entity_exist = null;

            entity_exist = Patient_SelectByPatientId(entity.PatientId.GetValueOrDefault(0));

            if (entity_exist != null || EventFailure)
                return entity_exist;

            entity_exist = Patient_SelectByHn(entity.Hn);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public Patient Patient_SelectByPatientId(int patientId)
        {
            CleanAck();

            if (patientId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("PatientId", patientId) };
            DataTable dtt = SelectDataTable(string.Format(select_patient_1, "where patient.`patient_id` = @PatientId", "Patient_SelectByPatientId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityPatient(dtt.Rows[0]);

            return null;
        }
        public Patient Patient_SelectByHn(string hn)
        {
            CleanAck();

            if (string.IsNullOrEmpty(hn))
                return null;

            Parameters = new DbParameter[] { Parameter("Hn", hn) };
            DataTable dtt = SelectDataTable(string.Format(select_patient_1, "where patient.`hn` = @Hn", "Patient_SelectByHn"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityPatient(dtt.Rows[0]);

            return null;
        }
        #endregion

        #region User
        private const string select_user_1 = @"
select
    user.`user_id` as UserId,
    user.`user_uid` as UserUid,
    user.`title` as UserTitle,
    user.`fname` as UserFName,
    user.`mname` as UserMName,
    user.`lname` as UserLName,
    user.`title_eng` as UserTitleEng,
    user.`fname_eng` as UserFNameEng,
    user.`mname_eng` as UserMNameEng,
    user.`lname_eng` as UserLNameEng,

    user.`org_id` as OrganizationId
from
	`hr_user` user
{0}
limit
    0, 1";

        private User ConvertToEntityUser(DataRow data)
        {
            if (data == null)
                return null;

            return new User()
            {
                UserId = Utilities.ToInt(data["UserId"]),
                UserUid = data["UserUid"].ToString(),

                UserTitle = data["UserTitle"].ToString(),
                UserFName = data["UserFName"].ToString(),
                UserMName = data["UserMName"].ToString(),
                UserLName = data["UserLName"].ToString(),
                UserTitleEng = data["UserTitleEng"].ToString(),
                UserFNameEng = data["UserFNameEng"].ToString(),
                UserMNameEng = data["UserMNameEng"].ToString(),
                UserLNameEng = data["UserLNameEng"].ToString(),

                OrganizationId = Utilities.ToInt(data["OrganizationId"])
            };
        }

        public User User_Select(User entity)
        {
            User entity_exist = null;

            entity_exist = User_SelectByuserId(entity.UserId.GetValueOrDefault(0));

            if (entity_exist != null || EventFailure)
                return entity_exist;

            entity_exist = User_SelectByUserUid(entity.UserUid);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public User User_SelectByuserId(int userId)
        {
            CleanAck();

            if (userId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("UserId", userId) };
            DataTable dtt = SelectDataTable(string.Format(select_user_1, "where user.`user_id` = @UserId", "User_SelectByUserId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityUser(dtt.Rows[0]);

            return null;
        }
        public User User_SelectByUserUid(string userUid)
        {
            CleanAck();

            if (string.IsNullOrEmpty(userUid))
                return null;

            Parameters = new DbParameter[] { Parameter("UserUid", userUid) };
            DataTable dtt = SelectDataTable(string.Format(select_user_1, "where user.`hn` = @UserUid", "User_SelectByUserUid"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityUser(dtt.Rows[0]);

            return null;
        }
        #endregion

        #region Location
        private const string select_location_1 = @"
select
    location.`location_id` as LocationId,
    location.`location_uid` as LocationUid,

    location.`org_id` as OrganizationId
from
	`mdi_location` location
{0}
limit
    0, 1";

        private Location ConvertToEntityLocation(DataRow data)
        {
            if (data == null)
                return null;

            return new Location()
            {
                LocationId = Utilities.ToInt(data["LocationId"]),
                LocationUid = data["LocationUid"].ToString(),

                OrganizationId = Utilities.ToInt(data["OrganizationId"])
            };
        }

        public Location Location_Select(Location entity)
        {
            Location entity_exist = null;

            entity_exist = Location_SelectBylocationId(entity.LocationId.GetValueOrDefault(0));

            if (entity_exist != null || EventFailure)
                return entity_exist;

            entity_exist = Location_SelectByLocationUid(entity.LocationUid);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public Location Location_SelectBylocationId(int locationId)
        {
            CleanAck();

            if (locationId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("LocationId", locationId) };
            DataTable dtt = SelectDataTable(string.Format(select_location_1, "where location.`location_id` = @LocationId", "Location_SelectByLocationId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityLocation(dtt.Rows[0]);

            return null;
        }
        public Location Location_SelectByLocationUid(string locationUid)
        {
            CleanAck();

            if (string.IsNullOrEmpty(locationUid))
                return null;

            Parameters = new DbParameter[] { Parameter("LocationUid", locationUid) };
            DataTable dtt = SelectDataTable(string.Format(select_location_1, "where location.`location_uid` = @LocationUid", "Location_SelectByLocationUid"));

            if (Utilities.HasData(dtt))
                return ConvertToEntityLocation(dtt.Rows[0]);

            return null;
        }
        #endregion

        #region SubLocation
        private const string select_sub_location_1 = @"
select
    sub_location.`sub_location_id` as SubLocationId,
    sub_location.`sub_location_uid` as SubLocationUid,

    sub_location.`org_id` as OrganizationId
from
	`mdi_sub_location` sub_location
{0}
limit
    0, 1";

        private SubLocation ConvertToEntitySubLocation(DataRow data)
        {
            if (data == null)
                return null;

            return new SubLocation()
            {
                SubLocationId = Utilities.ToInt(data["SubLocationId"]),
                SubLocationUid = data["SubLocationUid"].ToString(),

                OrganizationId = Utilities.ToInt(data["OrganizationId"])
            };
        }

        public SubLocation SubLocation_Select(SubLocation entity)
        {
            SubLocation entity_exist = null;

            entity_exist = SubLocation_SelectBySubLocationId(entity.SubLocationId.GetValueOrDefault(0));

            if (entity_exist != null || EventFailure)
                return entity_exist;

            entity_exist = SubLocation_SelectBySubLocationUid(entity.SubLocationUid);

            if (entity_exist != null || EventFailure)
                return entity_exist;

            return entity_exist;
        }

        public SubLocation SubLocation_SelectBySubLocationId(int subLocationId)
        {
            CleanAck();

            if (subLocationId < 1)
                return null;

            Parameters = new DbParameter[] { Parameter("SubLocationId", subLocationId) };
            DataTable dtt = SelectDataTable(string.Format(select_sub_location_1, "where sub_location.`sub_location_id` = @SubLocationId", "SubLocation_SelectBySubLocationId"));

            if (Utilities.HasData(dtt))
                return ConvertToEntitySubLocation(dtt.Rows[0]);

            return null;
        }
        public SubLocation SubLocation_SelectBySubLocationUid(string subLocationUid)
        {
            CleanAck();

            if (string.IsNullOrEmpty(subLocationUid))
                return null;

            Parameters = new DbParameter[] { Parameter("SubLocationUid", subLocationUid) };
            DataTable dtt = SelectDataTable(string.Format(select_sub_location_1, "where sub_location.`sub_location_uid` = @SubLocationUid", "SubLocation_SelectBySubLocationUid"));

            if (Utilities.HasData(dtt))
                return ConvertToEntitySubLocation(dtt.Rows[0]);

            return null;
        }
        #endregion
        */
    }
}