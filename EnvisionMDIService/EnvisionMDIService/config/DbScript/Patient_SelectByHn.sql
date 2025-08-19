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
	`patient`.`hn` = @Hn