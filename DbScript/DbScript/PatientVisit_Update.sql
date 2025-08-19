update
	`mdi_patient_visit`
set
	`pat_weight` = @PatientWeight,
	`pat_height` = @PatientHeight,
	`pat_bmi` = @PatientBmi,
	`pat_type` = @PatientType,
	`modified_by` = @ModifiedBy,
	`modified_on` = current_timestamp()
where
	`patient_visit_id` = @PatientVisitId