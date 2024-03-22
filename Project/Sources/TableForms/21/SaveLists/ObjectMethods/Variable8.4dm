// ----------------------------------------------------
// Object Method: bDelTeam
// ----------------------------------------------------
// Description
// remove all in the processL:ists_atxt 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 11:39:49)
	Mods_2013_10
	//  `New to remove all in the processLists_atxt 
End if 

If (Size of array:C274(ProcessLists_atxt)>0)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274(ProcessLists_atxt))
		APPEND TO ARRAY:C911(AvailableLists_atxt; ProcessLists_atxt{1})
		DELETE FROM ARRAY:C228(ProcessLists_atxt; 1; 1)
		If (Check Box1=1)
			APPEND TO ARRAY:C911(AvailableListIDs_al; ProcessListIDS_al{1})
			DELETE FROM ARRAY:C228(ProcessListIDS_al; 1; 1)
		End if 
		
	End for 
	ProcessLists_atxt:=0
End if 
//End Object Method: bDelTeam