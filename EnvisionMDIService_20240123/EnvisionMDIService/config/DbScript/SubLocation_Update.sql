update
	`mdi_sub_location`
set 
	`location_id` = @LocationId,
	`sub_location_uid` = @SubLocationUid,
	`sub_location_name` = @SubLocationName,
	`sub_location_desc` = @SubLocationDesc,
	`sub_location_building` = @SubLocationBuilding,
	`sub_location_floor` = @SubLocationFloor,
	`sub_location_room` = @SubLocationRoom,
	`is_deleted` = @isDeleted,
	`org_id` = @OrganizationId,
	`modified_by` = @ModifiedBy,
	`modified_on` = current_timestamp()
where
	`sub_location_id` = @SubLocationId