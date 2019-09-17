DELIMITER $$

CREATE OR REPLACE VIEW account_data_v AS
  SELECT
    `Account`.`id`                              AS `id`,
    `Account`.`name`                            AS `name`,
    `Account`.`categoryId`                      AS `categoryId`,
    `Account`.`userId`                          AS `userId`,
    `Account`.`clientId`                        AS `clientId`,
    `Account`.`userGroupId`                     AS `userGroupId`,
    `Account`.`userEditId`                      AS `userEditId`,
    `Account`.`login`                           AS `login`,
    `Account`.`url`                             AS `url`,
    `Account`.`notes`                           AS `notes`,
    `Account`.`countView`                       AS `countView`,
    `Account`.`countDecrypt`                    AS `countDecrypt`,
    `Account`.`dateAdd`                         AS `dateAdd`,
    `Account`.`dateEdit`                        AS `dateEdit`,
    conv(`Account`.`otherUserEdit`, 10, 2)      AS `otherUserEdit`,
    conv(`Account`.`otherUserGroupEdit`, 10, 2) AS `otherUserGroupEdit`,
    conv(`Account`.`isPrivate`, 10, 2)          AS `isPrivate`,
    conv(`Account`.`isPrivateGroup`, 10, 2)     AS `isPrivateGroup`,
    `Account`.`passDate`                        AS `passDate`,
    `Account`.`passDateChange`                  AS `passDateChange`,
    `Account`.`parentId`                        AS `parentId`,
    `Category`.`name`                           AS `categoryName`,
    `Client`.`name`                             AS `clientName`,
    `ug`.`name`                                 AS `userGroupName`,
    `u1`.`name`                                 AS `userName`,
    `u1`.`login`                                AS `userLogin`,
    `u2`.`name`                                 AS `userEditName`,
    `u2`.`login`                                AS `userEditLogin`,
    `PublicLink`.`hash`                         AS `publicLinkHash`,
    `Account`.`deepLink`                        AS `deepLink`
  FROM ((((((`Account`
    LEFT JOIN `Category`
      ON ((`Account`.`categoryId` = `Category`.`id`))) INNER JOIN
    `UserGroup` `ug` ON ((`Account`.`userGroupId` = `ug`.`id`))) INNER JOIN
    `User` `u1` ON ((`Account`.`userId` = `u1`.`id`))) INNER JOIN
    `User` `u2` ON ((`Account`.`userEditId` = `u2`.`id`))) LEFT JOIN
    `Client`
      ON ((`Account`.`clientId` = `Client`.`id`))) LEFT JOIN
    `PublicLink` ON ((`Account`.`id` = `PublicLink`.`itemId`))) $$