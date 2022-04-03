
-- 用户表
DROP TABLE IF EXISTS `oversea_user`;
CREATE TABLE `oversea_user` (
                                `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `phone` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
                                `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
                                `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
                                `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
                                `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
                                PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '用户表 2022-03-29';

-- 公司管理账号表
DROP TABLE IF EXISTS `oversea_company_admin`;
CREATE TABLE `oversea_company_admin` (
                                         `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                         `phone` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
                                         `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
                                         `company_name` varchar(50) NOT NULL DEFAULT '' COMMENT '公司名称',
                                         `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
                                         `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
                                         `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
                                         PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '公司管理账号表 2022-03-29';

-- 公司管理账号授权表
DROP TABLE IF EXISTS `oversea_company_admin_grant`;
CREATE TABLE `oversea_company_admin_grant` (
                                         `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                         `admin_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司管理员账号id',
                                         `code` varchar(50) NOT NULL DEFAULT '' COMMENT '授权码',
                                         `operator_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司普通人员账号id',
                                         `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
                                         `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
                                         `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
                                             PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '公司管理账号授权表 2022-03-29';

-- 公司普通人员账号表
DROP TABLE IF EXISTS `oversea_company_operator`;
CREATE TABLE `oversea_company_operator` (
                                            `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                            `phone` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
                                            `admin_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司管理员账号id',
                                            `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
                                            `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
                                            `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
                                            `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
                                            PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '公司普通人员账号表 2022-03-29';

-- 职位表
DROP TABLE IF EXISTS `oversea_position`;
CREATE TABLE `oversea_position` (
                                            `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                            `admin_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司管理员账号id',
                                            `operator_id` int(11) NOT NULL DEFAULT 0 COMMENT '公司普通人员账号id',

                                            `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
                                            `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
                                            `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
                                            PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '职位表 2022-03-29';

-- 地区表

-- 职位类型表

-- 收藏表

-- 关注表

