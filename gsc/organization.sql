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
