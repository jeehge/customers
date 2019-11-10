SELECT upperGroupCoCd, count(*) FROM [pms].[mPMS_USER_GROUP10]
where upperGroupCoCd = 'GS'
group by upperGroupCoCd

SELECT * FROM [pms].[mPMS_USER_GROUP10]
where name = 'GS칼텍스(주)'    C1    -- upperGroupIdnfr = 0    728

SELECT * FROM [pms].[mPMS_USER_GROUP10]
where groupIdnfr = 728

SELECT * FROM [pms].[mPMS_USER_GROUP10]
where upperGroupIdnfr = 728


SELECT * FROM [pms].[mPMS_USER_GROUP10]
where upperGroupIdnfr = 0
and regiStusDstcd = '10'
and groupCoCd = 'GS'
order by dispOrder ASC

-------------------------------------------------------------------------------------------------

WITH tree_query 
     AS (SELECT legacyPK,
		            groupIdnfr, 
                upperGroupIdnfr, 
                name, 
                CONVERT(VARCHAR(255), groupIdnfr)   sort, 
                CONVERT(VARCHAR(255), name) depth_fullname 
         FROM   [pms].[mPMS_USER_GROUP10]
         WHERE  upperGroupIdnfr = 0 
         UNION ALL 
         SELECT B.LegacyPK,
				        B.groupIdnfr, 
                B.upperGroupIdnfr, 
                B.name, 
                CONVERT(VARCHAR(255), CONVERT(NVARCHAR, C.sort) + ' > ' 
                                      + CONVERT(VARCHAR(255), B.groupIdnfr))   sort, 
                CONVERT(VARCHAR(255), CONVERT(NVARCHAR, C.depth_fullname) + 
                                      ' > ' 
                                      + CONVERT(VARCHAR(255), B.name)) 
                depth_fullname 
         FROM   [pms].[mPMS_USER_GROUP10] B, 
                tree_query C 
         WHERE  B.upperGroupIdnfr = C.groupIdnfr) 
SELECT legacyPK,
			 groupIdnfr, 
       upperGroupIdnfr, 
       name, 
       depth_fullname 
FROM   tree_query 
ORDER  BY sort 

-------------------------------------------------------------------------------------------------
CREATE TABLE [pbt].[Talk_Server_Config_Info] (
  [config_key] varchar(50) NOT NULL,
  [config_value] varchar(256) NOT NULL,
  [reg_id] numeric(18)  NOT NULL,
  [reg_dt] datetime2(7) DEFAULT (getdate()) NOT NULL,
  [upd_id] numeric(18)  NOT NULL,
  [upd_dt] datetime2(7) DEFAULT (getdate()) NOT NULL
)
GO
-------------------------------------------------------------------------------------------------				 
Download-Allow-Code-For.C1	C7,C8	0	2019-11-05 09:53:30.5730000	0	2019-11-05 09:53:30.5730000
Download-Allow-Code-For.C7	C1,C8	0	2019-11-08 03:26:37.0000000	0	2019-11-08 03:27:35.0000000
Download-Allow-Code-For.C8	C1,C7	0	2019-11-08 03:27:14.0000000	0	2019-11-08 03:27:18.4930000
