
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/31/15, 16:55:18
//----------------------------------------------------
//Method: Object Method: [LSS_DMeter].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 16:55:45)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
End if 
LSS_UpdateMany_B:=True:C214
LogDeletion(->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; 0)

//End Object Method: [LSS_DMeter].Input.bDelete

