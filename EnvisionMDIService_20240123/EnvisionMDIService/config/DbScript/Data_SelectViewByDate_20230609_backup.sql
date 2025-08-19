select
	`org`.`org_id` as `OrganizationId`,
	`org`.`org_uid` as `OrganizationUid`,
	
	`patient_visit`.`patient_visit_id` as `PatientVisitId`,
	`data`.`data_id` as `DataId`,

	`patient`.`patient_id` as `PatientId`,
	`patient`.`hn` as `Hn`,
	concat_ws(' ', `patient`.`title`, `patient`.`fname`, `patient`.`mname`, `patient`.`lname`) as `PatientName`,
	case `patient`.`gender`
		when 'M' then 'ชาย'
		when 'F' then 'หญิง'
		else ''
	end as `PatientGenderText`,
	`patient`.`dob` as `PatientDob`,
	fnAgeText(`patient_visit`.`created_on`, `patient`.`dob`) as `PatientAgeText`,
	`patient`.`ssn` as `PatientSsn`,

	`patient_visit`.`visit_no` as `VisitNo`,
	`patient_visit`.`pat_type` as `PatientType`,
	case `patient_visit`.`pat_type`
		when 'A' then 'Adult'
		when 'P' then 'Pediatric'
		when 'N' then 'Neonatal'
		else ''
	end as `PatientTypeText`,

	`location`.`location_id` as `LocationId`,
	concat_ws(':', `location`.`location_uid`, `location`.`location_name`) as `LocationText`,

	`sub_location`.`sub_location_id` as `SubLocationId`,
	concat_ws(':', `sub_location`.`sub_location_uid`, `sub_location`.`sub_location_name`) as `SubLocationText`,

	`modality_wh`.`modality_id` as `ModalityWhId`,
	concat_ws(':', `modality_wh`.`modality_uid`, `modality_wh`.`modality_name`) as `ModalityWhText`,
	`patient_visit`.`wh_dt` as `WhDateTime`,
	concat_ws(' ', `patient_visit`.`pat_weight`, `patient_visit`.`weight_unit`) as `PatientWeightText`,
	concat_ws(' ', `patient_visit`.`pat_height`, `patient_visit`.`height_unit`) as `PatientHeightText`,
	`patient_visit`.`pat_bmi` as `PatientBmi`,

	`modality_vs`.`modality_id` as `ModalityVsId`,
	concat_ws(':', `modality_vs`.`modality_uid`, `modality_vs`.`modality_name`) as `ModalityVsText`,
	`data`.`vs_dt` as `VsDateTime`,
	concat_ws(' ', `data`.`pulse_rate`, `data`.`pulse_unit`) as `PulseRateText`,
	case `data`.`pulse_flag`
		when 'N' then 'Normal'
		when 'L' then 'Below Normal'
		when 'H' then 'Above Normal'
		when 'A' then 'Other Abnormal'
		else ''
	end as `PulseFlagText`,
	concat_ws(' ', `data`.`blood_pressure`, `data`.`blood_pressure_unit`) as `BloodPressureText`,
	`data`.`blood_pressure_method` as `BloodPressureMethod`,
	concat_ws(' ', `data`.`spo2`, `data`.`spo2_unit`) as `Spo2Text`,
	concat_ws(' ', `data`.`temperature`, `data`.`temperature_unit`) as `TemperatureText`,
	`data`.`temperature_method` as `TemperatureMethod`,
	concat_ws(' ', `data`.`blood_glucose`, `data`.`blood_glucose_unit`) as `BloodGlucoseText`,
	`data`.`respiration_rate` as `RespirationRate`,
	`data`.`pain_scale` as `PainScale`,
	

	`data`.`data_status` as `DataStatus`,
	case `data`.`data_status`
		when 'N' then 'Schedule'
		when 'C' then 'Confirmed'
		else ''
	end as `DataStatusText`,
	`data`.`is_confirmed` as `IsConfirmed`,
	`confirmed_by`.`user_id` as `ConfirmedById`,
	concat_ws(' ', `confirmed_by`.`title`, `confirmed_by`.`fname`, `confirmed_by`.`mname`, `confirmed_by`.`lname`) as `ConfirmedByName`,
	`data`.`confirmed_on` as `ConfirmedOn`,
	`patient_visit`.`created_on` as `CreatedOn`,
	ifnull(`data`.`modified_on`, `patient_visit`.`modified_on`) as `ModifiedOn`
from
	`mdi_patient_visit` `patient_visit`
	left join `mdi_location` `location`
			on `patient_visit`.`location_id` = `location`.`location_id`
	left join `mdi_sub_location` `sub_location`
			on `patient_visit`.`sub_location_id` = `sub_location`.`sub_location_id`
	left join `mdi_modality` `modality_wh`
			on `patient_visit`.`modality_wh_id` = `modality_wh`.`modality_id`
	left join `mdi_data` `data`
			on `patient_visit`.`patient_visit_id` = `data`.`patient_visit_id`
		left join `mdi_modality` `modality_vs`
				on `data`.`modality_vs_id` = `modality_vs`.`modality_id`
		left join `hr_user` `confirmed_by`
				on `data`.`confirmed_by` = `confirmed_by`.`user_id`
	inner join `his_patient` `patient`
			on `patient_visit`.`patient_id` = `patient`.`patient_id`
	inner join `gbl_env` `org`
			on `patient_visit`.`org_id` = `org`.`org_id`
where
	(`patient_visit`.`created_on` between @StartDateTime and @EndDateTime)
		and
	(`patient_visit`.`org_id` = 1 OR `patient_visit`.`org_id` =  @OrganizationId)
order by
	`patient_visit`.`created_on` desc