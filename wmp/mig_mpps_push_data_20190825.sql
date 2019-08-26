-- 1. 전환 대상 mpps_push_data 신규 테이블 생성
CREATE TABLE `mpps_push_data_20190826` (
  `ID` bigint(20) NOT NULL,
  `PUSH_ID` decimal(18,0) NOT NULL,
  `SYSTEM_ID` int(11) NOT NULL,
  `PUSH_GROUP_KEY` varchar(512) NOT NULL,
  `PUSH_GROUP_ID` decimal(18,0) DEFAULT NULL,
  `MSG_UUID` varchar(60) DEFAULT NULL,
  `PUSH_RECEIVER` varchar(20) NOT NULL,
  `MSG_TYPE` char(18) DEFAULT NULL,
  `NOTI_MSG_SEND_YN` varchar(1) NOT NULL,
  `PAYLOAD` text,
  `PPC_BROADCAST_ACT_NM` varchar(64) NOT NULL,
  `PPC_APP_NM` varchar(32) DEFAULT NULL,
  `PPC_PACKAGE_NM` varchar(64) DEFAULT NULL,
  `PPC_MODE` tinyint(3) unsigned DEFAULT NULL,
  `FAILOVER` varchar(1) NOT NULL,
  `PPC_TTL` int(11) NOT NULL,
  `PRIORITY` tinyint(3) unsigned NOT NULL,
  `REG_DT` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`ID`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE mpps_push_data_20190826 MODIFY COLUMN payload text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 2. 신규 테이블에 데이터 INSERT
insert into mpps_push_data_20190826 select * from mpps_push_data;

commit;

-- 3. 기존 테이블에 데이터 index rename
ALTER TABLE mpps_push_data RENAME INDEX `XIE_MPPS_PUSH_DATA_IDX01` TO `XIE_MPPS_PUSH_DATA_IDX01_20190826_bak`;
ALTER TABLE mpps_push_data RENAME INDEX `XIE_MPPS_PUSH_DATA_IDX02` TO `XIE_MPPS_PUSH_DATA_IDX02_20190826_bak`;
ALTER TABLE mpps_push_data RENAME INDEX `XIE_MPPS_PUSH_DATA_IDX03` TO `XIE_MPPS_PUSH_DATA_IDX03_20190826_bak`;
ALTER TABLE mpps_push_data RENAME INDEX `XIE_MPPS_PUSH_DATA_IDX04` TO `XIE_MPPS_PUSH_DATA_IDX04_20190826_bak`;
ALTER TABLE mpps_push_data RENAME INDEX `XIE_MPPS_PUSH_DATA_IDX05` TO `XIE_MPPS_PUSH_DATA_IDX05_20190826_bak`;
ALTER TABLE mpps_push_data RENAME INDEX `XAK_MPPS_PUSH_DATA_IDX06` TO `XAK_MPPS_PUSH_DATA_IDX06_20190826_bak`;
ALTER TABLE mpps_push_data RENAME INDEX `XAK_MPPS_PUSH_DATA_IDX07` TO `XAK_MPPS_PUSH_DATA_IDX07_20190826_bak`;
ALTER TABLE mpps_push_data RENAME INDEX `XIE_MPPS_PUSH_DATA_IDX08` TO `XIE_MPPS_PUSH_DATA_IDX08_20190826_bak`;

-- 4. 기존 테이블 rename
RENAME TABLE mpps_push_data TO mpps_push_data_20190826_bak;

-- 5. 신규 테이블을 이름변경
RENAME TABLE mpps_push_data_20190826 TO mpps_push_data;

-- 6. 신규 테이블 인덱스 생성
CREATE UNIQUE INDEX XAK_MPPS_PUSH_DATA_IDX06 ON mpps_push_data (`SYSTEM_ID`,`PUSH_ID`);
CREATE UNIQUE INDEX XAK_MPPS_PUSH_DATA_IDX07 ON mpps_push_data (`MSG_UUID`);
CREATE INDEX XIE_MPPS_PUSH_DATA_IDX01 ON mpps_push_data (`PUSH_RECEIVER`);
CREATE INDEX XIE_MPPS_PUSH_DATA_IDX02 ON mpps_push_data (`PUSH_RECEIVER`,`NOTI_MSG_SEND_YN`);
CREATE INDEX XIE_MPPS_PUSH_DATA_IDX03 ON mpps_push_data (`PUSH_GROUP_KEY`(255));
CREATE INDEX XIE_MPPS_PUSH_DATA_IDX04 ON mpps_push_data (`SYSTEM_ID`);
CREATE INDEX XIE_MPPS_PUSH_DATA_IDX05 ON mpps_push_data (`PUSH_GROUP_ID`);
CREATE INDEX XIE_MPPS_PUSH_DATA_IDX08 ON mpps_push_data (`SYSTEM_ID`,`PUSH_GROUP_ID`);

-- 6. 신규 테이블 sequence 지정
ALTER TABLE mpps_push_data MODIFY ID bigint(20) NOT NULL AUTO_INCREMENT;  


--show table status where name = 'mpps_push_data';

--SELECT AUTO_INCREMENT
--FROM information_schema.TABLES
--WHERE TABLE_SCHEMA = "yourDatabaseName"
--AND TABLE_NAME = "mpps_push_data";

select max(seq) + 1 mpps_push_data_seq from mpps_push_data
union all
select max(seq) + 1 mpps_push_data_20190826_bak_seq from mpps_push_data_20190826_bak;

ALTER TABLE mpps_push_data AUTO_INCREMENT = XXXXX;

