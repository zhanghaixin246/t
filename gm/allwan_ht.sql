/*
 Navicat Premium Data Transfer

 Source Server         : agotoz
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 172.16.1.58:3306
 Source Schema         : allwan_ht

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 14/03/2022 18:03:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `realname` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '真实姓名',
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` char(11) COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '手机号',
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `data` blob,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `admin_menu_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `admin_menu` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for allwan_detail_routes
-- ----------------------------
DROP TABLE IF EXISTS `allwan_detail_routes`;
CREATE TABLE `allwan_detail_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) DEFAULT NULL,
  `cidr_url` varchar(1000) DEFAULT NULL,
  `cidr_block` varchar(20) DEFAULT NULL,
  `next_hop_type` tinyint(3) DEFAULT NULL,
  `via` tinyint(3) DEFAULT NULL,
  `dev_name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_assignment
-- ----------------------------
DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `auth_assignment_user_id_idx` (`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for auth_item
-- ----------------------------
DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for base_accesspoint_alarm
-- ----------------------------
DROP TABLE IF EXISTS `base_accesspoint_alarm`;
CREATE TABLE `base_accesspoint_alarm` (
  `access_id` int(11) NOT NULL COMMENT '接入点id',
  `content` text COMMENT '事件详情',
  `status` tinyint(3) DEFAULT '0' COMMENT '状态0未知1OK,2PROBLEM',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`access_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for base_lan
-- ----------------------------
DROP TABLE IF EXISTS `base_lan`;
CREATE TABLE `base_lan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `sub_uid` int(11) DEFAULT '0' COMMENT '子用户uid',
  `name` varchar(20) DEFAULT '' COMMENT '名称',
  `type` tinyint(3) DEFAULT NULL COMMENT '私网类型1同城2全国3国际',
  `city_id` int(11) DEFAULT '0' COMMENT '城市id',
  `lan_group_id` int(11) DEFAULT '0' COMMENT '私网分组id',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `lan_u` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8 COMMENT='私网表';

-- ----------------------------
-- Table structure for base_lan_group
-- ----------------------------
DROP TABLE IF EXISTS `base_lan_group`;
CREATE TABLE `base_lan_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '分组名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for base_lan_node
-- ----------------------------
DROP TABLE IF EXISTS `base_lan_node`;
CREATE TABLE `base_lan_node` (
  `ln_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `sub_uid` int(11) DEFAULT '0' COMMENT '子用户uid',
  `cpe_id` int(11) NOT NULL DEFAULT '0' COMMENT 'cpe设备id',
  `price_type` tinyint(3) NOT NULL COMMENT '计费类型1同城价格2国内价格3国际价格4NRC',
  `ln_version` varchar(20) DEFAULT 'v2.0.0' COMMENT 'allwan下发版本',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型:1云服务商 2idc 3楼宇 4互联网接入 5cpe接入 6NAT',
  `bandwidth_collect_type` tinyint(3) DEFAULT '0' COMMENT '采集带宽类型 0默认 1云服务商 2idc 3楼宇 4互联网接入 5cpe接入 6NAT',
  `lan_id` int(11) NOT NULL DEFAULT '0' COMMENT '私网id',
  `lan_group_id` int(11) DEFAULT '0' COMMENT '私网分组id',
  `node_id` int(11) NOT NULL COMMENT '站点id',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT '节点名称',
  `pa_unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '父服务单元ID',
  `access_point_id` int(11) NOT NULL DEFAULT '0' COMMENT '接入点ID',
  `is_backup` tinyint(3) NOT NULL DEFAULT '0' COMMENT '接入点是否有备线',
  `route_tables` varchar(500) DEFAULT NULL COMMENT '路由表IDS',
  `unit_id` int(11) NOT NULL COMMENT '服务单元ID',
  `city_id` int(11) NOT NULL COMMENT '城市ID',
  `internet_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '互联网接入类型0非互联网接入1grevpn2ipsecvpn3ssl',
  `internet_group_type` tinyint(3) DEFAULT '0' COMMENT '互联网接入类型1总部2分支0无',
  `cpe_master` tinyint(3) DEFAULT '0' COMMENT 'cpe主线接入方式0未知 1专线接入2互联网接入',
  `cpe_backup` tinyint(3) DEFAULT '0' COMMENT 'cpe备线接入0没有备线1专线接入2互联网接入',
  `cpe_current` tinyint(3) DEFAULT '0' COMMENT '当前使用的线路 0没 1主线 2备线',
  `route_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '路由模式1BGP 2静态路由',
  `bgp_as` bigint(18) DEFAULT NULL COMMENT '自治系统号(ASN)',
  `bgp_key` varchar(32) DEFAULT NULL COMMENT 'BGP AS',
  `is_bfd` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否开启bfd0不开启开启',
  `bfd_min_tx_interval` int(11) NOT NULL DEFAULT '0' COMMENT 'BFD报文接收间隔时间',
  `bfd_min_rx_interval` int(11) NOT NULL DEFAULT '0' COMMENT 'BFD报文发送间隔时间',
  `bfd_detect_multiplier` int(11) NOT NULL DEFAULT '0' COMMENT 'BFD会话的检测倍数',
  `cidr` varchar(5000) DEFAULT NULL COMMENT '地址网段',
  `duration` int(11) NOT NULL COMMENT '购买时间',
  `bandwidth` int(11) NOT NULL COMMENT '购买带宽',
  `effective_time` datetime DEFAULT NULL COMMENT '生效日期',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 1待开通2 开通中3 已开通4续费中5删除中6配置中7 等待接入',
  `notify_times` tinyint(3) DEFAULT '0' COMMENT '通知次数',
  `if_name` varchar(60) DEFAULT NULL COMMENT '接口索引信息',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `comment` varchar(1000) DEFAULT NULL COMMENT '备注',
  `sort` int(11) DEFAULT '0' COMMENT '排序 ',
  PRIMARY KEY (`ln_id`),
  KEY `uid` (`uid`),
  KEY `lan` (`lan_id`),
  KEY `node` (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1765 DEFAULT CHARSET=utf8 COMMENT='私网节点表';

-- ----------------------------
-- Table structure for base_lan_node_blockhole
-- ----------------------------
DROP TABLE IF EXISTS `base_lan_node_blockhole`;
CREATE TABLE `base_lan_node_blockhole` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ln_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL COMMENT '用户Uid',
  `ip` varchar(30) DEFAULT NULL,
  `status` tinyint(3) DEFAULT NULL COMMENT '状态1黑洞2已经解封',
  `in_mps` double(10,2) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ln` (`ln_id`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=1142 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for base_lan_node_internet
-- ----------------------------
DROP TABLE IF EXISTS `base_lan_node_internet`;
CREATE TABLE `base_lan_node_internet` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `lan_id` int(11) DEFAULT NULL COMMENT '网络id',
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `ln_id` int(11) NOT NULL COMMENT '私网节点id',
  `internet_ip` varchar(17) NOT NULL COMMENT '公网ip',
  `ike_version` varchar(20) NOT NULL COMMENT '版本',
  `ike_share_pre_secret_key` varchar(40) NOT NULL COMMENT '共享密钥',
  `ike_encrypt_algorithm` varchar(20) NOT NULL COMMENT '加密算法',
  `ike_authentication_algorithm` varchar(20) NOT NULL COMMENT '认证算法',
  `ike_consult_model` varchar(20) NOT NULL COMMENT '协商模式',
  `ike_dh_group` varchar(20) NOT NULL COMMENT 'DH group',
  `ike_left_indent_type` tinyint(3) DEFAULT NULL COMMENT '左侧标识类型1 ip 2 fqdn',
  `ike_right_indent_type` tinyint(3) DEFAULT NULL COMMENT '右侧标识类型1 ip 2 fqdn',
  `ike_right_indent` varchar(20) NOT NULL COMMENT '客户侧标识',
  `ike_left_indent` varchar(20) NOT NULL COMMENT '观脉侧标识',
  `ike_sa_life_time` int(11) NOT NULL COMMENT 'IKE SA生命周期',
  `ipsec_encrypt_algorithm` varchar(20) NOT NULL COMMENT '加密算法',
  `ipsec_authentication_algorithm` varchar(20) NOT NULL COMMENT '认证算法',
  `ipsec_message_encapsulation_model` varchar(20) NOT NULL DEFAULT 'Tunnel' COMMENT '报文封装模式',
  `ipsec_secret_protocol` varchar(20) NOT NULL DEFAULT 'ESP' COMMENT '安全协议',
  `ipsec_pfs` varchar(20) NOT NULL COMMENT 'PFS',
  `ipsec_sa_lifetime_second` int(11) NOT NULL COMMENT 'IPSec SA生存周期(s)',
  `ipsec_sa_lifetime_kb` int(11) NOT NULL COMMENT 'IPSec SA生存周期(Kb)',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `ln_id` (`ln_id`),
  CONSTRAINT `ln_id` FOREIGN KEY (`ln_id`) REFERENCES `base_lan_node` (`ln_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=438 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for base_node
-- ----------------------------
DROP TABLE IF EXISTS `base_node`;
CREATE TABLE `base_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `unit_id` int(11) DEFAULT '0' COMMENT '所属服务单元',
  `access_point_id` int(11) DEFAULT NULL COMMENT '接入点id',
  `cpe_id` int(11) DEFAULT '0' COMMENT '关联cpe_id',
  `vpc_id` varchar(32) DEFAULT NULL COMMENT 'VPC ID',
  `service_uid` varchar(32) DEFAULT NULL COMMENT '客户云账号id',
  `secret_id` varchar(64) DEFAULT NULL COMMENT '密钥id',
  `secret_key` varchar(64) DEFAULT NULL COMMENT '密钥',
  `created_at` datetime DEFAULT NULL COMMENT '创建日期',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日期',
  `setting_mode` tinyint(3) DEFAULT '1' COMMENT '模式 1allwan自动配置 2allwan_手动 3阿里云自动4腾讯云自动',
  `refing` int(11) DEFAULT '0' COMMENT '正在使用数量',
  `status` tinyint(3) DEFAULT '0' COMMENT '状态0未使用1使用中2维护中',
  `is_one_price` tinyint(3) DEFAULT '0' COMMENT '0:未收取 1:已收取过一次性费用',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `unit` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42431 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for base_order
-- ----------------------------
DROP TABLE IF EXISTS `base_order`;
CREATE TABLE `base_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `user_uname` varchar(50) DEFAULT NULL COMMENT '客户账号',
  `user_realname` varchar(50) DEFAULT NULL COMMENT '客户realname',
  `user_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型0未确认1个人2企业',
  `user_is_contract` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否合同用户0不是1是',
  `type` tinyint(3) DEFAULT NULL COMMENT '订单类型1开通订单2续费订单',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `pay_status` tinyint(3) NOT NULL COMMENT '支付状态0支付中1支付成功2支付失败',
  `sum_money` double(10,2) NOT NULL COMMENT '订单总金额',
  `money` double(10,2) NOT NULL COMMENT '实际总金额',
  `currency_code` varchar(3) DEFAULT NULL COMMENT '交易币种',
  `pay_time` datetime DEFAULT NULL COMMENT '支付成功时间',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `pay_type` tinyint(3) DEFAULT NULL COMMENT '支付方式1支付宝2微信3bank4余额5合同支付',
  `trade_no` varchar(50) DEFAULT NULL COMMENT '交易号',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '删除状态',
  `is_test` int(11) NOT NULL DEFAULT '0' COMMENT '是否测试 0:正常 1:测试',
  PRIMARY KEY (`id`),
  KEY `userss` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2308 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Table structure for base_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `base_order_detail`;
CREATE TABLE `base_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `ln_id` int(11) NOT NULL COMMENT '私网节点id',
  `ln_name` varchar(30) NOT NULL DEFAULT '' COMMENT '节点名称',
  `bandwidth` int(11) DEFAULT NULL COMMENT '带宽',
  `effective_time` datetime DEFAULT NULL COMMENT '开通时间',
  `expire_time` datetime DEFAULT NULL COMMENT '到期时间',
  `end_time` datetime DEFAULT NULL COMMENT '手动结束时间',
  `duration` int(11) DEFAULT '0' COMMENT '购买月份',
  `price` double(10,2) DEFAULT NULL COMMENT '单价',
  `one_price` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '一次性费用',
  `origin_money` double(10,2) DEFAULT NULL COMMENT '原总金额',
  `money` double(10,2) DEFAULT NULL COMMENT '实际总金额',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注',
  `strategy_id` int(11) DEFAULT '0' COMMENT '优惠策略id',
  `task_detail_id` int(11) DEFAULT '0' COMMENT '任务详情id',
  `bandwidth_status` tinyint(3) DEFAULT '1' COMMENT '1升速2降速3保持不变',
  `status` tinyint(3) DEFAULT '1' COMMENT '状态1未下发2已下发3生效中4已经结束',
  `unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务单元ID',
  `unit_name` varchar(30) NOT NULL DEFAULT '' COMMENT '服务商名称',
  `city_id` int(11) NOT NULL DEFAULT '0' COMMENT '城市ID',
  `city_name` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `contract_id` int(11) DEFAULT NULL COMMENT '合同id',
  `company_tax` varchar(50) DEFAULT '' COMMENT '甲方公司税号',
  `currency_code` varchar(3) DEFAULT NULL COMMENT '交易币种',
  `delete_status` int(11) NOT NULL DEFAULT '0' COMMENT '删除状态',
  `is_test` int(11) NOT NULL DEFAULT '0' COMMENT '是否测试 0:正常 1:测试',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order` (`order_id`),
  KEY `ln` (`ln_id`),
  KEY `uid` (`uid`),
  CONSTRAINT `ln` FOREIGN KEY (`ln_id`) REFERENCES `base_lan_node` (`ln_id`),
  CONSTRAINT `order` FOREIGN KEY (`order_id`) REFERENCES `base_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2490 DEFAULT CHARSET=utf8 COMMENT='订单明细表';

-- ----------------------------
-- Table structure for base_user
-- ----------------------------
DROP TABLE IF EXISTS `base_user`;
CREATE TABLE `base_user` (
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `sum_outbound` bigint(20) DEFAULT '0' COMMENT '输出流量',
  `sum_inbound` bigint(20) DEFAULT '0' COMMENT '输入流量',
  `warning_threshold` decimal(10,2) DEFAULT '0.80' COMMENT '警告阈值',
  `error_threshold` decimal(10,2) DEFAULT '0.90' COMMENT '错误阈值',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bgp_alarm
-- ----------------------------
DROP TABLE IF EXISTS `bgp_alarm`;
CREATE TABLE `bgp_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `endpoint` varchar(50) DEFAULT NULL COMMENT '源endpoint',
  `counter` varchar(250) DEFAULT NULL COMMENT '源监控项',
  `to_endpoint` varchar(50) DEFAULT NULL COMMENT '目的endpoint',
  `to_counter` varchar(250) DEFAULT NULL COMMENT '目的监控项',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_endpoint_counter` (`endpoint`,`counter`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for block_ips
-- ----------------------------
DROP TABLE IF EXISTS `block_ips`;
CREATE TABLE `block_ips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isp_id` int(11) NOT NULL,
  `isp_index` int(11) NOT NULL,
  `firewall_id` int(11) DEFAULT NULL,
  `ip` bigint(20) DEFAULT NULL,
  `isp_cidr` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `inbps` bigint(20) DEFAULT NULL,
  `outbps` bigint(20) DEFAULT NULL,
  `outpps` bigint(20) DEFAULT NULL,
  `synpps` bigint(20) DEFAULT NULL,
  `synackpps` bigint(20) DEFAULT NULL,
  `ackpps` bigint(20) DEFAULT NULL,
  `rstpps` bigint(20) DEFAULT NULL,
  `udppps` bigint(20) DEFAULT NULL,
  `icmppps` bigint(20) DEFAULT NULL,
  `connin` bigint(20) DEFAULT NULL,
  `connout` bigint(20) DEFAULT NULL,
  `udpbps` bigint(20) DEFAULT NULL,
  `icmpbps` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `end_time_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for business_city
-- ----------------------------
DROP TABLE IF EXISTS `business_city`;
CREATE TABLE `business_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '开通城市主键',
  `country` varchar(11) NOT NULL COMMENT '开通国家',
  `city` varchar(11) NOT NULL COMMENT '开通城市',
  `lang` varchar(10) DEFAULT NULL COMMENT '经度',
  `lat` varchar(10) DEFAULT NULL COMMENT '维度',
  PRIMARY KEY (`id`),
  UNIQUE KEY `city_u` (`city`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for business_group
-- ----------------------------
DROP TABLE IF EXISTS `business_group`;
CREATE TABLE `business_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父id',
  `business_group_name` varchar(50) NOT NULL DEFAULT '' COMMENT '业务组名称',
  `cidr` varchar(1024) NOT NULL DEFAULT '' COMMENT '地址网段',
  `protocol_port` varchar(256) NOT NULL DEFAULT '' COMMENT '协议端口',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for business_price
-- ----------------------------
DROP TABLE IF EXISTS `business_price`;
CREATE TABLE `business_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `city_id` int(11) NOT NULL COMMENT '城市id',
  `bandwidth` int(11) NOT NULL COMMENT '带宽',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型1云服务商2idc3楼宇4互联网接入5CPE接入6NAT',
  `city_price` double(10,2) NOT NULL COMMENT '同城价格',
  `internal_price` double(10,2) NOT NULL COMMENT '国内价格',
  `international_price` double(10,2) NOT NULL COMMENT '国际价格',
  `city_NRC` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '同城一次性费用',
  `internal_NRC` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '国内一次性费用',
  `international_NRC` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '国际一次性费用',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `citydd` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1806 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for business_unit
-- ----------------------------
DROP TABLE IF EXISTS `business_unit`;
CREATE TABLE `business_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `type` tinyint(3) DEFAULT NULL COMMENT '类型1云服务商2idc3楼宇4互联网接入5CPE接入6nat7公网    ',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父级id',
  `region` varchar(30) DEFAULT '' COMMENT '地域id',
  `city_id` int(11) DEFAULT '0' COMMENT '城市id',
  `internet_type` tinyint(3) DEFAULT '0' COMMENT '互联网接入类型0非互联网接入1grevpn 2ipsecvpn 3ssl',
  `is_city` tinyint(3) DEFAULT '1' COMMENT '开通同城',
  `is_country` tinyint(3) DEFAULT '1' COMMENT '开通全国',
  `is_internal` tinyint(3) DEFAULT '1' COMMENT '开通国际',
  `is_auto_config` tinyint(3) DEFAULT '0' COMMENT '自动配置下发0不支持1支持',
  PRIMARY KEY (`id`),
  KEY `city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8 COMMENT='云服务商表';

-- ----------------------------
-- Table structure for cpe
-- ----------------------------
DROP TABLE IF EXISTS `cpe`;
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

-- ----------------------------
-- Table structure for cpe_app
-- ----------------------------
DROP TABLE IF EXISTS `cpe_app`;
CREATE TABLE `cpe_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增uid',
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `set` text COMMENT '五元组集合',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_app_rule
-- ----------------------------
DROP TABLE IF EXISTS `cpe_app_rule`;
CREATE TABLE `cpe_app_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_id` int(11) NOT NULL COMMENT 'app ID',
  `source_ip` varchar(30) DEFAULT '' COMMENT '来源IP',
  `source_port` int(11) DEFAULT '0' COMMENT '来源端口',
  `des_ip` varchar(30) DEFAULT '' COMMENT '目的Ip',
  `des_port` int(11) DEFAULT '0' COMMENT '目的端口',
  `mark` int(11) DEFAULT '0',
  `agreement` varchar(30) NOT NULL DEFAULT '' COMMENT '通讯协议',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `aid` (`app_id`),
  CONSTRAINT `aid` FOREIGN KEY (`app_id`) REFERENCES `cpe_app` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_detail_gre
-- ----------------------------
DROP TABLE IF EXISTS `cpe_detail_gre`;
CREATE TABLE `cpe_detail_gre` (
  `id` int(11) NOT NULL,
  `cpe_id` int(11) DEFAULT NULL COMMENT 'cpe设备id',
  `tunnel_name` varchar(40) DEFAULT NULL COMMENT '通道名称',
  `local_ip` varchar(17) DEFAULT NULL COMMENT '本地ip',
  `remote_ip` varchar(17) DEFAULT NULL COMMENT '远程ip',
  `local_inner_ip` varchar(17) DEFAULT NULL COMMENT '本地内部ip',
  `remote_inner_ip` varchar(17) DEFAULT NULL COMMENT '远程内部ip',
  `mtu` int(11) DEFAULT NULL COMMENT 'MTN',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_firewall_info
-- ----------------------------
DROP TABLE IF EXISTS `cpe_firewall_info`;
CREATE TABLE `cpe_firewall_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) DEFAULT NULL,
  `max_num` int(11) DEFAULT NULL COMMENT '最大条数',
  `is_send_max_num` tinyint(3) DEFAULT '1' COMMENT '是否下发过最大条数 1=no，2=yes',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_firewall_relation
-- ----------------------------
DROP TABLE IF EXISTS `cpe_firewall_relation`;
CREATE TABLE `cpe_firewall_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `cpe_id` int(11) NOT NULL COMMENT 'cpe_设备id',
  `fw_temp_id` int(11) NOT NULL COMMENT '防火墙模板id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cpe_temp` (`uid`,`cpe_id`,`fw_temp_id`) USING BTREE,
  KEY `cpe_id` (`cpe_id`),
  KEY `tem_id` (`fw_temp_id`),
  CONSTRAINT `cpe_id` FOREIGN KEY (`cpe_id`) REFERENCES `cpe` (`id`),
  CONSTRAINT `tem_id` FOREIGN KEY (`fw_temp_id`) REFERENCES `cpe_firewall_temp` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_firewall_rule
-- ----------------------------
DROP TABLE IF EXISTS `cpe_firewall_rule`;
CREATE TABLE `cpe_firewall_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `cpe_id` int(11) NOT NULL,
  `number_id` int(11) DEFAULT NULL,
  `src_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '来源ip',
  `srcIpRange` varchar(64) DEFAULT NULL COMMENT '来源ip范围',
  `src_port` varchar(256) NOT NULL DEFAULT '' COMMENT '来源端口',
  `multiSrcPort` varchar(256) DEFAULT NULL COMMENT '多个来源端口',
  `dst_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '目的ip',
  `dstIpRange` varchar(64) DEFAULT NULL,
  `dst_port` varchar(256) NOT NULL DEFAULT '' COMMENT '目的端口',
  `multiDstPort` varchar(256) DEFAULT NULL,
  `domain` varchar(256) DEFAULT NULL,
  `proto` tinyint(3) NOT NULL COMMENT '1= TCP  2=UDP  3=ALL',
  `action` tinyint(3) unsigned NOT NULL COMMENT '动作 1Accept 2DROP',
  `on` tinyint(3) DEFAULT '1' COMMENT '1=开启，2=关闭',
  `pkts` bigint(20) DEFAULT NULL,
  `bytes` bigint(20) DEFAULT NULL,
  `last_updated_at` datetime DEFAULT NULL COMMENT '流量统计最后更新时间',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注信息',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_firewall_temp
-- ----------------------------
DROP TABLE IF EXISTS `cpe_firewall_temp`;
CREATE TABLE `cpe_firewall_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增uid',
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_firewall_temp_rule
-- ----------------------------
DROP TABLE IF EXISTS `cpe_firewall_temp_rule`;
CREATE TABLE `cpe_firewall_temp_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `firewall_temp_id` int(11) NOT NULL,
  `src_ip` varchar(20) NOT NULL COMMENT '来源ip',
  `src_port` int(11) NOT NULL COMMENT '来源端口',
  `dst_ip` varchar(20) NOT NULL COMMENT '目的ip',
  `dst_port` int(11) NOT NULL COMMENT '目的端口',
  `proto` tinyint(3) NOT NULL COMMENT '1= TCP  2=UDP  3=ALL',
  `action` tinyint(3) unsigned NOT NULL COMMENT '动作 1Accept 2DROP',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `template_id` (`firewall_temp_id`),
  CONSTRAINT `template_id` FOREIGN KEY (`firewall_temp_id`) REFERENCES `cpe_firewall_temp` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_green_internet
-- ----------------------------
DROP TABLE IF EXISTS `cpe_green_internet`;
CREATE TABLE `cpe_green_internet` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) NOT NULL,
  `type` tinyint(11) NOT NULL COMMENT '0域名白名单， 1默认路由走gre',
  `own` tinyint(11) NOT NULL COMMENT '2=使用公共包，1=自由包',
  `scripturl` varchar(255) DEFAULT NULL COMMENT 'own=2时有效',
  `scriptmd5` varchar(255) DEFAULT NULL COMMENT 'own=2时有效',
  `domainurl` varchar(255) DEFAULT NULL COMMENT 'own=2时有效',
  `domainmd5` varchar(255) DEFAULT NULL COMMENT 'own=2时有效',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_nat
-- ----------------------------
DROP TABLE IF EXISTS `cpe_nat`;
CREATE TABLE `cpe_nat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) DEFAULT NULL,
  `type` tinyint(11) DEFAULT NULL COMMENT '1=snat  2=dnat',
  `content` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_order
-- ----------------------------
DROP TABLE IF EXISTS `cpe_order`;
CREATE TABLE `cpe_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '客户uid',
  `city_id` int(11) NOT NULL COMMENT '城市id',
  `buy_num` int(11) NOT NULL DEFAULT '1' COMMENT '购买数量',
  `sum_money` decimal(10,2) NOT NULL COMMENT '总金额',
  `delivery_username` varchar(20) NOT NULL COMMENT '收货人',
  `delivery_address` varchar(200) NOT NULL COMMENT '收货地址',
  `delivery_phone` varchar(11) NOT NULL COMMENT '收货电话',
  `delivery_type` varchar(100) DEFAULT NULL COMMENT '快递类型',
  `delivery_number` varchar(100) DEFAULT NULL COMMENT '快递号',
  `delivery_status` tinyint(3) DEFAULT '0' COMMENT '状态0未发货1已发货',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `cpe_order_detail`;
CREATE TABLE `cpe_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `cpe_id` int(11) NOT NULL COMMENT '设备id',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `price` double(10,2) NOT NULL COMMENT '设备价格',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '设备类型1 4G 2 普通',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_plugin
-- ----------------------------
DROP TABLE IF EXISTS `cpe_plugin`;
CREATE TABLE `cpe_plugin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '版本',
  `url` varchar(200) NOT NULL COMMENT '升级包路径',
  `md5` varchar(50) DEFAULT NULL COMMENT '版本的md5',
  `describe` text NOT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_port
-- ----------------------------
DROP TABLE IF EXISTS `cpe_port`;
CREATE TABLE `cpe_port` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) NOT NULL COMMENT 'cpe_设备id',
  `port_number` tinyint(3) NOT NULL COMMENT '端口编号',
  `port_name` varchar(10) DEFAULT NULL COMMENT '端口名称',
  `type` tinyint(3) NOT NULL COMMENT '类型 1:WAN 2:LAN 3:4G 4:5G 5专线',
  `property_config` varchar(6000) DEFAULT NULL COMMENT '属性配置json',
  `self_config` varchar(6000) DEFAULT NULL COMMENT '自身配置',
  `is_use` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否使用0未使用1使用中  (用来判断4g和wan谁在使用)',
  `is_ok` tinyint(3) NOT NULL DEFAULT '1' COMMENT '是否可用1可用2不可用',
  `is_qos_on` tinyint(3) DEFAULT '0' COMMENT '是否开启限速：0:关闭 1:开启',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `changing` varchar(256) DEFAULT NULL COMMENT '1-2-1-2-3-2....( 1:WAN 2:LAN 3:4G 4:5G 5专线 )',
  PRIMARY KEY (`id`),
  KEY `cc` (`cpe_id`),
  CONSTRAINT `cc` FOREIGN KEY (`cpe_id`) REFERENCES `cpe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1686 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_qos
-- ----------------------------
DROP TABLE IF EXISTS `cpe_qos`;
CREATE TABLE `cpe_qos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  `type` tinyint(3) DEFAULT NULL COMMENT 'IP限速方式 1:ip段；2:ip列表',
  `up_limit` int(11) DEFAULT NULL COMMENT '上行限速',
  `down_limit` int(11) DEFAULT NULL COMMENT '下行限速',
  `ip` varchar(200) DEFAULT NULL COMMENT 'IP',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `qos_cpe_id` (`cpe_id`),
  CONSTRAINT `qos_cpe_id` FOREIGN KEY (`cpe_id`) REFERENCES `cpe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_qos_v5
-- ----------------------------
DROP TABLE IF EXISTS `cpe_qos_v5`;
CREATE TABLE `cpe_qos_v5` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `cpe_id` int(11) NOT NULL,
  `devname` varchar(50) NOT NULL DEFAULT '',
  `type` tinyint(3) NOT NULL COMMENT '1=upload,2=download',
  `kbytes` int(11) NOT NULL COMMENT '限速',
  `srcIp` varchar(256) NOT NULL DEFAULT '' COMMENT '下行限速',
  `srcPort` varchar(200) DEFAULT '' COMMENT 'IP',
  `dstIp` varchar(256) NOT NULL DEFAULT '' COMMENT '下行限速',
  `dstPort` varchar(200) DEFAULT NULL,
  `proto` tinyint(4) NOT NULL,
  `remark` varchar(128) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_route
-- ----------------------------
DROP TABLE IF EXISTS `cpe_route`;
CREATE TABLE `cpe_route` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `cpe_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'CPE设备ID',
  `cpe_app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `cpe_port` varchar(50) DEFAULT NULL COMMENT 'CPE端口名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1ip优化2域名优化',
  `mode` tinyint(3) DEFAULT '1',
  `rule` mediumtext COMMENT 'CPE路由规则',
  `next_hop` varchar(128) DEFAULT NULL COMMENT '下一跳',
  `dns` varchar(128) DEFAULT NULL COMMENT 'DNS',
  `via` varchar(50) DEFAULT NULL COMMENT '网关',
  `trace_ip` varchar(50) DEFAULT NULL COMMENT '跟踪路由',
  `loss` int(11) DEFAULT NULL,
  `rtt` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid_cpeid` (`uid`,`cpe_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=564 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_route_temp
-- ----------------------------
DROP TABLE IF EXISTS `cpe_route_temp`;
CREATE TABLE `cpe_route_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `name` varchar(20) DEFAULT NULL COMMENT '模板名称',
  `type` tinyint(3) DEFAULT '1' COMMENT '优化类型 1ip优化2域名优化',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_route_temp_relation
-- ----------------------------
DROP TABLE IF EXISTS `cpe_route_temp_relation`;
CREATE TABLE `cpe_route_temp_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板主键id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `cpe_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'cpe_id',
  `route_temp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '模板id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cpe_temp` (`uid`,`cpe_id`,`route_temp_id`) USING BTREE,
  KEY `temp` (`route_temp_id`),
  KEY `cpe_id` (`cpe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_route_temp_rule
-- ----------------------------
DROP TABLE IF EXISTS `cpe_route_temp_rule`;
CREATE TABLE `cpe_route_temp_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `template` int(11) NOT NULL COMMENT '模板id',
  `rule` mediumtext NOT NULL COMMENT '优化内容',
  `next_hop` tinyint(3) NOT NULL COMMENT '下一跳',
  `sort` int(11) NOT NULL COMMENT '排序1:线路1 2:线路2 3线路3',
  `dns` varchar(128) DEFAULT NULL COMMENT '一个dns ip',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `temp` (`template`),
  CONSTRAINT `temp` FOREIGN KEY (`template`) REFERENCES `cpe_route_temp` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_speed
-- ----------------------------
DROP TABLE IF EXISTS `cpe_speed`;
CREATE TABLE `cpe_speed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) DEFAULT NULL COMMENT 'cpe设备id',
  `bandwidth` int(11) DEFAULT NULL COMMENT '带宽(Mbps)',
  `duration` int(11) DEFAULT '0' COMMENT '购买月份',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备升速信息';

-- ----------------------------
-- Table structure for cpe_stock
-- ----------------------------
DROP TABLE IF EXISTS `cpe_stock`;
CREATE TABLE `cpe_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT 'CPE设备名称',
  `model` varchar(50) DEFAULT NULL COMMENT '设备型号',
  `indate` date DEFAULT NULL COMMENT '入库日期',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '设备状态(0待出库 1已出库 2已回库 3再出库)',
  `delete_status` int(11) NOT NULL DEFAULT '0' COMMENT '删除状态(0:正常 1:已删除)',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='CPE库存管理';

-- ----------------------------
-- Table structure for cpe_stock_change
-- ----------------------------
DROP TABLE IF EXISTS `cpe_stock_change`;
CREATE TABLE `cpe_stock_change` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpe_stock_id` int(11) DEFAULT NULL,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `username` varchar(100) DEFAULT NULL COMMENT '用户名',
  `code` varchar(50) DEFAULT NULL COMMENT '接入码',
  `custname` varchar(20) DEFAULT NULL COMMENT '客户名称',
  `city` varchar(20) DEFAULT NULL COMMENT '节点城市',
  `bandwidth` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '节点带宽',
  `sale` varchar(20) DEFAULT NULL COMMENT '销售人员',
  `receiver` varchar(20) DEFAULT NULL COMMENT '收件人',
  `mobile` varchar(20) DEFAULT NULL COMMENT '收件人电话',
  `address` varchar(250) DEFAULT NULL COMMENT '收件人地址',
  `outdate` date DEFAULT NULL COMMENT '出库日期',
  `retdate` date DEFAULT NULL COMMENT '回库日期',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '设备状态(0待出库 1已出库 2已回库 3再出库)',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `cpe_stock_id` (`cpe_stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8 COMMENT='CPE库存变更';

-- ----------------------------
-- Table structure for cpe_task
-- ----------------------------
DROP TABLE IF EXISTS `cpe_task`;
CREATE TABLE `cpe_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `type` tinyint(3) NOT NULL COMMENT '任务类型',
  `content` mediumtext NOT NULL COMMENT '任务内容以及关联的cpeid列表',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '下发状态0:无须下发 1未分析2下发中3任务成功4任务失败',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5994 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_task_detail
-- ----------------------------
DROP TABLE IF EXISTS `cpe_task_detail`;
CREATE TABLE `cpe_task_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cpe_id` int(11) NOT NULL COMMENT '设备id',
  `task_id` int(11) NOT NULL COMMENT '总任务id',
  `pid` int(11) DEFAULT '0' COMMENT '父级id 执行先后顺序',
  `request_id` varchar(32) NOT NULL COMMENT '请求id',
  `content` mediumtext NOT NULL COMMENT '下发内容',
  `cpe_type` tinyint(3) DEFAULT NULL COMMENT 'cpe下发类型',
  `exec_result` text COMMENT '执行结果',
  `try_times` int(11) DEFAULT '0' COMMENT '尝试次数',
  `status` tinyint(3) DEFAULT '1' COMMENT '状态 0：无须下发。1未下发2已下发zookeeper3成功4失败5超时',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39716 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cpe_version
-- ----------------------------
DROP TABLE IF EXISTS `cpe_version`;
CREATE TABLE `cpe_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `version` varchar(20) NOT NULL COMMENT '版本',
  `url` varchar(200) NOT NULL COMMENT '升级包路径',
  `md5` varchar(50) DEFAULT NULL COMMENT '版本的md5',
  `describe` text NOT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_count
-- ----------------------------
DROP TABLE IF EXISTS `flow_count`;
CREATE TABLE `flow_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `ln_id` int(11) DEFAULT NULL COMMENT '节点id',
  `type` tinyint(3) DEFAULT NULL COMMENT '类型1流量最大源地址2流量最大目的地址 3ip最大流量',
  `src_ip` bigint(20) DEFAULT '0' COMMENT '来源ip',
  `des_ip` bigint(20) DEFAULT '0' COMMENT '目的ip',
  `flow` float(24,2) DEFAULT NULL COMMENT '流量',
  `created_at` int(11) DEFAULT NULL COMMENT '时间点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5274488 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ipsec
-- ----------------------------
DROP TABLE IF EXISTS `ipsec`;
CREATE TABLE `ipsec` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `node_name` varchar(40) DEFAULT NULL COMMENT 'ipsec 节点名称',
  `ipsect_ip` varchar(17) DEFAULT NULL COMMENT 'ipsec 服务端cpe',
  `ipsect_cidr` varchar(500) DEFAULT NULL COMMENT 'ipsec 客户端cpe',
  `cpe_id` int(11) DEFAULT '0' COMMENT '关联cpe_id',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ipsec_node
-- ----------------------------
DROP TABLE IF EXISTS `ipsec_node`;
CREATE TABLE `ipsec_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `from_ipsec_id` int(11) DEFAULT NULL COMMENT '发起端ipsec id',
  `to_ipsec_id` int(11) DEFAULT NULL COMMENT '接收端ipsec id',
  `leftInnerIp` varchar(17) DEFAULT NULL COMMENT 'Gre左端inner IP',
  `rightInnerIp` varchar(17) DEFAULT NULL COMMENT 'Gre右端 Inner IP',
  `netmask` varchar(20) DEFAULT NULL COMMENT 'Gre 网段',
  `status` tinyint(3) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for line_usage
-- ----------------------------
DROP TABLE IF EXISTS `line_usage`;
CREATE TABLE `line_usage` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `month` varchar(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `realuse` int(11) DEFAULT NULL,
  `userate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for migration
-- ----------------------------
DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for node_width_count
-- ----------------------------
DROP TABLE IF EXISTS `node_width_count`;
CREATE TABLE `node_width_count` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'UID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `ln_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点',
  `ln_name` varchar(60) DEFAULT NULL COMMENT '节点名称',
  `sum_width` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT '总购买带宽/Mbps',
  `max_in` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT '最大IN带宽/Mbps',
  `max_in_at` datetime DEFAULT NULL COMMENT '最大IN带宽时间',
  `max_out` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT '最大OUT带宽/Mbps',
  `max_out_at` datetime DEFAULT NULL COMMENT '最大OUT带宽时间',
  `ninefive_in` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT '95IN带宽/Mbps',
  `ninefive_in_at` datetime DEFAULT NULL COMMENT '95IN带宽时间',
  `ninefive_out` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT '95OUT带宽/Mbps',
  `ninefive_out_at` datetime DEFAULT NULL COMMENT '95OUT带宽时间',
  `sum_in` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT 'IN总量/M',
  `sum_out` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT 'OUT总量/M',
  `file_path` varchar(255) DEFAULT NULL COMMENT '报表地址',
  `bill_month` date DEFAULT NULL COMMENT '账单月',
  `created_at` datetime DEFAULT NULL COMMENT '添加时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE,
  KEY `ln_id` (`ln_id`) USING BTREE,
  KEY `count_date` (`bill_month`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1454 DEFAULT CHARSET=utf8 COMMENT='带宽月统计表';

-- ----------------------------
-- Table structure for policy_acl_nu
-- ----------------------------
DROP TABLE IF EXISTS `policy_acl_nu`;
CREATE TABLE `policy_acl_nu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `ln_id` int(11) DEFAULT NULL COMMENT '节点id',
  `pe_id` int(11) DEFAULT NULL COMMENT 'pe的唯一标示',
  `pe_type` tinyint(2) DEFAULT NULL COMMENT '主=1  备=2',
  `number` int(11) DEFAULT NULL COMMENT '3000-3999',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for policy_acl_pool
-- ----------------------------
DROP TABLE IF EXISTS `policy_acl_pool`;
CREATE TABLE `policy_acl_pool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) DEFAULT NULL COMMENT 'policy_rule_id',
  `type` tinyint(2) DEFAULT NULL COMMENT 'cidr=1, port=2',
  `issrc` tinyint(2) DEFAULT NULL COMMENT '1=源，2=目的',
  `pool_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for policy_node_relation
-- ----------------------------
DROP TABLE IF EXISTS `policy_node_relation`;
CREATE TABLE `policy_node_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `policy_tmp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '策略模版id',
  `ln_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '节点id',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_policy_ln` (`uid`,`policy_tmp_id`,`ln_id`) USING BTREE,
  KEY `ln` (`ln_id`),
  KEY `policy_tmp_id` (`policy_tmp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for policy_rule
-- ----------------------------
DROP TABLE IF EXISTS `policy_rule`;
CREATE TABLE `policy_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `policy_tmp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '策略模版ID',
  `action` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '规则策略，1=accept, 2=drop',
  `protocol` varchar(50) NOT NULL COMMENT '协议端口',
  `src_cidr` varchar(1024) NOT NULL DEFAULT '' COMMENT '地址网段',
  `des_cidr` varchar(1024) DEFAULT '',
  `src_port` varchar(256) NOT NULL DEFAULT '',
  `des_port` varchar(256) DEFAULT NULL,
  `tcp_flag` varchar(64) NOT NULL DEFAULT '' COMMENT 'tcp flag,多个空格分隔',
  `icmp_type` varchar(50) DEFAULT NULL,
  `gress` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '方向，1=ingress, 2=egress',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `remark` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid_cpeid` (`uid`,`policy_tmp_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for policy_template
-- ----------------------------
DROP TABLE IF EXISTS `policy_template`;
CREATE TABLE `policy_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `name` varchar(128) NOT NULL COMMENT '策略模板名称',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `priority_restrict` int(11) DEFAULT NULL COMMENT '模版下规则的优先级起始,步长1000',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for product_code_ali
-- ----------------------------
DROP TABLE IF EXISTS `product_code_ali`;
CREATE TABLE `product_code_ali` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `ProductCode` varchar(100) DEFAULT NULL COMMENT '产品code',
  `ProductType` varchar(100) DEFAULT NULL COMMENT '商品code',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=462 DEFAULT CHARSET=utf8 COMMENT='阿里产品code';

-- ----------------------------
-- Table structure for sdwan_ali
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_ali`;
CREATE TABLE `sdwan_ali` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `lan_node_id` int(11) DEFAULT NULL COMMENT '网络节点id',
  `vrouter_table_id` varchar(32) DEFAULT NULL COMMENT 'VPC端路由表ID',
  `vbr_id` varchar(32) DEFAULT NULL COMMENT '边界路由器id',
  `vrouter_id` varchar(32) DEFAULT NULL COMMENT 'vrouter的ID',
  `vrouter_ri_id` varchar(32) DEFAULT NULL COMMENT 'RI1的ID',
  `vbr_ri_id` varchar(32) DEFAULT NULL COMMENT 'RI2的ID',
  `vbr_peer_interface_id` varchar(32) DEFAULT NULL COMMENT 'RI3的ID',
  `vbr_table_id` varchar(32) DEFAULT NULL COMMENT 'VBR TABLE ID',
  `bgp_peer_id` varchar(32) DEFAULT NULL COMMENT 'BGP peer ID',
  `bgp_group_id` varchar(32) DEFAULT NULL COMMENT 'BGP Group ID',
  `backup_bgp_group_id` varchar(32) DEFAULT NULL COMMENT '备线bgp group Id',
  `backup_vbr_id` varchar(32) DEFAULT NULL COMMENT '备线边界路由器id',
  `backup_vrouter_ri_id` varchar(32) DEFAULT NULL COMMENT '备线RI1的ID',
  `backup_vbr_ri_id` varchar(32) DEFAULT NULL COMMENT '备线RI2的ID',
  `backup_vbr_peer_interface_id` varchar(32) DEFAULT NULL COMMENT '备线RI3的ID',
  `backup_vbr_table_id` varchar(32) DEFAULT NULL COMMENT '备线VPC端路由表ID',
  `backup_bgp_peer_id` varchar(32) DEFAULT NULL COMMENT '备线BGP peer ID',
  `cloud_company_network_id` varchar(32) DEFAULT NULL COMMENT '云企业网id',
  PRIMARY KEY (`id`),
  KEY `lan_node_id` (`lan_node_id`),
  CONSTRAINT `lan_node_id` FOREIGN KEY (`lan_node_id`) REFERENCES `base_lan_node` (`ln_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_aws
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_aws`;
CREATE TABLE `sdwan_aws` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `lan_node_id` int(11) DEFAULT NULL COMMENT '网络节点id',
  `vgw_id` varchar(64) DEFAULT NULL COMMENT '虚拟专用网关ID',
  `our_vgw` varchar(64) DEFAULT NULL COMMENT 'SDN虚拟专用网关ID',
  `virtual_interface_id` varchar(64) DEFAULT NULL COMMENT '虚拟接口id',
  `connection_id` varchar(64) DEFAULT NULL COMMENT 'Equinix创建连接ID',
  `dx_id` varchar(64) DEFAULT NULL COMMENT 'AWS接受连接ID',
  `dcg_id` varchar(64) DEFAULT NULL COMMENT 'Direct Connect网关',
  `is_belong` varchar(64) DEFAULT NULL COMMENT 'Direct Connect网关所属',
  PRIMARY KEY (`id`),
  KEY `lan_node` (`lan_node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_azure
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_azure`;
CREATE TABLE `sdwan_azure` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `lan_node_id` int(11) DEFAULT NULL COMMENT '网络节点id',
  `primaryConnectionId` varchar(64) DEFAULT NULL COMMENT '主连接ID',
  `secondaryConnectionId` varchar(64) DEFAULT NULL COMMENT '副连接ID',
  `serviceKey` varchar(64) DEFAULT NULL COMMENT '服务密钥',
  PRIMARY KEY (`id`),
  KEY `lan_node` (`lan_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_banwith
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_banwith`;
CREATE TABLE `sdwan_banwith` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
  `date` int(11) DEFAULT NULL COMMENT '时间点',
  `ln_id` int(11) DEFAULT NULL COMMENT 'lan node id',
  `in_flow` bigint(18) DEFAULT NULL COMMENT '流入流量',
  `out_flow` bigint(18) DEFAULT NULL COMMENT '流出流量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_logic_port
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_logic_port`;
CREATE TABLE `sdwan_logic_port` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `cpe_id` int(11) DEFAULT '0' COMMENT 'cpe设备id',
  `network_id` int(11) DEFAULT NULL COMMENT 'dcn网络id',
  `sub_network_id` int(11) DEFAULT '0' COMMENT '子网主交换机id',
  `backup_sub_network_id` int(11) DEFAULT '0' COMMENT '子网备交换机id',
  `lan_node_id` int(11) DEFAULT NULL COMMENT '网络节点id',
  `pe_id` int(11) DEFAULT NULL COMMENT 'PE ID',
  `backup_pe_id` int(11) DEFAULT NULL COMMENT '备线pe id',
  `physical_port` varchar(40) DEFAULT NULL COMMENT 'pe 物理端口',
  `backup_physical_port` varchar(40) DEFAULT NULL COMMENT '备线pe物理端口',
  `backup_is_pe_first` tinyint(3) DEFAULT NULL COMMENT '是否是备线pe第一个节点',
  `is_pe_first` tinyint(3) DEFAULT '0' COMMENT '是否是pe第一个节点',
  `access_point` int(11) DEFAULT NULL COMMENT '接入点id',
  `business_unit_id` int(11) DEFAULT '0' COMMENT '厂商',
  `business_type` tinyint(3) DEFAULT '0' COMMENT '厂商类型',
  `business_internet_type` tinyint(3) DEFAULT '0' COMMENT '互联网接入类型',
  `logic_port_id` varchar(40) DEFAULT NULL COMMENT '端口id',
  `logic_port_name` varchar(40) DEFAULT NULL COMMENT '逻辑端口名称',
  `backup_logic_port_id` varchar(40) DEFAULT NULL COMMENT '备线端口id',
  `backup_logic_port_name` varchar(40) DEFAULT NULL COMMENT '备线逻辑端口名称',
  `sdwan_logic_port` varchar(40) DEFAULT NULL,
  `backup_sdwan_logic_port` varchar(40) DEFAULT NULL COMMENT 'SDN备线逻辑端口全称',
  `vlanid` varchar(40) DEFAULT NULL COMMENT '分配的vlanid',
  `backup_vlanid` varchar(40) DEFAULT NULL COMMENT '分配的备线vlanid',
  `local_ip` varchar(17) DEFAULT NULL COMMENT '本地ip',
  `local_backup_ip` varchar(17) DEFAULT NULL COMMENT '本地备线ip',
  `remote_ip` varchar(17) DEFAULT NULL COMMENT '远端ip',
  `remote_backup_ip` varchar(17) DEFAULT NULL COMMENT '远端备线ip',
  `subnet_mask` varchar(17) DEFAULT NULL COMMENT '子网掩码',
  `backup_subnet_mask` varchar(17) DEFAULT '' COMMENT '备线子网掩码',
  `policy_id` varchar(32) DEFAULT '' COMMENT '策略ID',
  `backup_policy_id` varchar(32) DEFAULT '' COMMENT '备线策略id',
  `logic_cidr` varchar(40) NOT NULL DEFAULT '' COMMENT 'gre分配节点接入cidr',
  `backup_logic_cidr` varchar(17) DEFAULT NULL COMMENT 'gre备线接入cidr',
  `status` tinyint(3) DEFAULT NULL COMMENT '状态',
  `main_standby` tinyint(3) DEFAULT '1' COMMENT '主备状态1主线2备线3主切备线中4备切主中',
  `cpe_task_id` int(11) DEFAULT NULL COMMENT 'cpe任务id',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `internet_mark` int(11) DEFAULT '0' COMMENT '互联网接入标识',
  `backup_internet_mark` int(11) DEFAULT '0' COMMENT '备线互联网接入标识',
  `internet_local_ip` varchar(17) DEFAULT NULL COMMENT '互联网接入本地ip',
  `backup_internet_local_ip` varchar(17) DEFAULT NULL COMMENT '备线互联网内网ip',
  `internet_remote_ip` varchar(17) DEFAULT NULL COMMENT '互联网接入远程ip',
  `backup_internet_remote_ip` varchar(17) DEFAULT NULL COMMENT '备线互联网外网ip',
  `internet_ip` varchar(17) DEFAULT NULL COMMENT 'linux互联网接入',
  `backup_internet_ip` varchar(17) DEFAULT NULL COMMENT '备线互联网接入',
  `internet_virtual_ip` bigint(21) DEFAULT '0' COMMENT 'gre虚拟公网ip',
  `backup_internet_virtual_ip` varchar(17) DEFAULT '0' COMMENT '备线gre虚拟公网ip',
  `nat_ip` varchar(17) DEFAULT NULL COMMENT 'nat ip 互联网出口ip',
  PRIMARY KEY (`id`),
  KEY `lan_noded` (`lan_node_id`),
  KEY `network` (`network_id`),
  CONSTRAINT `lan_noded` FOREIGN KEY (`lan_node_id`) REFERENCES `base_lan_node` (`ln_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1584 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_network
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_network`;
CREATE TABLE `sdwan_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `tenant` varchar(40) DEFAULT NULL COMMENT '租户id',
  `lan_id` int(11) DEFAULT NULL COMMENT '用户网络id',
  `allwan_version` varchar(20) DEFAULT 'v2.0.0' COMMENT '下发版本',
  `logic_network_id` varchar(40) DEFAULT NULL COMMENT '逻辑网络id',
  `logic_network_name` varchar(40) DEFAULT NULL COMMENT '逻辑网络名称',
  `logic_network_vni` varchar(40) DEFAULT NULL COMMENT '逻辑网络VNI',
  `sub_network_id` varchar(40) DEFAULT NULL COMMENT '子网id',
  `sub_network_name` varchar(40) DEFAULT NULL COMMENT '子网名称',
  `sub_network_cidr` varchar(40) DEFAULT NULL COMMENT '子网网段',
  `sub_network_gateway` varchar(17) DEFAULT NULL COMMENT '子网网关',
  `router_id` varchar(40) DEFAULT NULL COMMENT '路由id',
  `router_name` varchar(40) DEFAULT NULL COMMENT '路由名称',
  `router_interface_port_id` varchar(40) DEFAULT NULL COMMENT '路由接口端口id',
  `router_interface_port_name` varchar(40) DEFAULT NULL COMMENT '路由接口端口名称',
  `router_interface_port_mac` varchar(40) DEFAULT NULL COMMENT '路由接口端口MAC地址',
  `vrf_name` varchar(40) DEFAULT NULL COMMENT 'vrf名称',
  `vrf_config` text COMMENT 'vrf配置',
  `status` tinyint(3) DEFAULT '0' COMMENT '状态0未创建1创建2删除',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vni` (`logic_network_vni`)
) ENGINE=InnoDB AUTO_INCREMENT=341 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_sub_network
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_sub_network`;
CREATE TABLE `sdwan_sub_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `network_id` int(11) DEFAULT NULL COMMENT '网络id',
  `logic_network_id` varchar(40) DEFAULT NULL COMMENT '逻辑网络id',
  `logic_network_name` varchar(40) DEFAULT NULL COMMENT '逻辑网络名称',
  `logic_network_vni` varchar(40) DEFAULT NULL COMMENT '逻辑网络VNI',
  `sub_network_id` varchar(40) DEFAULT NULL COMMENT '子网id',
  `sub_network_name` varchar(40) DEFAULT NULL COMMENT '子网名称',
  `sub_network_cidr` varchar(40) DEFAULT NULL COMMENT '子网网段',
  `sub_network_gateway` varchar(17) DEFAULT NULL COMMENT '子网网关',
  `router_interface_port_id` varchar(40) DEFAULT NULL COMMENT '路由接口端口id',
  `router_interface_port_name` varchar(40) DEFAULT NULL COMMENT '路由接口端口名称',
  `router_interface_port_mac` varchar(40) DEFAULT NULL COMMENT '路由接口端口MAC地址',
  `bd_id` varchar(40) DEFAULT NULL COMMENT 'brige domain',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1208 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_task
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_task`;
CREATE TABLE `sdwan_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `uid` int(11) NOT NULL COMMENT '客户uid',
  `username` varchar(30) DEFAULT NULL COMMENT '用户名称',
  `content` varchar(1000) DEFAULT NULL COMMENT '详情',
  `step_now` tinyint(3) DEFAULT '0' COMMENT '当前步骤',
  `type` tinyint(3) DEFAULT NULL COMMENT '任务类型1上架2下架3更改带宽4修改网段',
  `status` tinyint(4) DEFAULT '1' COMMENT '任务状态1未分析2下发配置3执行成功4执行失败',
  `effect_time` datetime DEFAULT NULL COMMENT '任务生效时间',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2748 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_task_detail
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_task_detail`;
CREATE TABLE `sdwan_task_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `task_id` int(11) DEFAULT NULL COMMENT '总任务id',
  `ln_id` int(11) DEFAULT '0' COMMENT '节点id',
  `pid` int(11) DEFAULT NULL COMMENT '任务先后顺序',
  `pid_status` tinyint(3) DEFAULT '1' COMMENT '父级任务状态1完成2未完成',
  `status` tinyint(3) DEFAULT NULL COMMENT '状态1未下发2下发中3成功4失败',
  `exec_result` text COMMENT '执行返回结果',
  `send_content` text COMMENT '发送内容',
  `type` tinyint(3) DEFAULT NULL COMMENT '任务类型',
  `summary` text COMMENT '关键信息',
  `pe_id` int(11) DEFAULT NULL COMMENT 'acl 任务，下发时用到',
  `pe_type` tinyint(3) DEFAULT NULL COMMENT '1=主 ，2=备 acl下发时用到',
  `is_lock` tinyint(3) DEFAULT NULL COMMENT '是否锁定中1未锁定2锁定',
  `is_manual` tinyint(3) DEFAULT '0' COMMENT '是否手动0自动1手动',
  `effective_time` datetime DEFAULT NULL COMMENT '生效时间',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `staus_time` (`pid_status`,`status`,`effective_time`)
) ENGINE=InnoDB AUTO_INCREMENT=9432 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sdwan_tencent
-- ----------------------------
DROP TABLE IF EXISTS `sdwan_tencent`;
CREATE TABLE `sdwan_tencent` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `lan_node_id` int(11) DEFAULT NULL COMMENT '网络节点id',
  `gw_id` varchar(32) DEFAULT NULL COMMENT '专线网关id',
  `tun_id` varchar(32) DEFAULT NULL COMMENT '专线通道id',
  `rt_id` varchar(32) DEFAULT NULL COMMENT '路由表ID',
  PRIMARY KEY (`id`),
  KEY `lan_node` (`lan_node_id`),
  CONSTRAINT `lan_node` FOREIGN KEY (`lan_node_id`) REFERENCES `base_lan_node` (`ln_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sound
-- ----------------------------
DROP TABLE IF EXISTS `sound`;
CREATE TABLE `sound` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL COMMENT '标题',
  `uid` int(11) DEFAULT NULL COMMENT '用户UID',
  `appid` varchar(64) DEFAULT NULL COMMENT '应用ID',
  `status` tinyint(3) DEFAULT '2' COMMENT '状态1正常2禁用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `expire_time` datetime DEFAULT NULL COMMENT '到期日期',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_email
-- ----------------------------
DROP TABLE IF EXISTS `sys_email`;
CREATE TABLE `sys_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '邮件标题',
  `content` text NOT NULL COMMENT '邮件内容',
  `sender` varchar(255) DEFAULT NULL COMMENT '发件人',
  `receiver` text NOT NULL COMMENT '收件人',
  `receiver_cc` text COMMENT '抄送',
  `preset_time` datetime NOT NULL COMMENT '预设发送时间',
  `func` varchar(255) DEFAULT NULL COMMENT '回调函数',
  `status` tinyint(3) DEFAULT '0' COMMENT '状态 0未发送 1 已发送 2发送失败',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='邮件表';

-- ----------------------------
-- Table structure for sys_mail_member
-- ----------------------------
DROP TABLE IF EXISTS `sys_mail_member`;
CREATE TABLE `sys_mail_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `mail` varchar(255) NOT NULL COMMENT '邮箱',
  `group` varchar(20) DEFAULT NULL COMMENT '分组',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='邮件通讯录';

-- ----------------------------
-- Table structure for t_cpe_ping
-- ----------------------------
DROP TABLE IF EXISTS `t_cpe_ping`;
CREATE TABLE `t_cpe_ping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` char(15) DEFAULT NULL COMMENT 'ssh登录ip',
  `command` varchar(255) DEFAULT NULL COMMENT 'ping命令',
  `result` text COMMENT '结果',
  `created_at` datetime DEFAULT NULL COMMENT '添加时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接入点cpe设备探测';

-- ----------------------------
-- Table structure for user_bandwidth
-- ----------------------------
DROP TABLE IF EXISTS `user_bandwidth`;
CREATE TABLE `user_bandwidth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `node_name` varchar(100) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `num` bigint(18) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2068 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user_bandwith_history
-- ----------------------------
DROP TABLE IF EXISTS `user_bandwith_history`;
CREATE TABLE `user_bandwith_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) DEFAULT NULL COMMENT '用户uid',
  `title` varchar(20) DEFAULT NULL COMMENT '标题',
  `items` text COMMENT '屏幕场景数据',
  `remark` varchar(100) DEFAULT NULL COMMENT '内容',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_threshold
-- ----------------------------
DROP TABLE IF EXISTS `user_threshold`;
CREATE TABLE `user_threshold` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '类型 1带宽 2延迟 3丢包',
  `ln_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前节点ID',
  `peer_ln_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '对端节点ID',
  `threshold` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '阈值',
  `cond` varchar(10) DEFAULT NULL COMMENT '监控条件',
  `alarm_type` varchar(10) DEFAULT NULL COMMENT '告警方式 多个以逗号分隔 1=短信 2=邮件',
  `max_step` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最大报警次数',
  `phone` varchar(1200) DEFAULT NULL COMMENT '告警电话',
  `email` varchar(1200) DEFAULT NULL COMMENT '告警邮件',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uid_type_ln_id` (`uid`,`type`,`ln_id`,`peer_ln_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userlist
-- ----------------------------
DROP TABLE IF EXISTS `userlist`;
CREATE TABLE `userlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `node_name` varchar(100) DEFAULT NULL,
  `node_id` int(11) DEFAULT NULL,
  `whichbig` tinyint(3) DEFAULT NULL,
  `model_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
