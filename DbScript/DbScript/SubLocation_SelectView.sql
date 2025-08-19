select
	`org`.`org_id` as `OrganizationId`,
	`org`.`org_uid` as `OrganizationUid`,

	`location`.`location_id` as `LocationId`,
	concat_ws(':', `location`.`location_name`, `location`.`location_desc`) as `LocationText`,

	`sub_location`.`sub_location_id` as `SubLocationId`,
	concat_ws(':', `sub_location`.`sub_location_name`, `sub_location`.`sub_location_desc`) as `SubLocationText`,

      `sub_location`.`sub_location_uid` as SubLocationUid,
      `sub_location`.`sub_location_name` as SubLocationName,
      `sub_location`.`sub_location_desc` as SubLocationDesc,
      `sub_location`.`sub_location_building` as SubLocationBuilding,
      `sub_location`.`sub_location_floor` as SubLocationFloor,
      `sub_location`.`sub_location_room` as SubLocationRoom,
      `sub_location`.`is_deleted` as IsDeleted,
      `sub_location`.`created_by` as CreatedBy,
      `sub_location`.`created_on` as CreatedOn,
      `sub_location`.`modified_by` as ModifiedBy,
      `sub_location`.`modified_on` as ModifiedOn,
      `org`.`org_name` as OrganizationName

from
	 `mdi_sub_location` `sub_location`
	left join `mdi_location` `location`
			on `sub_location`.`location_id` = `location`.`location_id`
	inner join `gbl_env` `org`
			on `sub_location`.`org_id` = `org`.`org_id`
	WHERE (`sub_location`.`org_id` = 1 OR `sub_location`.`org_id` = @OrganizationId )

