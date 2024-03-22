// ----------------------------------------------------
// Object Method: bAddTeam
// User name (OS): charlesmiller
// Date and time: 05/23/11, 13:06:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_05  //r002 CJ Miller`05/23/11, 13:06:32      `Fix bugs found during testing of initial release of v11
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 11:38:42)
	Mods_2013_10
	//  `if  arraypos was at the end of the list reset it to the new end
End if 
If (AvailableLists_atxt>0)
	C_LONGINT:C283($ArrayPosition_l)
	$ArrayPosition_l:=AvailableLists_atxt
	APPEND TO ARRAY:C911(ProcessLists_atxt; AvailableLists_atxt{$ArrayPosition_l})
	DELETE FROM ARRAY:C228(AvailableLists_atxt; $ArrayPosition_l; 1)
	If (Check Box1=1)
		APPEND TO ARRAY:C911(ProcessListIDS_al; AvailableListIDs_al{$ArrayPosition_l})
		DELETE FROM ARRAY:C228(AvailableListIDs_al; $ArrayPosition_l; 1)
	End if 
	
	If ($ArrayPosition_l>Size of array:C274(AvailableLists_atxt))
		AvailableLists_atxt:=Size of array:C274(AvailableLists_atxt)
	End if 
	
End if 
//End Object Method: bAddTeam