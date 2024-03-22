C_TEXT:C284($message)

$message:="You have entered an incorrect BIN number. Please reenter it again."
SCPOA_DetBridgeNo_txt:=""
SCPOA_DetLocation_txt:=""
SCPOA_DetTown_txt:=""

QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[ScourPOA_DetourBridge:133]DetourBIN:3)

If (Records in selection:C76([Bridge MHD NBIS:1])=0)
	ALERT:C41($message)
	[ScourPOA_DetourBridge:133]DetourBIN:3:=""
	GOTO OBJECT:C206([ScourPOA_DetourBridge:133]DetourBIN:3)
Else 
	SCPOA_DetBridgeNo_txt:=[Bridge MHD NBIS:1]BDEPT:1
	SCPOA_DetTown_txt:=[Bridge MHD NBIS:1]Town Name:175
	SCPOA_DetLocation_txt:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
End if 