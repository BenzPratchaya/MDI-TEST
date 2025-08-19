select
	`org`.`org_id` as `OrganizationId`,
	`org`.`org_name` as `OrganizationName`,
	`org`.`org_uid` as `OrganizationUid`,
	`org`.`org_alias` as `OrganizationAlias`,
	`org`.`third_party_encoding` as `ThirdPartyEncoding`,
	`org`.`third_party_url` as `thirdPartyUrl`,
	`org`.`is_deleted` as `IsDeleted`,
   `org`.`created_by` AS `CreatedBy`,
   `org`.`created_on` AS `CreatedOn`,
   `org`.`modified_by` AS `ModifiedBy`,
   `org`.`modified_on` AS `ModifiedOn`
from
	`gbl_env` `org`
order by
	`org`.`org_id`