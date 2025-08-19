select
	`org`.`org_id` as `OrganizationId`,
	`org`.`org_uid` as `OrganizationUid`,

	`location`.`location_id` as `LocationId`,
	concat_ws(':', `location`.`location_uid`, `location`.`location_name`) as `LocationText`,

	`sub_location`.`sub_location_id` as `SubLocationId`,
	concat_ws(':', `sub_location`.`sub_location_uid`, `sub_location`.`sub_location_name`) as `SubLocationText`


from
	 `mdi_sub_location` `sub_location`
	left join `mdi_location` `location`
			on `sub_location`.`location_id` = `location`.`location_id`
	inner join `gbl_env` `org`
			on `sub_location`.`org_id` = `org`.`org_id`
WHERE `sub_location`.`sub_location_uid` = @SubLocationUid