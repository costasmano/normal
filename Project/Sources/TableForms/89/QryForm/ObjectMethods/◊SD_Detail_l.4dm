// ----------------------------------------------------
// Object Method: ◊SD_Detail_l
// User name (OS): cjmiller
// Date and time: 05/03/05, 13:02:26
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03
End if 
If (<>SD_Detail_l=1)
	<>SD_SubTotalByOwner_l:=1
	OBJECT SET ENABLED:C1123(<>SD_SubTotalByOwner_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(<>SD_SubTotalByOwner_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 
//End Object Method: ◊SD_Detail_l