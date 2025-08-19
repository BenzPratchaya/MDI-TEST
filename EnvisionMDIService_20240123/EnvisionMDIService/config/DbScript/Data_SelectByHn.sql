select
  	`patient_visit`.`org_id`,
  	`patient_visit`.`patient_id`,
  	`patient_visit`.`patient_visit_id` as `PatientVisitId`,
  	`patient_visit`.`location_id` as `LocationId`,
  	`patient_visit`.`visit_no` as `VisitNo`,
  	`patient_visit`.`pat_weight` as PatientWeight,
	`patient_visit`.`pat_height` as PatientHeight,
	`patient_visit`.`pat_bmi` as PatientBmi,
	`patient_visit`.`pat_type` as PatientType,
	`patient_visit`.`coma_e_score` as ComaEScore,
	`patient_visit`.`coma_v_score` as ComaVScore,
	`patient_visit`.`coma_m_score` as ComaMScore,
	`patient_visit`.`smoking_status` as SmokingStatus,
	`patient_visit`.`smoking_hsi` as SmokingHsi,
	`patient_visit`.`cv_risk_score` as CvRiskScore,
	`patient_visit`.`news_score` as NewsScore,
	`patient_visit`.`wh_dt` as `WhDateTime`,
	`patient_visit`.`created_on` as `CreatedOn`,
	`data`.`data_id` as `DataId`,
	`data`.`pulse_rate` as PulseRate,
	`data`.`blood_pressure` as BloodPressure,
	`data`.`blood_pressure_systolic` as BloodPressureSystolic,
	`data`.`blood_pressure_diastolic` as BloodPressureDiastolic,
	`data`.`blood_pressure_mean` as BloodPressureMean,
	`data`.`temperature` as Temperature,
	`data`.`respiration_rate` as RespirationRate,
	`data`.`spo2` as SpO2,
	`data`.`pain_scale` as PainScale,
	`data`.`comment` as Comment,
	`data`.`is_confirmed` as IsConfirmed,
	`data`.`confirmed_by` as ConfirmedBy,
	`data`.`confirmed_by_uid` as ConfirmedByUid,
	`patient`.`hn` as Hn,
	`patient`.`dob` AS `PatientDob`,
	concat_ws(' ', `patient`.`title`, `patient`.`fname`, `patient`.`mname`, `patient`.`lname`) as `PatientName`,
  	case `patient`.`gender`
		when 'M' then 'ชาย'
		when 'F' then 'หญิง'
		else ''
	end as `PatientGenderText`,
  	case `patient_visit`.`pat_type`
		when 'A' then 'Adult'
		when 'P' then 'Pediatric'
		when 'N' then 'Neonatal'
		else ''
	end as `PatientTypeText`,
  	fnAgeText(`patient_visit`.`created_on`, `patient`.`dob`) as `PatientAgeText`,
  	`modality_wh`.`modality_name` as `ModalityWhText`,
  	`modality_wh`.`location_id` as `ModalityLocationId`,
  	'' as SubLocationText,
  	concat_ws(' ', `data`.`temperature`, `data`.`temperature_unit`) as `TemperatureText`,
  	concat_ws(' ', `data`.`spo2`, `data`.`spo2_unit`) as `Spo2Text`,
  	concat_ws(' ', `patient_visit`.`pat_height`, `patient_visit`.`height_unit`) as `PatientHeightText`,
  	concat_ws(' ', `patient_visit`.`pat_weight`, `patient_visit`.`weight_unit`) as `PatientWeightText`,
  	concat_ws(' ', `data`.`blood_pressure`, `data`.`blood_pressure_unit`) as `BloodPressureText`,
  	concat_ws(' ', `data`.`pulse_rate`, `data`.`pulse_unit`) as `PulseRateText`,
  	case `data`.`data_status`
		when 'N' then 'Schedule'
		when 'C' then 'Confirmed'
		else ''
	end as `DataStatusText`,
	IFNULL( `visit_location`.`location_name`, `mod_location`.`location_name`) as LocationText
  	
from
  `mdi_patient_visit` `patient_visit`
  left join `mdi_data` `data`
			on `patient_visit`.`patient_visit_id` = `data`.`patient_visit_id`
  inner join `his_patient` `patient`
			on `patient_visit`.`patient_id` = `patient`.`patient_id`
  left join `mdi_location` `location`
			on `patient_visit`.`location_id` = `location`.`location_id`
  left join `mdi_modality` `modality_wh`
			on `patient_visit`.`modality_wh_id` = `modality_wh`.`modality_id`
	left join `mdi_location` `mod_location`
			on `modality_wh`.`location_id` = `mod_location`.`location_id`
	left join `mdi_location` `visit_location`
			on `patient_visit`.`location_id` = `visit_location`.`location_id`
where
	`patient`.`hn` = @Hn
	#and DATE(`patient_visit`.`created_on`) = CURDATE()
order by
	`patient_visit`.`created_on` 