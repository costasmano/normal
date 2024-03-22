//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ProcessAvailable
// User name (OS): cjmiller
// Date and time: 06/02/08, 13:30:37
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r010 `06/02/08, 13:30:38     
End if 
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274(PRJ_AvailableBinRecordNos_al))
	
	If (PRJ_AvailableBinRecordNos_al{$Loop_l}>=0)
		GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_AvailableBinRecordNos_al{$Loop_l})
		ut_LoadRecord(->[PRJ_ProjectDetailsIncludedBINS:122])
		DELETE RECORD:C58([PRJ_ProjectDetailsIncludedBINS:122])
		ProjectChangesMade_b:=True:C214
	End if 
	
End for 
//End PRJ_ProcessAvailable