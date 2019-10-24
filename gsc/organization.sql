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
