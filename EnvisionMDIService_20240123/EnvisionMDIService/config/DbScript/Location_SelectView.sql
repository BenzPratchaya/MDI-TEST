select
	`org`.`org_id` as `OrganizationId`,
	`org`.`org_uid` as `OrganizationUid`,
	
	`location`.`location_id` as `LocationId`,
	`location`.`location_uid` as `LocationUid`,   
	`location`.`location_name` as `LocationName`,
	`location`.`location_desc` as `LocationDesc`,
	CONCAT_WS(' : ', `location`.`location_name`, `location`.`location_desc`) as `LocationText`,
	`location`.`is_deleted` as `IsDeleted`
from
	`mdi_location` `location`
	inner join `gbl_env` `org`
			on `location`.`org_id` = `org`.`org_id`
where
	`location`.`org_id` = @OrganizationId
	or `location`.`org_id` = 1