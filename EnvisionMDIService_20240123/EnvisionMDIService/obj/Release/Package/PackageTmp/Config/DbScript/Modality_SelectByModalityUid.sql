select
	`modality`.`modality_id` as `ModalityId`,
	`modality`.`modality_uid` as `ModalityUid`,
	`modality`.`modality_name` as `ModalityName`,
	`modality`.`modality_type_alias` as `ModalityTypeAlias`,
	`modality`.`modality_host` as `ModalityHost`,
	`modality`.`modality_config` as `ModalityConfig`,
	null as `ModalityLog`,
	`modality`.`vitalsign_interval` as `VitalsignInterval`,
	0 as `LocationId`,
	0 as `SubLocationId`,
	`modality`.`auto_confirm` as `AutoConfirm`,
	`modality`.`is_deleted` as `IsDeleted`,
	`modality`.`org_id` as `OrganizationId`,
	`modality`.`created_by` as `CreatedBy`,
	`modality`.`created_on` as `CreatedOn`,
	`modality`.`modified_by` as `ModifiedBy`,
	`modality`.`modified_on` as `ModifiedOn`
from
	`mdi_modality` `modality`
where
	`modality`.`modality_uid` = @ModalityUid