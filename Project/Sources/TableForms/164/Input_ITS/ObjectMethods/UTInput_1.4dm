
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 06/16/15, 15:00:52
// ----------------------------------------------------
// Method: Object Method: [LSS_Inspection].Input_ITS.LSS_UTPicture_pct 
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(9/17/15 12:47:43)
	Mods_2015_09_bug
	//  `drag and drop
	
End if 

C_LONGINT:C283($0)

$0:=LSS_SaveDMorUTPicture(->LSS_UTPicture_pct)

//End Method: Object Method: [LSS_Inspection].Input_Signal.LSS_UTPicture_pct