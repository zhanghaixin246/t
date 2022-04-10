-- 用户表
DROP TABLE IF EXISTS `oversea_user`;
CREATE TABLE `oversea_user`
(
    `id`                 int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `phone`              varchar(50)   NOT NULL DEFAULT '' COMMENT '手机号',
    `name`               varchar(50)   NOT NULL DEFAULT '' COMMENT '用户名',
    `real_name`          varchar(50)   NOT NULL DEFAULT '' COMMENT '姓名',
    `location`           varchar(50)   NOT NULL DEFAULT '' COMMENT '所在地区',
    `card_photo_front`   varchar(2083) NOT NULL DEFAULT '' COMMENT '身份证正面照',
    `card_photo_backend` varchar(2083) NOT NULL DEFAULT '' COMMENT '身份证反面照',
    `skill`              varchar(500)  NOT NULL DEFAULT '' COMMENT '技能',
    `status`             tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at`         datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at`         datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at`         datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '用户表 2022-03-29';

-- 公司管理账号表
DROP TABLE IF EXISTS `oversea_company_admin`;
CREATE TABLE `oversea_company_admin`
(
    `id`           int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `phone`        varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
    `name`         varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
    `company_id`   int(11) NOT NULL DEFAULT 0 COMMENT '公司id',
    `company_name` varchar(50) NOT NULL DEFAULT '' COMMENT '公司名称',
    `status`       tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at`   datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at`   datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at`   datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '公司管理账号表 2022-03-29';

-- 公司信息表
DROP TABLE IF EXISTS `oversea_company_admin`;
CREATE TABLE `oversea_company_admin`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name`       varchar(50) NOT NULL DEFAULT '' COMMENT '公司名称',
    `status`     tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '公司信息表 2022-03-29';

-- 公司管理账号授权表
DROP TABLE IF EXISTS `oversea_company_admin_grant`;
CREATE TABLE `oversea_company_admin_grant`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `company_admin_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司管理员账号id',
    `company_id`       int(11) NOT NULL DEFAULT 0 COMMENT '公司id',
    `code`             varchar(50) NOT NULL DEFAULT '' COMMENT '授权码',
    `operator_id`      int(11) NOT NULL DEFAULT 0 COMMENT '公司普通人员账号id',
    `status`           tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at`       datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at`       datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at`       datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '公司管理账号授权表 2022-03-29';

-- 公司普通人员账号表
DROP TABLE IF EXISTS `oversea_company_operator`;
CREATE TABLE `oversea_company_operator`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `phone`            varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
    `company_admin_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司管理员账号id',
    `company_id`       int(11) NOT NULL DEFAULT 0 COMMENT '公司id',
    `name`             varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
    `status`           tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at`       datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at`       datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at`       datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '公司普通人员账号表 2022-03-29';

-- 职位信息表
DROP TABLE IF EXISTS `oversea_position`;
CREATE TABLE `oversea_position`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `company_id`       int(11) NOT NULL DEFAULT 0 COMMENT '公司id',
    `company_admin_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司管理员账号id',
    `operator_id`      int(11) NOT NULL DEFAULT 0 COMMENT '公司普通人员账号id',
    `region`           varchar(100)  NOT NULL DEFAULT 0 COMMENT '职位所在地区',
    `pay`              varchar(100)  NOT NULL DEFAULT '' COMMENT '薪资',
    `benefits`         text          NOT NULL DEFAULT '' COMMENT '其他福利',
    `photo_1`          varchar(2083) NOT NULL DEFAULT '' COMMENT '照片',
    `photo_2`          varchar(2083) NOT NULL DEFAULT '' COMMENT '照片',
    `photo_3`          varchar(2083) NOT NULL DEFAULT '' COMMENT '照片',
    `photo_4`          varchar(2083) NOT NULL DEFAULT '' COMMENT '照片',
    `photo_5`          varchar(2083) NOT NULL DEFAULT '' COMMENT '照片',
    `other`            text          NOT NULL DEFAULT '' COMMENT '其他说明',
    `status`           tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at`       datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at`       datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at`       datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '职位信息表 2022-03-29';

-- 地区表 todo

-- 职位类型表 todo

-- 职位收藏表
DROP TABLE IF EXISTS `oversea_company_collection`;
CREATE TABLE `oversea_collection`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `user_id`     int(11) NOT NULL DEFAULT 0 COMMENT '用户id',
    `position_id` int(11) NOT NULL DEFAULT 0 COMMENT '职位id',
    `status`      tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at`  datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at`  datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at`  datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '职位收藏表 2022-04-10';


-- 人员关注表
DROP TABLE IF EXISTS `oversea_company_follow`;
CREATE TABLE `oversea_follow`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `company_admin_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司管理员账号id',
    `user_id`          int(11) NOT NULL DEFAULT 0 COMMENT '用户id',
    `status`           tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常，2异常',
    `created_at`       datetime(3) DEFAULT NULL COMMENT '创建时间',
    `created_at`       datetime(3) DEFAULT NULL COMMENT '创建时间',
    `updated_at`       datetime(3) DEFAULT NULL COMMENT '更新时间',
    `deleted_at`       datetime(3) DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '人员关注表 2022-04-10';
