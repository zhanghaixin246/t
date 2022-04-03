SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;



-- 站点信息表
-- 站点名称、区域、位置（国家、城市）、详细地址、坐标 经纬度、联系人、电话、邮箱、是否加速站点、内部子网网段、下一跳、是否冗余链路
DROP TABLE IF EXISTS `linker_pro_site`;

CREATE TABLE `linker_pro_site` (
                                   `id` int(11) NOT NULL AUTO_INCREMENT,
                                   `uid` int(11) NOT NULL COMMENT '用户uid',
                                   `username` varchar(30) NOT NULL COMMENT '用户名称',
                                   `name` varchar(60) NOT NULL COMMENT '站点名称',
                                   `area` varchar(10) NOT NULL COMMENT '区域',
                                   `country` varchar(20) NOT NULL COMMENT '位置：国家',
                                   `city` varchar(20) NOT NULL COMMENT '位置：城市',
                                   `address` varchar(60) NOT NULL COMMENT '地址的详细信息',
                                   `longitude` decimal(10, 6) NOT NULL COMMENT '坐标经度',
                                   `latitude` decimal(10, 6) NOT NULL COMMENT '坐标纬度',
                                   `contact` varchar(10) NOT NULL COMMENT '联系人',
                                   `telephone` varchar(12) NOT NULL COMMENT '电话',
                                   `email` varchar(20) NOT NULL COMMENT '邮箱',
                                   `is_accelerate` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否加速站点：0否，1是',
                                   `sub_network_cidr` varchar(40) DEFAULT NULL COMMENT '内部子网网段',
                                   `next_hop` tinyint(3) NOT NULL COMMENT '下一跳',
                                   `is_redundant` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否冗余链路：0否，1是',
                                   `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '站点状态：0下线，1上线',
                                   `created_at` datetime NOT NULL COMMENT '创建时间',
                                   `updated_at` datetime NOT NULL COMMENT '更新时间',
                                   PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COMMENT '站点信息表：zh_2022_03_15';

-- cpe信息表
-- 设备类型、设备名称、CPE型号、接入方式、wan配置id（接入方式、路由开销、默认路由、ip地址、网关、子网掩码、DNS、MTU）、lan配置id、
DROP TABLE IF EXISTS `linker_pro_site`;

CREATE TABLE `linker_pro_site` (
                                   `id` int(11) NOT NULL AUTO_INCREMENT,
                                   `uid` int(11) NOT NULL COMMENT '用户uid',
                                   `username` varchar(30) NOT NULL COMMENT '用户名称',
                                   `name` varchar(60) NOT NULL COMMENT '站点名称',
                                   `area` varchar(10) NOT NULL COMMENT '区域',
                                   `country` varchar(20) NOT NULL COMMENT '位置：国家',
                                   `city` varchar(20) NOT NULL COMMENT '位置：城市',
                                   `address` varchar(60) NOT NULL COMMENT '地址的详细信息',
                                   `longitude` decimal(10, 6) NOT NULL COMMENT '坐标经度',
                                   `latitude` decimal(10, 6) NOT NULL COMMENT '坐标纬度',
                                   `contact` varchar(10) NOT NULL COMMENT '联系人',
                                   `telephone` varchar(12) NOT NULL COMMENT '电话',
                                   `email` varchar(20) NOT NULL COMMENT '邮箱',
                                   `is_accelerate` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否加速站点：0否，1是',
                                   `sub_network_cidr` varchar(40) DEFAULT NULL COMMENT '内部子网网段',
                                   `next_hop` tinyint(3) NOT NULL COMMENT '下一跳',
                                   `is_redundant` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否冗余链路：0否，1是',
                                   `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '站点状态：0下线，1上线',
                                   `created_at` datetime NOT NULL COMMENT '创建时间',
                                   `updated_at` datetime NOT NULL COMMENT '更新时间',
                                   PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARSET = utf8mb4 COMMENT '站点信息表：zh_2022_03_15';

CREATE TABLE `cpe` (
                       `id` int(11) NOT NULL AUTO_INCREMENT,
                       `name` varchar(40) NOT NULL COMMENT '设备名称',
                       `uid` int(11) NOT NULL COMMENT '用户id',
                       `version_id` int(11) NOT NULL COMMENT '版本id',
                       `cpe_username` varchar(20) NOT NULL COMMENT '设备用户名',
                       `cpe_passwd` varchar(32) NOT NULL COMMENT '设备密码',
                       `zoo_passwd` varchar(32) NOT NULL COMMENT 'zookeeper 密码',
                       `city_id` int(11) NOT NULL COMMENT '城市id',
                       `code` varchar(40) NOT NULL COMMENT '设备分配唯一码',
                       `uniqid` varchar(40) DEFAULT NULL COMMENT '设备自带唯一码',
                       `type` tinyint(3) NOT NULL DEFAULT '2' COMMENT '设备类型1=4G, 2=普通',
                       `is_near_access` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否自动就近接入 0否 1是',
                       `near_access_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前最优接入点ID',
                       `current_line` tinyint(3) NOT NULL DEFAULT '1' COMMENT '当前接入互联网的线路: 1=互联网 2=4G  3=专线(暂无)',
                       `internet_vpn_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '互联网接入vpn状态0未知1开启2关闭',
                       `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '设备状态 1离线  2运行中 3配置中 4升级中  5超时',
                       `open_status` tinyint(3) NOT NULL DEFAULT '2' COMMENT '开启状态 1开启 2关闭',
                       `port` int(11) DEFAULT NULL COMMENT '端口号',
                       `created_at` datetime NOT NULL COMMENT '创建时间',
                       `updated_at` datetime NOT NULL COMMENT '更新时间',
                       PRIMARY KEY (`id`),
                       UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=562 DEFAULT CHARSET=utf8;
