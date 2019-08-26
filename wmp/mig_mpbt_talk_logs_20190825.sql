-- 1. 전환 대상 mpbt_talk_logs 신규 테이블 생성
CREATE TABLE `mpbt_talk_logs_20190826` (
  `seq` bigint(20) NOT NULL ,
  `msgID` varchar(50) DEFAULT NULL,
  `userIdnfr` bigint(20) DEFAULT NULL,
  `userName` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `department` varchar(600) DEFAULT NULL,
  `pushGroupKey` varchar(50) DEFAULT NULL,
  `msgType` tinyint(3) unsigned DEFAULT '0',
  `sticker` varchar(100) DEFAULT '',
  `message` text,
  `roomId` decimal(18,0) NOT NULL,
  `tId` decimal(18,0) NOT NULL,
  `recvUserIdnfr` varchar(4000) DEFAULT NULL,
  `readUserIdnfr` varchar(4000) DEFAULT NULL,
  `AttachFile_Seq` decimal(18,0) DEFAULT NULL,
  `AttachFile_Type` varchar(3) DEFAULT NULL,
  `AttachFile_Name` varchar(600) DEFAULT NULL,
  `AttachFile_Size` int(11) DEFAULT NULL,
  `AttachFile_Path` varchar(1000) DEFAULT NULL,
  `AttachFile_ThumURL` varchar(1000) DEFAULT NULL,
  `AttachFile_URL` varchar(1000) DEFAULT NULL,
  `deleteYN` char(1) DEFAULT 'N',
  `serverID` varchar(50) DEFAULT NULL,
  `pushSendState` tinyint(3) unsigned DEFAULT NULL,
  `regDate` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `readCnt` int(11) NOT NULL DEFAULT '0',
  `extJsonStr` varchar(8000) DEFAULT NULL,
  `dbRegDate` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE mpbt_talk_logs_20190826 MODIFY COLUMN message text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 2. 신규 테이블에 데이터 INSERT
insert into mpbt_talk_logs_20190826 select * from mpbt_talk_logs;

commit;

-- 3. 기존 테이블에 데이터 index rename
ALTER TABLE mpbt_talk_logs RENAME INDEX `IX_mPBT_TALK_LOGS_tID_uID_rID` TO `IX_mPBT_TALK_LOGS_tID_uID_rID_20190826_bak`;
ALTER TABLE mpbt_talk_logs RENAME INDEX `IX_mPBT_TALK_LOGS_tID_rID` TO `IX_mPBT_TALK_LOGS_tID_rID_20190826_bak`;
ALTER TABLE mpbt_talk_logs RENAME INDEX `IX_mPBT_TALK_LOGS_psState_regdate` TO `IX_mPBT_TALK_LOGS_psState_regdate_20190826_bak`;

ALTER TABLE mpbt_talk_logs_20190826 RENAME INDEX `IX_mPBT_TALK_LOGS_tID_rID_dbRegDate` TO `IX_mPBT_TALK_LOGS_tID_rID_dbRegDate_20190826_bak`;

-- 4. 기존 테이블 rename
RENAME TABLE mpbt_talk_logs TO mpbt_talk_logs_20190826_bak;

-- 5. 신규 테이블을 이름변경
RENAME TABLE mpbt_talk_logs_20190826 TO mpbt_talk_logs;

-- 6. 신규 테이블 인덱스 생성
CREATE INDEX IX_mPBT_TALK_LOGS_tID_uID_rID ON mpbt_talk_logs (`tId`,`userIdnfr`,`roomId`);
CREATE INDEX IX_mPBT_TALK_LOGS_tID_rID ON mpbt_talk_logs (`tId`,`roomId`);
CREATE INDEX IX_mPBT_TALK_LOGS_psState_regdate ON mpbt_talk_logs (`pushSendState`,`regDate`);
CREATE INDEX IX_mPBT_TALK_LOGS_tID_rID_dbRegDate ON mpbt_talk_logs (`roomId`,`dbRegDate`)

-- 6. 신규 테이블 sequence 지정
ALTER TABEL mpbt_talk_logs MODIFY 'seq' bigint(20) NOT NULL AUTO_INCREMENT;  


--show table status where name = 'mpbt_talk_logs';

--SELECT AUTO_INCREMENT
--FROM information_schema.TABLES
--WHERE TABLE_SCHEMA = "yourDatabaseName"
--AND TABLE_NAME = "mpbt_talk_logs";

select max(seq) + 1 from mpbt_talk_logs;

ALTER TABLE mpbt_talk_logs AUTO_INCREMENT = XXXXX;
