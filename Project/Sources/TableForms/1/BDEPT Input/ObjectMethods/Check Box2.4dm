// ----------------------------------------------------
// Object Method: NonReplacementBin_l
// User name (OS): cjmiller
// Date and time: 04/14/08, 14:32:46
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v55  //r003 `04/14/08, 14:32:47 
	
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Clicked:K2:4)
	
	If (NonReplacementBin_l=1)
		ReplacementBin_l:=0
		OBJECT SET VISIBLE:C603(*; "Replacementbdept@"; False:C215)
		OBJECT SET ENABLED:C1123(ZZ8; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		PRJ_DEBridgeNo_s:=""
	Else 
		ReplacementBin_l:=1
		OBJECT SET ENABLED:C1123(ZZ8; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET VISIBLE:C603(*; "Replacementbdept@"; True:C214)
		PRJ_DEBridgeNo_s:=""
	End if 
	
End if 
//End Object Method: NonReplacementBin_l