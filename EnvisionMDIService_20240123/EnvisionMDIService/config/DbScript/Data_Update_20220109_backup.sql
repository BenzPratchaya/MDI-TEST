UPDATE `mdi_data`
SET 
	`pulse_rate` = @PulseRate,
	`spo2` = @SpO2,
	`temperature` = @Temperature,
	`is_confirmed` = @IsConfirmed,
	`modified_by` = @ModifiedBy,
	`modified_on` = now()
	
WHERE  `data_id` = @DataId