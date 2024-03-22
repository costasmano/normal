C_TEXT:C284($message)
C_TEXT:C284(vBIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284(vBridgeNo)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vLocation)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vTown)  // Command Replaced was o_C_STRING length was 26

$message:="You have entered an incorrect BIN number. Please reenter it again."
vBridgeNo:=""
vDistrict:=""
vLocation:=""
vTown:=""

QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)

If (Records in selection:C76([Bridge MHD NBIS:1])=0)
	ALERT:C41($message)
Else 
	vBridgeNo:=[Bridge MHD NBIS:1]BDEPT:1
	vDistrict:=[Bridge MHD NBIS:1]Item2:60
	vTown:=[Bridge MHD NBIS:1]Town Name:175
	vLocation:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
End if 