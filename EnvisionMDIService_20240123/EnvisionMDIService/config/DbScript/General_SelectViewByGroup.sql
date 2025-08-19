select 
`gbl_general`.`general_id` as `GeneralId`,
`gbl_general`.`general_uid` as `GeneralUid`,
`gbl_general`.`general_name` as `GeneralName`,
`gbl_general`.`general_group` as `GeneralGroup`,
`gbl_general`.`is_default` as `IsDefault`,
`gbl_general`.`is_deleted` as `IsDeleted`,
`gbl_general`.`created_by` as `CreatedBy`,
`gbl_general`.`created_on` as `CreatedOn`,
`gbl_general`.`modified_by` as `ModifiedBy`,
`gbl_general`.`modified_on` as `ModifiedOn`
from 
`gbl_general`
where
`gbl_general`.`general_group` = @GeneralGroup