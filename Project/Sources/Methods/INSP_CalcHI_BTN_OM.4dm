//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/01/10, 12:43:59
	// ----------------------------------------------------
	// Method: INSP_CalcHI_BTN_OM
	// Description
	//  ` Method for the CalcHI Button Object method.
	// 
	// Parameters
	// $1 : $FormEvent_L - Optional
	// ----------------------------------------------------
	
	Mods_2010_02
	// Modified by: costasmanousakis-(Designer)-(5/18/10 11:41:31)
	Mods_2010_05
	//Added a call to RememberCombined at the On Clicked event. - The BMS Inspection
	//record might not be loaded.
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		INSP_HICalcControl("INIT")
	: ($FormEvent_L=On Clicked:K2:4)
		SHORT_MESSAGE("Calculating HI...")
		RememberCombined
		INSP_HICalcControl("CALC")
		INSP_HICalcControl("TODB"; 3)
		CLOSE WINDOW:C154
End case 