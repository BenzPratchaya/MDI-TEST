UPDATE `mdi_data`
SET 
	`pulse_rate` = @PulseRate,
	`blood_pressure` = @BloodPressure,
	`blood_pressure_systolic` = @BloodPressureSystolic,
	`blood_pressure_diastolic` = @BloodPressureDiastolic,
	`blood_pressure_mean` = @BloodPressureMean,
	`temperature` = @Temperature,
	`respiration_rate` = @RespirationRate,
	`spo2` = @SpO2,
	`pain_scale` = @PainScale,
	`comment` = @Comment,
	`is_confirmed` = @IsConfirmed,
	`confirmed_by` = @ConfirmedBy,
	`confirmed_on` = now(),
	`confirmed_by_uid` = @ConfirmedByUid,
	`modified_by` = @ModifiedBy,
	`modified_on` = now()
WHERE  `data_id` = @DataId