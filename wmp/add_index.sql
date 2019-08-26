create index IX_mPBT_TALK_LOGS_tID_rID_dbRegDate On mPBT_Talk_Logs (roomId, dbregdate);     

create index IX_mPBT_P2P_Room_Member_Info_rID_updDt On mPBT_P2P_Room_Member_Info (roomId, lastUpdateDate);   


CREATE TABLE mPBT_File_Info (
  id int NOT NULL AUTO_INCREMENT,
  f_type tinyint NOT NULL DEFAULT 99,
  f_name varchar(100) NOT NULL,
  f_path varchar(512) NOT NULL,
  f_size int NOT NULL,
  reg_id int NOT NULL,
  reg_dt timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (id)
);

CREATE TABLE mPBT_File_Conversion_Info (
  f_id int NOT NULL,
  c_type varchar(20) NOT NULL,
  f_order int NOT NULL DEFAULT 0,
  f_path varchar(512) NOT NULL,
  f_size int  NOT NULL,
  reg_id int NOT NULL,
  reg_dt timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (f_id, c_type, f_order)
);
