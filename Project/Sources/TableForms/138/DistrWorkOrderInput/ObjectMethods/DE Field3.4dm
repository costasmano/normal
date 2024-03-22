If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/7/09 10:06:08)
	Mods_2009_08
End if 

C_TEXT:C284($message)

$message:="You have entered an incorrect BIN number. Please reenter it again."
DCM_SetBINInfo("INIT")
READ ONLY:C145([Bridge MHD NBIS:1])
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[DCM_Project:138]BIN:5)

If (Records in selection:C76([Bridge MHD NBIS:1])=0)
	ALERT:C41($message)
	GOTO OBJECT:C206([DCM_Project:138]BIN:5)
Else 
	DCM_SetBINInfo("SET")
	DCM_LOADBrgInfo("LOAD")
End if 