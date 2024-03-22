
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/11/12, 14:08:44
//----------------------------------------------------
//Method: Object Method: [LB_QueryTable].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/11/12 14:08:46)
End if 
CONFIRM:C162("Are you sure you want to delete this record ? Query: <"+[LB_QueryTable:147]QueryName_s:1+">")
If (OK=1)
	
	LogDeletion(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
	
	DELETE RECORD:C58([LB_QueryTable:147])
	CANCEL:C270
	
End if 

//End Object Method: [LB_QueryTable].Input.bDelete

