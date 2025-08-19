select
	`patient`.`hn` as `Hn`,
	concat_ws(' ', `patient`.`title`, `patient`.`fname`, `patient`.`mname`, `patient`.`lname`) as `PatientName`,

	`sub_location`.`sub_location_uid` as `SubLocationUid`,
	
	`patient_visit`.`pat_weight` as `PatientWeight`,
	`patient_visit`.`pat_height` as `PatientHeight`,
	
	null as `PulseRate`,
	null as `BloodPressureSystolic`,
	null as `BloodPressureDiastolic`,
	null as `Spo2`,
	null as `RespirationRate`,
	null as `Temperature`,
	null as `PainScale`,
	
	null as `ConfirmedByUid`,
	current_timestamp() as `ConfirmedOn`,
	current_timestamp() as `ModifiedOn`
from
	`mdi_patient_visit` `patient_visit`
	left join `mdi_sub_location` `sub_location`
			on `patient_visit`.`sub_location_id` = `sub_location`.`sub_location_id`
	inner join `his_patient` `patient`
			on `patient_visit`.`patient_id` = `patient`.`patient_id`
where
	`patient_visit`.`patient_visit_id` = @PatientVisitId