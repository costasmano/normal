// ----------------------------------------------------
// Object Method: bDelTeam
// User name (OS): charlesmiller
// Date and time: 05/23/11, 13:07:48
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_05  //r002 CJ Miller`05/23/11, 13:07:50      `Fix bugs found during testing of initial release of v11
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 11:38:42)
	Mods_2013_10
	//  `if  arraypos was at the end of the list reset it to the new end
End if 

If (ProcessLists_atxt>0)
	C_LONGINT:C283($ArrayPosition_l)
	$ArrayPosition_l:=ProcessLists_atxt
	APPEND TO ARRAY:C911(AvailableLists_atxt; ProcessLists_atxt{$ArrayPosition_l})
	DELETE FROM ARRAY:C228(ProcessLists_atxt; $ArrayPosition_l; 1)
	If (Check Box1=1)
		APPEND TO ARRAY:C911(AvailableListIDs_al; ProcessListIDS_al{$ArrayPosition_l})
		DELETE FROM ARRAY:C228(ProcessListIDS_al; $ArrayPosition_l; 1)
	End if 
	If ($ArrayPosition_l>Size of array:C274(ProcessLists_atxt))
		ProcessLists_atxt:=Size of array:C274(ProcessLists_atxt)
	End if 
End if 
//End Object Method: bDelTeam