C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([ExtendTime_Maintenance:98]; "ExtTime In")
ADD RECORD:C56([ExtendTime_Maintenance:98])
vbNewRec:=False:C215
RELATE MANY:C262([Contract_Maintenance:97])
ORDER BY:C49([ExtendTime_Maintenance:98]; [ExtendTime_Maintenance:98]InitialDate:6; >)