
SELECT userInfo.userIdnfr, 
       pmsPushkeyInfo.pcPushKey,
       ppsPushkeyInfo.UUID,
       pushHistory.DEVICE_MSG_UUID,
       pushHistory.PPC_PUSH_STATUS,
       pushData.PAYLOAD,
       pushHistory.REG_DT
  FROM mPMS_USER_INFO10 userInfo,
       mPMS_USER_DEVICE10 deviceInfo,
       mPMS_PUSH_KEY_INFO pmsPushkeyInfo,
       mPPS_PUSH_KEY_MAP ppsPushkeyInfo,
       MPPS_PUSH_DEVICE pushDevice,
       MPPS_PUSH_DATA_HISTORY pushHistory,
       MPPS_PUSH_DATA pushData
   WHERE userinfo.userIdnfr = deviceInfo.userIdnfr
  AND deviceInfo.userDevceIdnfr = pmsPushkeyInfo.userDevceIdnfr
  AND pmsPushKeyInfo.pcPushKey = ppsPushkeyInfo.PPC_PUSH_KEY
  AND ppsPushkeyInfo.PPC_PUSH_KEY = pushDevice.PPC_PUSH_KEY
  AND pushDevice.DEVICE_MSG_UUID = pushHistory.DEVICE_MSG_UUID
  AND pushDevice.MSG_UUID = pushData.MSG_UUID
  AND userInfo.regiStusDstcd = '10'
  AND deviceInfo.regiStusDstcd = '10'
  AND userInfo.name = '채지윤'
  AND deviceInfo.devceOsType in ('P')
  AND pushHistory.DEVICE_MSG_UUID NOT IN (
		  SELECT DISTINCT
			   pushHistory.DEVICE_MSG_UUID
		  FROM mPMS_USER_INFO10 userInfo,
			   mPMS_USER_DEVICE10 deviceInfo,
			   mPMS_PUSH_KEY_INFO pmsPushkeyInfo,
			   mPPS_PUSH_KEY_MAP ppsPushkeyInfo,
			   MPPS_PUSH_DEVICE pushDevice,
			   MPPS_PUSH_DATA_HISTORY pushHistory,
			   MPPS_PUSH_DATA pushData
		   WHERE userinfo.userIdnfr = deviceInfo.userIdnfr
		  AND deviceInfo.userDevceIdnfr = pmsPushkeyInfo.userDevceIdnfr
		  AND pmsPushKeyInfo.pcPushKey = ppsPushkeyInfo.PPC_PUSH_KEY
		  AND ppsPushkeyInfo.PPC_PUSH_KEY = pushDevice.PPC_PUSH_KEY
		  AND pushDevice.DEVICE_MSG_UUID = pushHistory.DEVICE_MSG_UUID
		  AND pushDevice.MSG_UUID = pushData.MSG_UUID
		  AND userInfo.regiStusDstcd = '10'
		  AND deviceInfo.regiStusDstcd = '10'
		  AND userInfo.name = '채지윤'
		  AND deviceInfo.devceOsType in ('P')
		  AND pushHistory.PPC_PUSH_STATUS = 0
	   )
  ORDER BY pushHistory.reg_dt DESC;
