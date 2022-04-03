#
************************************************************
# Sequel Ace SQL dump
# 版本号
： 20031
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: 172.16.1.58 (MySQL 5.7.18-log)
# 数据库: linker_pro
# 生成时间: 2022-03-31 07:16:23 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


#
转储表 linker_pro_cpes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_cpes`;

CREATE TABLE `linker_pro_cpes`
(
    `id`              int(11) unsigned NOT NULL AUTO_INCREMENT,
    `node_id`         int(11) unsigned DEFAULT NULL COMMENT '站点id',
    `code`            varchar(40) DEFAULT NULL COMMENT 'cpe唯一码',
    `username`        varchar(20) DEFAULT NULL COMMENT '操作用户',
    `uid`             int(11) unsigned DEFAULT NULL COMMENT '用户id',
    `password`        varchar(40) DEFAULT NULL COMMENT 'zookeeper密码',
    `type`            tinyint(1) unsigned NOT NULL COMMENT '设备类型：1物理设备，2虚拟设备',
    `name`            varchar(20) DEFAULT NULL COMMENT '设备名称',
    `mode`            tinyint(1) unsigned DEFAULT '1' COMMENT 'CPE型号：1linker',
    `access_type`     tinyint(1) unsigned DEFAULT '1' COMMENT '接入方式: 1单臂路由 2主路由 3串联 4网桥',
    `email`           varchar(20) DEFAULT NULL COMMENT '邮箱',
    `version`         varchar(20) DEFAULT NULL COMMENT 'cpe的版本信息',
    `access_point_id` int(11) DEFAULT NULL COMMENT '接入点id',
    `mac`             varchar(40) DEFAULT NULL COMMENT '设备MAC',
    `is_flow_app`     tinyint(1) DEFAULT '0' COMMENT '应用流量分析：0不启用，1启用',
    `is_flow_host`    tinyint(1) DEFAULT '0' COMMENT '主机流量分析：0不启用，1启用',
    `is_domain_host`  tinyint(1) DEFAULT '0' COMMENT '域名直接解析：0不启用，1启用',
    `is_dns_agent`    tinyint(1) DEFAULT '0' COMMENT 'dns解析：0不启用，1启用',
    `is_ha`           tinyint(1) DEFAULT NULL COMMENT 'HA：0不启用，1启用',
    `ha_config`       json        DEFAULT NULL COMMENT 'HA:配置',
    `status`          tinyint(1) unsigned DEFAULT '0' COMMENT '状态： 1离线  2运行中 3配置中 4升级中  5超时 6撤点',
    `created_at`      datetime    DEFAULT NULL COMMENT '创建时间',
    `updated_at`      datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='CPE信息表 zh_2022_03_15';

LOCK
TABLES `linker_pro_cpes` WRITE;
/*!40000 ALTER TABLE `linker_pro_cpes` DISABLE KEYS */;

INSERT INTO `linker_pro_cpes` (`id`, `node_id`, `code`, `username`, `uid`, `password`, `type`, `name`, `mode`,
                               `access_type`, `email`, `version`, `access_point_id`, `mac`, `is_flow_app`,
                               `is_flow_host`, `is_domain_host`, `is_dns_agent`, `is_ha`, `ha_config`, `status`,
                               `created_at`, `updated_at`)
VALUES (1, 6, 'afd', 'name', 123, 'adfasdf', 1, 'name', 1, 1, 'kkk@gmail.com', 'adff', 123, 'adffd', 1, 2, 2, 2, NULL,
        NULL, 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_cpes` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_dhcp_assigns
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_dhcp_assigns`;

CREATE TABLE `linker_pro_dhcp_assigns`
(
    `id`         int(11) unsigned NOT NULL AUTO_INCREMENT,
    `dhcp_id`    int(11) unsigned DEFAULT NULL COMMENT 'dhcp id',
    `host_name`  varchar(20) DEFAULT NULL COMMENT '主机名',
    `host_ip`    varchar(17) DEFAULT NULL COMMENT 'IP',
    `mac`        varchar(40) DEFAULT NULL COMMENT 'MAC',
    `lease`      int(11) DEFAULT NULL COMMENT '租期',
    `created_at` datetime    DEFAULT NULL COMMENT '创建时间',
    `updated_at` datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='DHCP服务分配信息表 zh_2022_03_17';

LOCK
TABLES `linker_pro_dhcp_assigns` WRITE;
/*!40000 ALTER TABLE `linker_pro_dhcp_assigns` DISABLE KEYS */;

INSERT INTO `linker_pro_dhcp_assigns` (`id`, `dhcp_id`, `host_name`, `host_ip`, `mac`, `lease`, `created_at`,
                                       `updated_at`)
VALUES (1, 123, 'host', 'ip', 'mac', 123, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_dhcp_assigns` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_dhcps
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_dhcps`;

CREATE TABLE `linker_pro_dhcps`
(
    `id`           int(11) unsigned NOT NULL AUTO_INCREMENT,
    `line_id`      int(11) unsigned DEFAULT NULL COMMENT '线路id',
    `is_on`        tinyint(1) DEFAULT '1' COMMENT 'DHCP服务器是否开启：0关闭 1开启',
    `assign_type`  tinyint(1) DEFAULT '1' COMMENT '分配地址方式：1本LAN口所有地址 2分配指定地址',
    `assign_range` varchar(100) DEFAULT NULL COMMENT '分配地址范围',
    `network_mask` varchar(40)  DEFAULT NULL COMMENT '网络掩码',
    `gateway_type` tinyint(1) DEFAULT '1' COMMENT '网关地址类型：1使用LAN口地址做网关 2指定地址做网关',
    `gateway`      varchar(17)  DEFAULT NULL COMMENT '指定网关地址',
    `dns_config`   tinyint(1) DEFAULT '1' COMMENT 'DNS设置：1使用LAN口地址做DNS 2指定DNS地址',
    `dns_1st`      varchar(17)  DEFAULT NULL COMMENT '首选DNS',
    `dns_2nd`      varchar(17)  DEFAULT NULL COMMENT '备用DNS',
    `lease`        int(11) DEFAULT '168' COMMENT '租约时间：小时',
    `created_at`   datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at`   datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='DHCP服务信息表 zh_2022_03_15';

