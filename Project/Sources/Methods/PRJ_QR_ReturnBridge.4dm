//%attributes = {"shared":true}
// ----------------------------------------------------
// PRJ_QR_ReturnBridge
// User name (OS): cjmiller
// Date and time: 03/15/07, 16:40:00
// ----------------------------------------------------
// Description
// This method will return bridge or non bridge for quick reports
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(9/14/09 11:07:46)
	Mods_2009_09  //  `Adjusted the method to add a "T" for Temporary bridges
End if 
C_TEXT:C284($0; $BridgeNo_txt)

If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5="")
	$BridgeNo_txt:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
Else 
	$BridgeNo_txt:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
End if 
If ([PRJ_ProjectDetails:115]PRJ_TemporaryBridge_b:6)
	$BridgeNo_txt:=$BridgeNo_txt+"T"
	C_LONGINT:C283($eqPos_L)
	$eqPos_L:=Position:C15("="; $BridgeNo_txt)
	If ($eqPos_L>0)
		//Equation -add T before = 
		$BridgeNo_txt:=Substring:C12($BridgeNo_txt; 1; ($eqPos_L-1))+"T"+Substring:C12($BridgeNo_txt; $eqPos_L)
	End if 
End if 
$0:=$BridgeNo_txt
//End PRJ_QR_ReturnBridge