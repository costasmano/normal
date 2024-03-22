// ----------------------------------------------------
// Object Method: bAddTeam
// ----------------------------------------------------
// Description
// add all in availableLists_atxt
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 11:39:49)
	Mods_2013_10
	//  `New to add all available 
End if 
If (Size of array:C274(AvailableLists_atxt)>0)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274(AvailableLists_atxt))
		APPEND TO ARRAY:C911(ProcessLists_atxt; AvailableLists_atxt{1})
		DELETE FROM ARRAY:C228(AvailableLists_atxt; 1; 1)
		If (Check Box1=1)
			APPEND TO ARRAY:C911(ProcessListIDS_al; AvailableListIDs_al{1})
			DELETE FROM ARRAY:C228(AvailableListIDs_al; 1; 1)
		End if 
		
	End for 
	AvailableLists_atxt:=0
End if 
//End Object Method: bAddTeam