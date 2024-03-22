C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([Contract ExtendTime:81]; "ExtTime In")
ADD RECORD:C56([Contract ExtendTime:81])
vbNewRec:=False:C215
RELATE MANY:C262([Contracts:79])

ORDER BY:C49([Contract ExtendTime:81]; [Contract ExtendTime:81]InitialDate:6; >)