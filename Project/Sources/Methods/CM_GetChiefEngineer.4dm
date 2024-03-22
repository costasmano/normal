//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 06/29/05, 10:50:00
	// ----------------------------------------------------
	// Method: CM_GetChiefEngineer
	// Description
	//   return Chief Enginner name to the caller
	//
	// Parameters
	// $0 : $vChiefEngineer_s : (A100)
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(3/28/2007 11:34:41)
	Mods_2007_CM07
End if 
C_TEXT:C284($0; $vChiefEngineer_s)  // Command Replaced was o_C_STRING length was 100

GetChiefEngineer
$vChiefEngineer_s:=vChiefEngineer
$0:=$vChiefEngineer_s