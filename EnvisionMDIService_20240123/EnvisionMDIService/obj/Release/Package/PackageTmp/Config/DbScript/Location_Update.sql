update
	`mdi_location`
set 
	`location_id` = @LocationId,
	`location_uid` = @LocationUid,
	`location_name` = @LocationName,
	`location_desc` = @LocationDesc,
	`is_deleted` = @isDeleted,
	`org_id` = @OrganizationId,
	`modified_by` = @ModifiedBy,
	`modified_on` = current_timestamp()
where
	`location_id` = @LocationId