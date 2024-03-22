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
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (Size of array:C274(PRJ_AvailableBins_atxt)>0)
	MoveExisting_l:=0
	C_LONGINT:C283($Loop_l)
	
	For ($Loop_l; Size of array:C274(PRJ_AvailableBins_atxt); 1; 1)
		PRJ_AvailableBins_atxt:=$Loop_l
		PRJ_MoveToSelected(->PRJ_NewSelectedBins_atxt; ->PRJ_NewSelectedBinRecordNos_al)
	End for 
End if 
//End Object Method:  Move_l