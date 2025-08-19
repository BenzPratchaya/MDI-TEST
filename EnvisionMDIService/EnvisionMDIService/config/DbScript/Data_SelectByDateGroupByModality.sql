SELECT 
DATE_FORMAT(`patient_visit`.`created_on`,'%Y-%m-%d') AS `date`,
IFNULL( `visit_location`.`location_name`, `mod_location`.`location_name`) as location, 	
`modality_wh`.`modality_name` as `modality`,
COUNT(*) as `count`
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
WHERE 
	(`patient_visit`.`created_on` between @StartDateTime and @EndDateTime)
		and
	(`patient_visit`.`org_id` = 1 OR `patient_visit`.`org_id` =  @OrganizationId)
	and `patient_visit`.`created_on` is not null
group by DATE_FORMAT(`patient_visit`.`created_on`,'%Y-%m-%d'), IFNULL( `visit_location`.`location_name`, `mod_location`.`location_name`), `modality_wh`.`modality_name`;