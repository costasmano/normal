
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 14:34:15
//----------------------------------------------------
//Method: Object Method: [LSS_UtResult].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 14:34:17)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
End if 
LSS_UpdateMany_B:=True:C214
LogDeletion(->[LSS_UtResult:176]LSS_UTResultId_s:1; ->[LSS_UtResult:176]LSS_UTResultId_s:1; ->[LSS_UtResult:176]LSS_UTResultId_s:1; 0)

//End Object Method: [LSS_UtResult].Input.bDelete

