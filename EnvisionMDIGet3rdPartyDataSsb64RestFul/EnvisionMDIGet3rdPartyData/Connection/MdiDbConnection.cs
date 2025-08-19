using EnvisionIE.Connection.Engine;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using System;
using System.Data;
using System.Data.Common;

namespace EnvisionMDIGet3rdPartyData.Connection
{
    public class MdiDbConnection : MySqlEngine, IDisposable
    {
        private const string class_name = "MdiDb";

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
                        ThirdPartyName = class_name,

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

        public DataTable Patient_SelectByHn(string hn)
        {
            CleanAck();

            if (string.IsNullOrEmpty(hn))
                return null;

            Parameters = new DbParameter[] { Parameter("Hn", hn) };

            return SelectDataTable(@"
select
	`patient`.`org_id` as `OrganizationId`,

	`patient`.`patient_id` as `PatientId`,
	`patient`.`hn` as `Hn`,
	`patient`.`title` as `PatientTitle`,
	`patient`.`fname` as `PatientFName`,
	`patient`.`mname` as `PatientMName`,
	`patient`.`lname` as `PatientLName`,
	`patient`.`title_eng` as `PatientTitleEng`,
	`patient`.`fname_eng` as `PatientFNameEng`,
	`patient`.`mname_eng` as `PatientMNameEng`,
	`patient`.`lname_eng` as `PatientLNameEng`,
	`patient`.`gender` as `PatientGender`,
	`patient`.`dob` as `PatientDob`,
	`patient`.`ssn` as `PatientSsn`
from
	`his_patient` `patient`
where
	`patient`.`hn` = @Hn", "Patient_SelectByHn");
        }

        public int Patient_Insert(
            string hn,
            string patientTitle,
            string patientFname,
            string patientLname,
            string patientTitleEng,
            string patientFnameEng,
            string patientLnameEng,
            string patientGender,
            DateTime patientDob,
            string patientSsn,
            int organizationId,
			int modifiedBy)
        {
            Parameters = new DbParameter[] {
                Parameter("Hn", hn),
                Parameter("PatientTitle", patientTitle),
                Parameter("PatientFName", patientFname),
                Parameter("PatientLName", patientLname),
                Parameter("PatientTitleEng", patientTitleEng),
                Parameter("PatientFNameEng", patientFnameEng),
                Parameter("PatientLNameEng", patientLnameEng),
                Parameter("PatientGender", patientGender),
                Parameter("PatientDob", patientDob),
                Parameter("PatientSsn", patientSsn),
				Parameter("OrganizationId", organizationId),
				Parameter("ModifiedBy", modifiedBy)};

			Execute(@"
insert into `his_patient`
(
	`hn`,
	`title`,
	`fname`,
	`lname`,
	`title_eng`,
	`fname_eng`,
	`lname_eng`,
	`gender`,
	`dob`,
	`ssn`,
	`is_johndoe`,
	`org_id`,
	`created_by`,
	`created_on`,
	`modified_by`,
	`modified_on`
)
values
(
	@Hn,
	@PatientTitle,
	@PatientFName,
	@PatientLName,
	@PatientTitleEng,
	@PatientFNameEng,
	@PatientLNameEng,
	@PatientGender,
	@PatientDob,
	@PatientSsn,
	0,
	@OrganizationId,
	@ModifiedBy,
	current_timestamp(),
	@ModifiedBy,
	current_timestamp()
)", "Patient_Insert");

                return LastInsertedId;
        }
        public bool Patient_Update(
            int patientId,
            string patientTitle,
            string patientFname,
            string patientLname,
            string patientTitleEng,
            string patientFnameEng,
            string patientLnameEng,
            string patientGender,
            DateTime patientDob,
            string patientSsn,
            int modifiedBy)
        {
            Parameters = new DbParameter[] {
                Parameter("PatientId", patientId),
				Parameter("PatientTitle", patientTitle),
				Parameter("PatientFName", patientFname),
				Parameter("PatientLName", patientLname),
				Parameter("PatientTitleEng", patientTitleEng),
				Parameter("PatientFNameEng", patientFnameEng),
				Parameter("PatientLNameEng", patientLnameEng),
				Parameter("PatientGender", patientGender),
				Parameter("PatientDob", patientDob),
				Parameter("PatientSsn", patientSsn),
				Parameter("ModifiedBy", modifiedBy)};

			return Execute(@"
update
    `his_patient`
set
	`title` = @PatientTitle,
	`fname` = @PatientFName,
	`lname` = @PatientLName,
	`title_eng` = @PatientTitleEng,
	`fname_eng` = @PatientFNameEng,
	`lname_eng` = @PatientLNameEng,
	`gender` = @PatientGender,
	`dob` = @PatientDob,
	`ssn` = @PatientSsn,
	`is_johndoe` = 0,
	`modified_by` = @ModifiedBy,
    `modified_on` = current_timestamp()
where
    `patient_id` = @PatientId", "Patient_Update");
        }
    }
}