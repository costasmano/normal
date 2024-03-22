C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([Contract Assignments:83]; "Assignments In")
ADD RECORD:C56([Contract Assignments:83])
vbNewRec:=False:C215
RELATE MANY:C262([Contracts:79])

ORDER BY:C49([Contract Assignments:83]; [Contract Assignments:83]AssignNo:2; >)