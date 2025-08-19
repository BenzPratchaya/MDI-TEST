select
	`patient`.`hn` as `Hn`,
	concat_ws(' ', `patient`.`title`, `patient`.`fname`, `patient`.`mname`, `patient`.`lname`) as `PatientName`,

	`sub_location`.`sub_location_uid` as `SubLocationUid`,
	
	`patient_visit`.`pat_weight` as `PatientWeight`,
	`patient_visit`.`pat_height` as `PatientHeight`,
	
	`data`.`pulse_rate` as `PulseRate`,
	`data`.`blood_pressure_systolic` as `BloodPressureSystolic`,
	`data`.`blood_pressure_diastolic` as `BloodPressureDiastolic`,
	`data`.`spo2` as `Spo2`,
	`data`.`respiration_rate` as `RespirationRate`,
	`data`.`temperature` as `Temperature`,
	`data`.`pain_scale` as `PainScale`,
	
	`confirmed_by`.`user_uid` as `ConfirmedByUid`,
	current_timestamp() as `ConfirmedOn`,
	current_timestamp() as `ModifiedOn`
from
	`mdi_patient_visit` `patient_visit`
	left join `mdi_sub_location` `sub_location`
			on `patient_visit`.`sub_location_id` = `sub_location`.`sub_location_id`
	left join `mdi_data` `data`
			on `patient_visit`.`patient_visit_id` = `data`.`patient_visit_id`
		left join `hr_user` `confirmed_by`
				on `data`.`confirmed_by` = `confirmed_by`.`user_id`
	inner join `his_patient` `patient`
			on `patient_visit`.`patient_id` = `patient`.`patient_id`
where
	`data`.`data_id` = @DataId