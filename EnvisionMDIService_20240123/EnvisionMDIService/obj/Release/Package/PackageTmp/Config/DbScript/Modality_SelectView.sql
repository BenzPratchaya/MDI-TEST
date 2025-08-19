select
	`org`.`org_id` as `OrganizationId`,
	`org`.`org_name` as `OrganizationName`,
	CONCAT_WS(' : ', `location`.`location_name`, `location`.`location_desc`) as `DefaultLocationText`,

	CONCAT_WS(' : ', `sub_location`.`sub_location_name`, `sub_location`.`sub_location_desc`) AS `DefaultSubLocationText`,
	CONCAT_WS(' : ', `modality`.`modality_uid`, `modality`.`modality_name`) as `ModalityText`,

	`modality`.`modality_id` as `ModalityId`,
	`modality`.`modality_uid` as `ModalityUid`,
	`modality`.`modality_name` as `ModalityName`,
	`modality`.`modality_type_alias` as `ModalityTypeAlias`,
	`modality`.`modality_host` as `ModalityHost`,
	`modality`.`modality_config` as `ModalityConfig`,
	`modality`.`modality_log` as `ModalityLog`,
	`modality`.`vitalsign_interval` as `VitalsignInterval`,
	`modality`.`location_id` as `LocationId`,
	`modality`.`sub_location_id` as `SubLocationId`,
	`modality`.`auto_confirm` as `AutoConfirm`,
	`modality`.`is_deleted` as `IsDeleted`,
	`modality`.`modified_by` as `ModifiedBy`,
	`modality`.`modified_on` as `ModifiedOn`
from
	`mdi_modality` `modality`
	left join `mdi_location` `location`
			on `modality`.`location_id` = `location`.`location_id`
	left join `mdi_sub_location` `sub_location`
			on `modality`.`sub_location_id` = `sub_location`.`sub_location_id`
	inner join `gbl_env` `org`
			on `modality`.`org_id` = `org`.`org_id`
WHERE `modality`.`org_id` = @OrganizationId OR `modality`.`org_id` = 1
order by
	`modality`.`created_on`