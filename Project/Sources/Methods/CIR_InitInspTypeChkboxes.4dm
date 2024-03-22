//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/03/06, 13:05:23
	// ----------------------------------------------------
	// Method: CIR_InitInspTypeChkboxes
	// Description
	// Initialize the check boxes on the [Cons Inspection] input form
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(5/19/09 08:33:10)
	Mods_2009_05
	//Initialize the checkboxes to zero on load
End if 

C_TEXT:C284($sInspType)  // Command Replaced was o_C_STRING length was 100
chkRoutine:=0
chkSM:=0
chkFC:=0
chkMec:=0
chkElec:=0
chkTesting:=0
$sInspType:=[Cons Inspection:64]InspType:33
If (Position:C15("Routine"; $sInspType)#0)
	chkRoutine:=1
End if 

If (Position:C15("Special Member"; $sInspType)#0)
	chkSM:=1
End if 

If (Position:C15("Fracture Critical"; $sInspType)#0)
	chkFC:=1
End if 

If (Position:C15("Mechanical"; $sInspType)#0)
	chkMec:=1
End if 

If (Position:C15("Electrical"; $sInspType)#0)
	chkElec:=1
End if 

If (Position:C15("Testing"; $sInspType)#0)
	chkTesting:=1
End if 

CIR_SetReceiveLabels