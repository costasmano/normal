//Add button in Consultant Rating

C_BOOLEAN:C305(vbNewRtgRec)

FORM SET INPUT:C55([Conslt Rating:63]; "Cslt Rating In")
ADD RECORD:C56([Conslt Rating:63])
vbNewRtgRec:=False:C215
RELATE MANY:C262([Bridge MHD NBIS:1])
