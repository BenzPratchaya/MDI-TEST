select
`user_id` as `UserId` ,
 `user_uid` as `UserUid`,
 `user_name` as `UserName`,
 `user_pwd` as `UserPwd`,
 `user_type` as `UserType`,
 `title` as `UserTitle`,
 `fname` as `UserFName`,
 `mname` as `UserMName`,
 `lname` as `UserLName`,
  `title_eng` as `UserTitleEng`,
  `fname_eng` as `UserFNameEng`,
  `mname_eng` as `UserMNameEng`,
  `lname_eng` as `UserLNameEng`,
  `is_deleted` as `IsDeleteed`,
  `org_id` as `OrganizationId`,
  `created_by` as `CreatedBy`,
  `created_on` as `CreatedOn`,
 `modified_by` as `ModifiedBy`,
  `modified_on` as `ModifiedOn`
  from `hr_user`
  where `user_name` = @UserName
  and `is_deleted` <> 1