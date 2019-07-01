SELECT userInfo.userIdnfr, 
       userInfo.sawonNo, 
       userInfo.name, 
       userInfo.position, 
       deviceInfo.userDevceIdnfr, 
       deviceInfo.devceOsType,
       pmsPushkeyInfo.pcPushKey,
       ppsPushkeyInfo.UUID,
       pushHistory.DEVICE_MSG_UUID,
       pushHistory.PPC_PUSH_STATUS,
       pushHistory.REG_DT,
       pushData.PAYLOAD
  FROM [MTALK].[pms].[mPMS_USER_INFO10] userInfo,
       [MTALK].[pms].[mPMS_USER_DEVICE10] deviceInfo,
       [MTALK].[pms].[mPMS_PUSH_KEY_INFO] pmsPushkeyInfo,
       [MTALK].[pps].[mPPS_PUSH_KEY_MAP] ppsPushkeyInfo,
       [MTALK].[pps].[MPPS_PUSH_DEVICE] pushDevice,
       [MTALK].[pps].[MPPS_PUSH_DATA_HISTORY] pushHistory,
       [MTALK].[pps].[MPPS_PUSH_DATA] pushData
  WHERE userinfo.userIdnfr = deviceInfo.userIdnfr
  AND deviceInfo.userDevceIdnfr = pmsPushkeyInfo.userDevceIdnfr
  AND pmsPushKeyInfo.pcPushKey = ppsPushkeyInfo.PPC_PUSH_KEY
  AND ppsPushkeyInfo.PPC_PUSH_KEY = pushDevice.PPC_PUSH_KEY
  AND pushDevice.DEVICE_MSG_UUID = pushHistory.DEVICE_MSG_UUID
  AND pushDevice.MSG_UUID = pushData.MSG_UUID
  AND userInfo.regiStusDstcd = '10'
  AND deviceInfo.regiStusDstcd = '10'
  AND userInfo.name = '이승원'
  AND deviceInfo.devceOsType in ('A')
  ORDER BY pushHistory.reg_dt DESC;
  
  
select distinct substring(uuid, 18, 10) from pps.mpps_push_key_map
where right(ppc_push_key, 1) = 'P' 
and substring(uuid, 18, 10) like '%' + '-P' + '%'

select distinct substring(uuid, 18, 10) from pps.mpps_push_key_map
where right(ppc_push_key, 1) = 'A' 

select distinct substring(uuid, 34, 10) from pps.mpps_push_key_map
where right(ppc_push_key, 1) = 'I' 



delete from pps.mPPS_Push_Data 
where reg_dt < convert(varchar(10), dateadd(d, -15, getdate()), 121)

delete from pps.MPPS_PUSH_DEVICE_SUCCESS
where reg_dt < convert(varchar(10), dateadd(d, -15, getdate()), 121)

delete from pps.MPPS_PUSH_DEVICE_PROGRESS
where reg_dt < convert(varchar(10), dateadd(d, -15, getdate()), 121)

delete from pps.MPPS_PUSH_DEVICE_READY
where reg_dt < convert(varchar(10), dateadd(d, -15, getdate()), 121)

delete from pps.mPPS_Push_Data_History 
where reg_dt < convert(varchar(10), dateadd(d, -15, getdate()), 121)

delete from pbt.mPbt_PushLogs 
where regDate < convert(varchar(10), dateadd(d, -15, getdate()), 121)

delete from pps.mPps_Push_GROUP 
where reg_dt < convert(varchar(10), dateadd(d, -15, getdate()), 121)

delete from pps.mPps_Push_DEVICE
where reg_dt < convert(varchar(10), dateadd(d, -15, getdate()), 121)
