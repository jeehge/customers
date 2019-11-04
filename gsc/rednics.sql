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
