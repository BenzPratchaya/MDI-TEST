update
	`mdi_patient_visit`
set
	`pat_weight` = @PatientWeight,
	`pat_height` = @PatientHeight,
	`pat_bmi` = @PatientBmi,
	`pat_type` = @PatientType,
	`coma_e_score` = @ComaEScore,
	`coma_v_score` = @ComaVScore,
	`coma_m_score` = @ComaMScore,
	`smoking_status` = IFNULL(@SmokingStatus, '0'),
	`smoking_hsi` = @SmokingHsi,
	`cv_risk_score` = @CvRiskScore,
	#`news_score` = @NewsScore,
	`fall_risk_type` = @FallRiskType,
	`modified_by` = @ModifiedBy,
	`modified_on` = current_timestamp()
where
	`patient_visit_id` = @PatientVisitId