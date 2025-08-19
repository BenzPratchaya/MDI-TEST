select
	`data_log`.`data_log_id` as `DataLogId`,
	`data_log`.`data_id` as `DataId`,
	`data_log`.`vs_dt` as `VsDateTime`,
	`data_log`.`pulse_rate` as `PulseRate`,
	`data_log`.`pulse_unit` as `PulseUnit`,
	case `data_log`.`pulse_flag` 
		when 'N' then 'Normal'
		when 'L' then 'Below Normal'
		when 'H' then 'Above Normal'
		when 'A' then 'Other Abnormal'
		else ''
	end as `Pulseflag`,
	`data_log`.`blood_pressure_systolic` as `BloodPressureSystolic`,
	`data_log`.`blood_pressure_diastolic` as `BloodPressureDiastolic`,
	`data_log`.`blood_pressure_mean` as `BloodPressureMean`,
	`data_log`.`blood_pressure` as `BloodPressure`,
	`data_log`.`blood_pressure_unit` as `BloodPressureUnit`,
	`data_log`.`blood_pressure_method` as `BloodPressureMethod`,
	`data_log`.`spo2` as `Spo2`,
	`data_log`.`spo2_unit` as `Spo2Unit`,
	`data_log`.`temperature` as `Temperature`,
	`data_log`.`temperature_unit` as `TemperatureUnit`,
	`data_log`.`temperature_method` as `TemperatureMethod`,
	`data_log`.`respiration_rate` as `RespirationRate`,
	`data_log`.`pain_scale` as `PainScale`,
	`modality_vs`.`modality_id` as `ModalityWhId`,
	concat_ws(':', `modality_vs`.`modality_uid`, `modality_vs`.`modality_name`) as `ModalityVsText`
from
	`mdi_data_log` `data_log`
	left join `mdi_modality` `modality_vs`
			on `data_log`.`modality_vs_id` = `modality_vs`.`modality_id`

where
	`data_log`.`data_id` = @DataId
order by
	`data_log`.`data_log_id` desc