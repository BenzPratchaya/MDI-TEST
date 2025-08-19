UPDATE `mdi_modality`
SET 
	`modality_uid` = @ModalityUid,
	`modality_name` = @ModalityName,
	`modality_type_alias` = @ModalityTypeAlias,
	`modality_host` = @ModalityHost,
	`modality_config` = @ModalityConfig,
	`modality_log` = @vitalsignInterval,
	`vitalsign_interval` = @vitalsignInterval,
	`location_id` = @LocationId,
	`sub_location_id` = @SubLocationId,
	`auto_confirm` = @AutoConfirm,
	`is_deleted` = @IsDeleted,
	`org_id` = @OrganizationId,
	`modified_by` = @ModifiedBy,
	`modified_on` = current_timestamp()
	
WHERE  `modality_id` = @ModalityId