LOCK
TABLES `linker_pro_dhcps` WRITE;
/*!40000 ALTER TABLE `linker_pro_dhcps` DISABLE KEYS */;

INSERT INTO `linker_pro_dhcps` (`id`, `line_id`, `is_on`, `assign_type`, `assign_range`, `network_mask`, `gateway_type`,
                                `gateway`, `dns_config`, `dns_1st`, `dns_2nd`, `lease`, `created_at`, `updated_at`)
VALUES (1, 12, 1, 1, 'asf', 'adf', 1, 'asdf', 1, 'adf', 'asdf', 168, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_dhcps` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_dns
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_dns`;

CREATE TABLE `linker_pro_dns`
(
    `id`         int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`     int(11) DEFAULT NULL COMMENT 'cpe id',
    `type`       tinyint(1) DEFAULT '1' COMMENT '类型：1域名直接解析，2DNS代理',
    `domain`     varchar(40) DEFAULT NULL COMMENT '域名',
    `ip`         varchar(17) DEFAULT NULL COMMENT 'ip',
    `status`     tinyint(1) DEFAULT '0' COMMENT '0启用，1不启用',
    `created_at` datetime    DEFAULT NULL COMMENT '创建时间',
    `updated_at` datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='DNS配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_dns` WRITE;
/*!40000 ALTER TABLE `linker_pro_dns` DISABLE KEYS */;

INSERT INTO `linker_pro_dns` (`id`, `cpe_id`, `type`, `domain`, `ip`, `status`, `created_at`, `updated_at`)
VALUES (1, 123, 1, 'www.google.com.hk', '6.7.8.9', 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_dns` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_firewalls
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_firewalls`;

CREATE TABLE `linker_pro_firewalls`
(
    `id`            int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`        int(11) unsigned DEFAULT '0' COMMENT 'cpe id',
    `index`         int(11) DEFAULT '1' COMMENT '排序号：默认1',
    `source_ip`     varchar(17)  DEFAULT NULL COMMENT '源地址',
    `source_port`   varchar(40)  DEFAULT NULL COMMENT '源端口',
    `dst_ip`        varchar(17)  DEFAULT NULL COMMENT '目的地址',
    `dst_port`      varchar(40)  DEFAULT NULL COMMENT '目的端口',
    `protocol_type` tinyint(1) DEFAULT '1' COMMENT '协议：1ALL 2TCP 3UDP',
    `action`        tinyint(1) DEFAULT '0' COMMENT '动作类型：1接收2拒绝',
    `remark`        varchar(255) DEFAULT NULL COMMENT '备注',
    `status`        tinyint(1) DEFAULT '0' COMMENT '状态：0启用，1禁用',
    `created_at`    datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at`    datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='防火墙规则表 zh_2022_03_15';

LOCK
TABLES `linker_pro_firewalls` WRITE;
/*!40000 ALTER TABLE `linker_pro_firewalls` DISABLE KEYS */;

INSERT INTO `linker_pro_firewalls` (`id`, `cpe_id`, `index`, `source_ip`, `source_port`, `dst_ip`, `dst_port`,
                                    `protocol_type`, `action`, `remark`, `status`, `created_at`, `updated_at`)
VALUES (1, 123, 1, '192.168.1.123', '11211', '192.168.1.125', '6379', 1, 0, NULL, 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_firewalls` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_line_combinations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_line_combinations`;

CREATE TABLE `linker_pro_line_combinations`
(
    `id`            int(11) unsigned NOT NULL AUTO_INCREMENT,
    `line_id`       int(11) unsigned NOT NULL COMMENT '线路id',
    `line_type`     tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '线路地位：1主线路 2备线路',
    `self_line_id`  int(11) NOT NULL COMMENT '自身线路id',
    `delayed`       int(11) DEFAULT NULL COMMENT '延时：毫秒',
    `packet_losses` int(11) DEFAULT NULL COMMENT '连续丢包个数',
    `created_at`    datetime DEFAULT NULL COMMENT '创建时间',
    `updated_at`    datetime DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='组合线路配置信息表 zh_2022_03_15';

LOCK
TABLES `linker_pro_line_combinations` WRITE;
/*!40000 ALTER TABLE `linker_pro_line_combinations` DISABLE KEYS */;

INSERT INTO `linker_pro_line_combinations` (`id`, `line_id`, `line_type`, `self_line_id`, `delayed`, `packet_losses`,
                                            `created_at`, `updated_at`)
VALUES (1, 123, 1, 12, 1, 1, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_line_combinations` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_line_lans
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_line_lans`;

CREATE TABLE `linker_pro_line_lans`
(
    `id`                      int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`                  int(11) DEFAULT NULL COMMENT 'cpe id',
    `line_id`                 int(11) DEFAULT NULL COMMENT 'line id',
    `name`                    varchar(10)          DEFAULT NULL COMMENT '线路名称',
    `interface`               tinyint(1) unsigned DEFAULT NULL COMMENT '接口类型：1eth1 2eth2 3eht3',
    `operating_mode`          tinyint(1) unsigned DEFAULT NULL COMMENT '工作模式：1NAT模式 2路由模式 3二层混合透明网桥 4二层纯透明网桥 5镜像旁路监听',
    `line_lan_id`             int(11) unsigned DEFAULT NULL COMMENT '对应LAN口id',
    `sub_interface`           varchar(10)          DEFAULT NULL COMMENT '子接口VLAN',
    `line_status`             tinyint(1) unsigned DEFAULT '1' COMMENT '线路状态：0关闭 1开启',
    `enable_tunnel`           tinyint(1) unsigned DEFAULT '1' COMMENT '启用隧道：0不启用 1启用',
    `address_method`          tinyint(1) unsigned DEFAULT '0' COMMENT '地址方式：0静态地址 1PPPOE 2DHCP',
    `ip`                      varchar(30)          DEFAULT NULL COMMENT 'ip地址',
    `is_other_host_address`   tinyint(1) unsigned DEFAULT '0' COMMENT '该地址是否模拟LAN口其他主机地址：0否 1是',
    `subnet_mask`             varchar(17)          DEFAULT NULL COMMENT '子网掩码',
    `network_gateway`         varchar(17)          DEFAULT NULL COMMENT '网关',
    `dns`                     varchar(128)         DEFAULT NULL COMMENT 'DNS',
    `is_use_dns`              tinyint(1) unsigned DEFAULT '0' COMMENT '强制使用本线路DNS：0否 1是',
    `mtu`                     smallint(4) DEFAULT '1500' COMMENT 'MTU：取值范围1-1500 默认1500',
    `mss`                     smallint(4) DEFAULT '1460' COMMENT 'MSS：取值范围1-1460 默认1460',
    `tunnel_underlay_line_id` int(11) DEFAULT NULL COMMENT '隧道：底层的underlay 线路id',
    `tunnel_server_ip`        varchar(17)          DEFAULT NULL COMMENT '隧道：服务器地址',
    `tunnel_local_ip`         varchar(17)          DEFAULT NULL COMMENT '隧道：本端公网地址',
    `tunnel_gre_key`          varchar(20) NOT NULL DEFAULT '' COMMENT '隧道：GRE-KEY',
    `router_cost`             int(11) DEFAULT '1' COMMENT '路由开销：取值范围0-9999，默认1',
    `is_default_route`        tinyint(1) DEFAULT '0' COMMENT '默认路由：0否 1是',
    `is_virtual`              tinyint(1) DEFAULT '0' COMMENT '是否虚拟线路：0否，1是',
    `created_at`              datetime             DEFAULT NULL COMMENT '创建时间',
    `updated_at`              datetime             DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='LAN线路配置表 zh_2022_03_16';



#
转储表 linker_pro_line_wans
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_line_wans`;

CREATE TABLE `linker_pro_line_wans`
(
    `id`                      int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`                  int(11) DEFAULT NULL COMMENT 'cpe id',
    `line_id`                 int(11) DEFAULT NULL COMMENT 'line id',
    `name`                    varchar(10)          DEFAULT NULL COMMENT '线路名称',
    `interface`               tinyint(1) unsigned DEFAULT NULL COMMENT '接口类型：1eth1 2eth2 3eht3',
    `operating_mode`          tinyint(1) unsigned DEFAULT NULL COMMENT '工作模式：1NAT模式 2路由模式 3二层混合透明网桥 4二层纯透明网桥 5镜像旁路监听',
    `line_lan_id`             int(11) unsigned DEFAULT NULL COMMENT '对应LAN口id',
    `sub_interface`           varchar(10)          DEFAULT NULL COMMENT '子接口VLAN',
    `line_status`             tinyint(1) unsigned DEFAULT '1' COMMENT '线路状态：0关闭 1开启',
    `enable_tunnel`           tinyint(1) unsigned DEFAULT '1' COMMENT '启用隧道：0不启用 1启用',
    `address_method`          tinyint(1) unsigned DEFAULT '0' COMMENT '地址方式：0静态地址 1PPPOE 2DHCP',
    `pppoe_username`          varchar(40)          DEFAULT NULL COMMENT 'pppoe 用户名',
    `pppoe_password`          varchar(40)          DEFAULT NULL COMMENT 'pppoe 密码',
    `ip`                      varchar(30)          DEFAULT NULL COMMENT 'ip地址',
    `is_other_host_address`   tinyint(1) unsigned DEFAULT '0' COMMENT '该地址是否模拟LAN口其他主机地址：0否 1是',
    `subnet_mask`             varchar(17)          DEFAULT NULL COMMENT '子网掩码',
    `network_gateway`         varchar(17)          DEFAULT NULL COMMENT '网关',
    `dns`                     varchar(128)         DEFAULT NULL COMMENT 'DNS',
    `is_use_dns`              tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制使用本线路DNS：0否 1是',
    `mtu`                     smallint(4) DEFAULT '1500' COMMENT 'MTU：取值范围1-1500 默认1500',
    `mss`                     smallint(4) DEFAULT '1460' COMMENT 'MSS：取值范围1-1460 默认1460',
    `tunnel_underlay_line_id` int(11) DEFAULT NULL COMMENT '隧道：底层的underlay 线路id',
    `tunnel_server_ip`        varchar(17)          DEFAULT NULL COMMENT '隧道：服务器地址',
    `tunnel_local_ip`         varchar(17)          DEFAULT NULL COMMENT '隧道：本端公网地址',
    `tunnel_gre_key`          varchar(20) NOT NULL DEFAULT '' COMMENT '隧道：GRE-KEY',
    `router_cost`             int(11) DEFAULT '1' COMMENT '路由开销：取值范围0-9999，默认1',
    `is_default_route`        tinyint(1) DEFAULT '0' COMMENT '默认路由：0否 1是',
    `is_virtual`              tinyint(1) DEFAULT '0' COMMENT '是否虚拟线路：0否，1是',
    `created_at`              datetime             DEFAULT NULL COMMENT '创建时间',
    `updated_at`              datetime             DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='WAN线路配置表 zh_2022_03_16';

LOCK
TABLES `linker_pro_line_wans` WRITE;
/*!40000 ALTER TABLE `linker_pro_line_wans` DISABLE KEYS */;

INSERT INTO `linker_pro_line_wans` (`id`, `cpe_id`, `line_id`, `name`, `interface`, `operating_mode`, `line_lan_id`,
                                    `sub_interface`, `line_status`, `enable_tunnel`, `address_method`, `pppoe_username`,
                                    `pppoe_password`, `ip`, `is_other_host_address`, `subnet_mask`, `network_gateway`,
                                    `dns`, `is_use_dns`, `mtu`, `mss`, `tunnel_underlay_line_id`, `tunnel_server_ip`,
                                    `tunnel_local_ip`, `tunnel_gre_key`, `router_cost`, `is_default_route`,
                                    `is_virtual`, `created_at`, `updated_at`)
VALUES (1, 123, 123, 'w name', 1, 1, 1, '1', 1, 1, 0, NULL, NULL, '\"127.0.0.1\"', 0, NULL, NULL, NULL, 0, 1500, 1460,
        NULL, NULL, NULL, '', 1, 0, 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_line_wans` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_lines
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_lines`;

CREATE TABLE `linker_pro_lines`
(
    `id`            int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`        int(11) DEFAULT NULL COMMENT 'cpe id',
    `is_default`    tinyint(1) unsigned DEFAULT '1' COMMENT '1默认，2非默认',
    `type`          tinyint(1) unsigned DEFAULT '1' COMMENT '线路类型：1wan 2lan 3组合 ',
    `name`          varchar(20)  DEFAULT NULL COMMENT '线路名称',
    `remark`        varchar(100) DEFAULT NULL COMMENT '备注',
    `strategy_type` tinyint(1) DEFAULT '0' COMMENT '策略：1主备策略',
    `status`        tinyint(1) unsigned DEFAULT '0' COMMENT '状态：0正常 1异常',
    `created_at`    datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at`    datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='线路基本配置汇总信息表 zh_2022_03_16';

LOCK
TABLES `linker_pro_lines` WRITE;
/*!40000 ALTER TABLE `linker_pro_lines` DISABLE KEYS */;

INSERT INTO `linker_pro_lines` (`id`, `cpe_id`, `is_default`, `type`, `name`, `remark`, `strategy_type`, `status`,
                                `created_at`, `updated_at`)
VALUES (1, 6, 1, 1, 'name', 'remark', 0, 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_lines` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_logs`;

CREATE TABLE `linker_pro_logs`
(
    `id`         int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`     int(11) DEFAULT NULL COMMENT 'cpe id',
    `uid`        int(11) DEFAULT NULL COMMENT '操作人',
    `control`    varchar(20) DEFAULT NULL COMMENT '操作模块',
    `action`     varchar(40) DEFAULT NULL COMMENT '操作内容',
    `created_at` datetime    DEFAULT NULL COMMENT '创建时间',
    `updated_at` datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表 zh_2022_03_15';

LOCK
TABLES `linker_pro_logs` WRITE;
/*!40000 ALTER TABLE `linker_pro_logs` DISABLE KEYS */;

INSERT INTO `linker_pro_logs` (`id`, `cpe_id`, `uid`, `control`, `action`, `created_at`, `updated_at`)
VALUES (1, 123, 6, '/api/cpe', 'add', NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_logs` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_nats
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_nats`;

CREATE TABLE `linker_pro_nats`
(
    `id`            int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`        int(11) DEFAULT NULL COMMENT 'cpe id',
    `type`          tinyint(1) DEFAULT '1' COMMENT 'NAT类型：1SNAT,2DNAT',
    `out_type`      tinyint(1) DEFAULT '1' COMMENT '出口：1dynamic 2ip',
    `line_id`       int(11) unsigned DEFAULT NULL COMMENT '端口',
    `src_ip`        varchar(17) DEFAULT NULL COMMENT '源地址',
    `src_port`      varchar(40) DEFAULT NULL COMMENT '源端口',
    `dst_ip`        varchar(17) DEFAULT NULL COMMENT '目的地址',
    `dst_port`      varchar(40) DEFAULT NULL COMMENT '目的端口',
    `protocol_type` tinyint(1) DEFAULT '1' COMMENT '协议类型：1ALL 2TCP 3UDP',
    `created_at`    datetime    DEFAULT NULL COMMENT '创建时间',
    `updated_at`    datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NAT管理配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_nats` WRITE;
/*!40000 ALTER TABLE `linker_pro_nats` DISABLE KEYS */;

INSERT INTO `linker_pro_nats` (`id`, `cpe_id`, `type`, `out_type`, `line_id`, `src_ip`, `src_port`, `dst_ip`,
                               `dst_port`, `protocol_type`, `created_at`, `updated_at`)
VALUES (1, 1, 11, 1, 1, '1', '1', '1', '1', 1, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_nats` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_nodes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_nodes`;

CREATE TABLE `linker_pro_nodes`
(
    `id`               int(11) unsigned NOT NULL AUTO_INCREMENT,
    `uid`              int(11) unsigned DEFAULT NULL COMMENT '用户id',
    `name`             varchar(60)    NOT NULL COMMENT '站点名称',
    `area`             varchar(10)    NOT NULL COMMENT '区域',
    `country`          varchar(20)    NOT NULL COMMENT '位置：国家',
    `city`             varchar(20)    NOT NULL COMMENT '位置：城市',
    `address`          varchar(100)   NOT NULL DEFAULT '' COMMENT '地址的详细信息',
    `longitude`        decimal(10, 4) NOT NULL COMMENT '坐标经度',
    `latitude`         decimal(10, 4) NOT NULL COMMENT '坐标纬度',
    `contact`          varchar(10)    NOT NULL COMMENT '联系人',
    `telephone`        varchar(20)    NOT NULL DEFAULT '' COMMENT '电话',
    `email`            varchar(40)    NOT NULL DEFAULT '' COMMENT '邮箱',
    `is_accelerate`    tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否加速站点：1是，2否',
    `sub_network_cidr` varchar(255)            DEFAULT NULL COMMENT '内部子网网段 ,逗号分隔',
    `next_hop`         varchar(40)    NOT NULL DEFAULT '' COMMENT '下一跳',
    `is_redundant`     tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '是否冗余链路：1是，2否',
    `is_ha`            tinyint(1) DEFAULT '1' COMMENT '是否双机热备：1是，2否',
    `status`           tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '站点状态：0正常，1异常',
    `created_at`       datetime       NOT NULL COMMENT '创建时间',
    `updated_at`       datetime       NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='站点信息表 zh_2022_03_15';

LOCK
TABLES `linker_pro_nodes` WRITE;
/*!40000 ALTER TABLE `linker_pro_nodes` DISABLE KEYS */;

INSERT INTO `linker_pro_nodes` (`id`, `uid`, `name`, `area`, `country`, `city`, `address`, `longitude`, `latitude`,
                                `contact`, `telephone`, `email`, `is_accelerate`, `sub_network_cidr`, `next_hop`,
                                `is_redundant`, `is_ha`, `status`, `created_at`, `updated_at`)
VALUES (1, NULL, '', '', '', '', '', 0.0000, 0.0000, '', '', '', 1, NULL, '', 2, 1, 0, '2022-02-21 22:22:11',
        '2022-02-21 22:22:11');

/*!40000 ALTER TABLE `linker_pro_nodes` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_object_apps
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_object_apps`;

CREATE TABLE `linker_pro_object_apps`
(
    `id`         int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`     int(11) DEFAULT NULL COMMENT 'cpe_id',
    `name`       varchar(40)  DEFAULT NULL COMMENT '名称',
    `remark`     varchar(255) DEFAULT NULL COMMENT '描述',
    `category`   int(11) DEFAULT NULL COMMENT '应用类型id，具体的类型名称在配置文件中',
    `ip`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT 'ip列表',
    `domains`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '域名列表',
    `created_at` datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at` datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='对象管理应用配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_object_apps` WRITE;
/*!40000 ALTER TABLE `linker_pro_object_apps` DISABLE KEYS */;

INSERT INTO `linker_pro_object_apps` (`id`, `cpe_id`, `name`, `remark`, `category`, `ip`, `domains`, `created_at`,
                                      `updated_at`)
VALUES (1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_object_apps` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_object_name_lists
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_object_name_lists`;

CREATE TABLE `linker_pro_object_name_lists`
(
    `id`         int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`     int(11) DEFAULT NULL COMMENT 'cpe id',
    `name`       varchar(40)  DEFAULT NULL COMMENT '名称',
    `remark`     varchar(255) DEFAULT NULL COMMENT '描述',
    `ips`        json         DEFAULT NULL COMMENT 'ip名单',
    `mac`        json         DEFAULT NULL COMMENT 'mac名单',
    `created_at` datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at` datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='对象管理时间对象配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_object_name_lists` WRITE;
/*!40000 ALTER TABLE `linker_pro_object_name_lists` DISABLE KEYS */;

INSERT INTO `linker_pro_object_name_lists` (`id`, `cpe_id`, `name`, `remark`, `ips`, `mac`, `created_at`, `updated_at`)
VALUES (1, 123, 'dafsdf', 'sfgsd', '122', '{
  \"a\": \"b\"}', NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_object_name_lists` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_object_protocols
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_object_protocols`;

CREATE TABLE `linker_pro_object_protocols`
(
    `id`              int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`          int(11) DEFAULT NULL COMMENT 'cpe id',
    `type`            tinyint(1) DEFAULT NULL COMMENT '协议类型：1系统内置协议，2用户自定义协议',
    `name`            varchar(40)                                           DEFAULT NULL COMMENT '协议名称',
    `remark`          varchar(255)                                          DEFAULT NULL COMMENT '描述',
    `tcp_port`        varchar(40)                                           DEFAULT NULL COMMENT 'tcp端口',
    `udp_port`        varchar(40)                                           DEFAULT NULL COMMENT 'udp端口',
    `ip_protocol_num` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'IP协议号',
    `icmp`            json                                                  DEFAULT NULL COMMENT 'ICMP参数',
    `created_at`      datetime                                              DEFAULT NULL COMMENT '创建时间',
    `updated_at`      datetime                                              DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='对象管理协议配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_object_protocols` WRITE;
/*!40000 ALTER TABLE `linker_pro_object_protocols` DISABLE KEYS */;

INSERT INTO `linker_pro_object_protocols` (`id`, `cpe_id`, `type`, `name`, `remark`, `tcp_port`, `udp_port`,
                                           `ip_protocol_num`, `icmp`, `created_at`, `updated_at`)
VALUES (1, 123, 1, 'adfa', 'adf', '1234', '234', X'616466', '1', NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_object_protocols` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_object_times
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_object_times`;

CREATE TABLE `linker_pro_object_times`
(
    `id`               int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`           int(11) DEFAULT NULL COMMENT 'cpe id',
    `name`             varchar(40)  DEFAULT NULL COMMENT '名称',
    `remark`           varchar(255) DEFAULT NULL COMMENT '描述',
    `weekdays`         json         DEFAULT NULL COMMENT '星期的选择',
    `time_range_start` varchar(5)   DEFAULT NULL COMMENT '时间段开始点',
    `time_range_end`   varchar(5)   DEFAULT NULL COMMENT '时间段结束点',
    `created_at`       datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at`       datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='对象管理时间对象配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_object_times` WRITE;
/*!40000 ALTER TABLE `linker_pro_object_times` DISABLE KEYS */;

INSERT INTO `linker_pro_object_times` (`id`, `cpe_id`, `name`, `remark`, `weekdays`, `time_range_start`,
                                       `time_range_end`, `created_at`, `updated_at`)
VALUES (1, 123, 'andf', 'sfasd', '123', '3:00', '5:00', NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_object_times` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_policies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_policies`;

CREATE TABLE `linker_pro_policies`
(
    `id`             int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`         int(11) DEFAULT NULL COMMENT 'cpe id',
    `index`          int(11) DEFAULT '1' COMMENT '排序号：默认1',
    `name`           varchar(40) DEFAULT NULL COMMENT '策略名称',
    `object_time_id` int(11) DEFAULT '0' COMMENT '时间对象id：默认0不限制',
    `src_ip_type`    tinyint(1) DEFAULT '1' COMMENT '源地址配置类型：1所有，2包含以下地址和对象，3排除以下地址和对象',
    `src_ip_rules`   json        DEFAULT NULL COMMENT '源地址配置对象',
    `dst_type`       tinyint(1) DEFAULT '1' COMMENT '策略方式：1ip地址 2域名 3协议 4应用类型',
    `traffic_type`   tinyint(1) DEFAULT '1' COMMENT '策略流量：1全量管理 2加速流量管理',
    `dst_rules`      json        DEFAULT NULL COMMENT '策略管理内容',
    `action`         tinyint(11) DEFAULT '1' COMMENT '策略动作：1允许，2拒绝',
    `status`         tinyint(1) DEFAULT '0' COMMENT '是否启用：0启用 1禁用',
    `created_at`     datetime    DEFAULT NULL COMMENT '创建时间',
    `updated_at`     datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='行为管理配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_policies` WRITE;
/*!40000 ALTER TABLE `linker_pro_policies` DISABLE KEYS */;

INSERT INTO `linker_pro_policies` (`id`, `cpe_id`, `index`, `name`, `object_time_id`, `src_ip_type`, `src_ip_rules`,
                                   `dst_type`, `traffic_type`, `dst_rules`, `action`, `status`, `created_at`,
                                   `updated_at`)
VALUES (1, 123, 1, 'name', 1, 1, '[
  \"a\", \"b\"]', 1, 1, '[
  \"a\", \"b\"]', 1, 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_policies` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_qoses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_qoses`;

CREATE TABLE `linker_pro_qoses`
(
    `id`             int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`         int(11) DEFAULT NULL COMMENT 'cpe id',
    `name`           varchar(20)  DEFAULT NULL COMMENT '规则名称',
    `line_id`        int(11) DEFAULT '0' COMMENT '线路id',
    `limit_bandwith` bigint(20) DEFAULT NULL COMMENT '限制带宽，单位kbytes',
    `limit_type`     tinyint(1) DEFAULT '2' COMMENT '限速方式:1upload 2download',
    `protocol_type`  tinyint(1) DEFAULT '0' COMMENT '协议类型：0ALL 1TCP 2UDP ',
    `src_ip`         varchar(255) DEFAULT '' COMMENT '源地址',
    `src_port`       varchar(40)  DEFAULT NULL COMMENT '源端口',
    `dst_ip`         varchar(255) DEFAULT NULL COMMENT '目的地址',
    `dst_port`       varchar(40)  DEFAULT NULL COMMENT '目的端口',
    `created_at`     datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at`     datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='QOS规则配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_qoses` WRITE;
/*!40000 ALTER TABLE `linker_pro_qoses` DISABLE KEYS */;

INSERT INTO `linker_pro_qoses` (`id`, `cpe_id`, `name`, `line_id`, `limit_bandwith`, `limit_type`, `protocol_type`,
                                `src_ip`, `src_port`, `dst_ip`, `dst_port`, `created_at`, `updated_at`)
VALUES (1, 1, '1', 0, 1, 2, 1, '1', '1', '1', '1', NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_qoses` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_router_apps
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_router_apps`;

CREATE TABLE `linker_pro_router_apps`
(
    `id`             int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`         int(11) DEFAULT NULL COMMENT 'cpe id',
    `in_line_id`     int(11) DEFAULT NULL COMMENT '入口线路id',
    `out_line_id`    int(11) DEFAULT NULL COMMENT '出口线路id',
    `remark`         varchar(255) DEFAULT NULL COMMENT '备注',
    `src_ip_type`    tinyint(1) DEFAULT '1' COMMENT '源地址配置类型：1所有，2包含以下地址和对象，3排除以下地址和对象',
    `src_ip_rules`   json         DEFAULT NULL COMMENT '源地址配置规则',
    `dst_ip_rules`   json         DEFAULT NULL COMMENT '目的地址配置规则 json',
    `protocol_rules` json         DEFAULT NULL COMMENT '协议规则',
    `status`         tinyint(1) DEFAULT '1' COMMENT '状态1启用2禁用',
    `created_at`     datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at`     datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='路由管理应用路由配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_router_apps` WRITE;
/*!40000 ALTER TABLE `linker_pro_router_apps` DISABLE KEYS */;

INSERT INTO `linker_pro_router_apps` (`id`, `cpe_id`, `in_line_id`, `out_line_id`, `remark`, `src_ip_type`,
                                      `src_ip_rules`, `dst_ip_rules`, `protocol_rules`, `status`, `created_at`,
                                      `updated_at`)
VALUES (1, 123, 123, 1, '1', 1, NULL, NULL, NULL, NULL, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_router_apps` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_task
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_task`;

CREATE TABLE `linker_pro_task`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT,
    `uid`        int(11) NOT NULL COMMENT '用户uid',
    `type`       tinyint(3) NOT NULL COMMENT '任务类型',
    `content`    mediumtext NOT NULL COMMENT '任务内容以及关联的cpeid列表',
    `status`     tinyint(3) NOT NULL DEFAULT '1' COMMENT '下发状态0:无须下发 1未分析2下发中3任务成功4任务失败',
    `created_at` datetime   NOT NULL COMMENT '创建时间',
    `updated_at` datetime   NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



#
转储表 linker_pro_task_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_task_detail`;

CREATE TABLE `linker_pro_task_detail`
(
    `id`          int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`      int(11) NOT NULL COMMENT '设备id',
    `task_id`     int(11) NOT NULL COMMENT '总任务id',
    `pid`         int(11) DEFAULT '0' COMMENT '父级id 执行先后顺序',
    `request_id`  varchar(32) NOT NULL COMMENT '请求id',
    `content`     mediumtext  NOT NULL COMMENT '下发内容',
    `cpe_type`    tinyint(3) DEFAULT NULL COMMENT 'cpe下发类型',
    `exec_result` text COMMENT '执行结果',
    `try_times`   int(11) DEFAULT '0' COMMENT '尝试次数',
    `status`      tinyint(3) DEFAULT '1' COMMENT '状态 0：无须下发。1未下发2已下发zookeeper3成功4失败5超时',
    `created_at`  datetime    NOT NULL COMMENT '创建时间',
    `updated_at`  datetime    NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



#
转储表 linker_pro_topologies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_topologies`;

CREATE TABLE `linker_pro_topologies`
(
    `id`             int(11) unsigned NOT NULL AUTO_INCREMENT,
    `uid`            int(11) unsigned DEFAULT NULL COMMENT '用户 id',
    `name`           varchar(50) DEFAULT NULL COMMENT '拓扑名称',
    `type`           tinyint(1) unsigned DEFAULT NULL COMMENT '拓扑类型：1SpokeHub 2FullMesh 3PointToPoint',
    `center_node_id` int(11) unsigned DEFAULT NULL COMMENT '中心站点 id',
    `node_ids`       json        DEFAULT NULL COMMENT '站点id集合，拓扑类型为1则不包括主节点id',
    `is_nat`         tinyint(1) unsigned DEFAULT '1' COMMENT '组网时，分支内网地址端冲突需开启NAT功能：1否 2是',
    `start_node_id`  json        DEFAULT NULL COMMENT '起始站点id',
    `end_node_id`    json        DEFAULT NULL COMMENT '结束站点id',
    `is_branch_conn` tinyint(1) DEFAULT '1' COMMENT '是否启用分支互联功能：1否 2是',
    `status`         tinyint(1) unsigned DEFAULT '0' COMMENT '拓扑状态：0正常，1异常',
    `created_at`     datetime    DEFAULT NULL COMMENT '创建时间',
    `updated_at`     datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='拓扑关系表 zh_2022_03_15';

LOCK
TABLES `linker_pro_topologies` WRITE;
/*!40000 ALTER TABLE `linker_pro_topologies` DISABLE KEYS */;

INSERT INTO `linker_pro_topologies` (`id`, `uid`, `name`, `type`, `center_node_id`, `node_ids`, `is_nat`,
                                     `start_node_id`, `end_node_id`, `is_branch_conn`, `status`, `created_at`,
                                     `updated_at`)
VALUES (1, 121, '中', 1, 1223, '[
  \"0\", \"123\"]', 1, NULL, NULL, 1, 1, NULL, NULL),
       (2, 2, 'adf', 2, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_topologies` ENABLE KEYS */;
UNLOCK
TABLES;


#
转储表 linker_pro_vpns
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linker_pro_vpns`;

CREATE TABLE `linker_pro_vpns`
(
    `id`             int(11) unsigned NOT NULL AUTO_INCREMENT,
    `cpe_id`         int(11) DEFAULT NULL COMMENT 'cpe id',
    `type`           tinyint(1) DEFAULT '1' COMMENT '传输协议：1是隧道，2是传输',
    `name`           varchar(20)  DEFAULT NULL COMMENT '名称',
    `desc`           varchar(255) DEFAULT NULL COMMENT '描述',
    `line_id`        int(11) DEFAULT '0' COMMENT '线路id',
    `life_time`      int(11) DEFAULT NULL COMMENT '生存周期',
    `work_type`      tinyint(1) DEFAULT '1' COMMENT '工作模式：1服务端，2客户端',
    `encry_ike`      json         DEFAULT NULL COMMENT 'ike加密认证 json',
    `encry_ipsec`    json         DEFAULT NULL COMMENT 'ipsec加密认证 json',
    `listening_port` varchar(40)  DEFAULT NULL COMMENT '监听端口， “-”分隔',
    `is_vni`         tinyint(1) DEFAULT '1' COMMENT '是否启用vni：0启用，1禁用',
    `local`          json         DEFAULT NULL COMMENT '本端配置',
    `peer`           json         DEFAULT NULL COMMENT '对端配置',
    `status`         tinyint(1) DEFAULT '0' COMMENT '状态：0启用 1禁用',
    `created_at`     datetime     DEFAULT NULL COMMENT '创建时间',
    `updated_at`     datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='VPN隧道配置表 zh_2022_03_15';

LOCK
TABLES `linker_pro_vpns` WRITE;
/*!40000 ALTER TABLE `linker_pro_vpns` DISABLE KEYS */;

INSERT INTO `linker_pro_vpns` (`id`, `cpe_id`, `type`, `name`, `desc`, `line_id`, `life_time`, `work_type`, `encry_ike`,
                               `encry_ipsec`, `listening_port`, `is_vni`, `local`, `peer`, `status`, `created_at`,
                               `updated_at`)
VALUES (1, 123, 1, 'name', 'desc', 1, 123, 1, '[
  \"a\", \"b\"]', '[
  \"a\", \"b\"]', '333', 1, '[
  \"a\", \"b\"]', '[
  \"a\", \"b\"]', 0, NULL, NULL);

/*!40000 ALTER TABLE `linker_pro_vpns` ENABLE KEYS */;
UNLOCK
TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
