// ----------------------------------------------------
// Object Method: bQuery
// User name (OS): cjmiller
// Date and time: 10/23/07, 15:22:08
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5303  //r004 `10/23/07, 15:22:42`Make sure only real design contract  records displayed
End if 
QUERY:C277(Current form table:C627->)
QUERY SELECTION:C341([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1>0)

//End Object Method: bQuery