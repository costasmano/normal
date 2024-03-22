//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ProcessExisting
// User name (OS): cjmiller
// Date and time: 06/02/08, 13:33:20
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r010 `06/02/08, 13:33:22   
	Mods_2011_06  // CJ Miller`06/14/11, 15:48:38      ` Type all local variables for v11
	//Fix bug where $BDept_s could be blank
	//[Bridge MHD NBIS];"AssignReplacement.dlg"
	//[PRJ_ProjectDetailsIncludedBINS];"BinSelectionwithnew.dlg"
End if 
C_TEXT:C284($1; $BDept_s)  // Command Replaced was o_C_STRING length was 6
$BDept_s:=$1
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274(PRJ_ExstSelectedBinRecordNos_al))
	If (PRJ_ExstSelectedBinRecordNos_al{$Loop_l}<0)
		ProjectChangesMade_b:=True:C214
		
		CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=$BDept_s
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=Substring:C12(PRJ_ExistSelectedBins_atxt{$Loop_l}; 7; 3)
		[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=PRJ_ExstSelectedBinGroup_al{$Loop_l}
		SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
		UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
	Else 
		GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_ExstSelectedBinRecordNos_al{$Loop_l})
		ut_LoadRecord(->[PRJ_ProjectDetailsIncludedBINS:122])
		If ([PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6#PRJ_ExstSelectedBinGroup_al{$Loop_l})
			ProjectChangesMade_b:=True:C214
			[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=PRJ_ExstSelectedBinGroup_al{$Loop_l}
			SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
			UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
		End if 
	End if 
End for 

//End PRJ_ProcessExisting