select
	`patient`.`hn` as `Hn`,
	concat_ws(' ', `patient`.`title`, `patient`.`fname`, `patient`.`mname`, `patient`.`lname`) as `PatientName`,

	`sub_location`.`sub_location_uid` as `SubLocationUid`,
	
	`patient_visit`.`pat_weight` as `PatientWeight`,
	`patient_visit`.`pat_height` as `PatientHeight`,
	`patient_visit`.`smoking_status` as `SmokingStatus`,
	`patient_visit`.`smoking_hsi` as `SmokingHSI`,
	`patient_visit`.`coma_e_score` as `ComaEScore`,
	`patient_visit`.`coma_v_score` as `ComaVScore`,
	`patient_visit`.`coma_m_score` as `ComaMScore`,
	`patient_visit`.`cv_risk_score` as `CVRiskScore`,
	`patient_visit`.`news_score` as `NewsScore`,
	
	`fall_risk_type`.`general_uid` as FallRiskTypeUid,
	
	`data`.`data_id` as DataId,
	`data`.`pulse_rate` as `PulseRate`,
	`data`.`blood_pressure_systolic` as `BloodPressureSystolic`,
	`data`.`blood_pressure_diastolic` as `BloodPressureDiastolic`,
	`data`.`spo2` as `Spo2`,
	`data`.`respiration_rate` as `RespirationRate`,
	`data`.`temperature` as `Temperature`,
	`data`.`pain_scale` as `PainScale`,
	`data`.`comment` as `Comment`,
	
	case when IFNULL(`data`.`confirmed_by_uid`, '') = '' then `confirmed_by`.`user_uid`
		else `data`.`confirmed_by_uid`
	end as `ConfirmedByUid`,
	current_timestamp() as `ConfirmedOn`,
	current_timestamp() as `ModifiedOn`
from
	`mdi_patient_visit` `patient_visit`
	left join `mdi_sub_location` `sub_location`
			on `patient_visit`.`sub_location_id` = `sub_location`.`sub_location_id`
	inner join `mdi_data` `data`
			on `patient_visit`.`patient_visit_id` = `data`.`patient_visit_id`
		left join `hr_user` `confirmed_by`
				on `data`.`confirmed_by` = `confirmed_by`.`user_id`
	inner join `his_patient` `patient`
			on `patient_visit`.`patient_id` = `patient`.`patient_id`
	left join `gbl_general` `fall_risk_type`
			on `patient_visit`.`fall_risk_type` = `fall_risk_type`.`general_id`
where
	`data`.`data_id` = @DataId