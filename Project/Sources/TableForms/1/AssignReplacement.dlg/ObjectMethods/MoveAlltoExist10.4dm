// ----------------------------------------------------
// Object Method:  Move_l
// User name (OS): cjmiller
// Date and time: 04/27/06, 11:44:59
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Copied to Server on : 06/25/08, 12:04:04
	Mods_2011_06  // CJ Miller`06/20/11, 10:36:39      ` Type all local variables for v11
End if 
If (Position:C15("Replacement@"; GroupDD_as{GroupDD_as})>0)
	
	If (Size of array:C274(PRJ_UnassignedBins_atxt)>0)
		C_LONGINT:C283($Loop_l)
		For ($Loop_l; Size of array:C274(PRJ_UnassignedBins_atxt); 1; 1)
			If (PRJ_UnassignedBinGroup_al{$Loop_l}=0)
				PRJ_UnassignedBins_atxt:=$Loop_l
				PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al; ->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al)
			End if 
		End for 
	End if 
Else 
	ALERT:C41("You must select a group before moving bins")
End if 
//End Object Method:  Move_l