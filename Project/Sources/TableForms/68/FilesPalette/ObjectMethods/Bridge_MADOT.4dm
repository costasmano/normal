If (False:C215)
	//Script: bMBTA  [Dialogs];"FilesPalette"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Launches a process showing all bridge records.
	
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modified for MHD BMS by Tom Nee.
	<>fT_Nee:=False:C215
	// Modified by: Costas Manousakis-(Designer)-(2023-01-12 16:14:22)
	Mods_2023_01_bug
	//  `change process name to MassDOT
End if 
C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("P_MHD"; <>LStackSize; "MassDOT"; True:C214; False:C215)