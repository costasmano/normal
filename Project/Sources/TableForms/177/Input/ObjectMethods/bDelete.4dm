
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/08/15, 17:03:31
//----------------------------------------------------
//Method: Object Method: [LSS_VerticalClearance].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/14/15 15:53:01)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
End if 
LSS_UpdateMany_B:=True:C214
LogDeletion(->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; ->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; ->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; 0)

//End Object Method: [LSS_VerticalClearance].Input.bDelete

