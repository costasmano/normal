//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ProcessUnassigned
// User name (OS): cjmiller
// Date and time: 06/02/08, 13:31:54
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r010 `06/02/08, 13:31:56    
	// Modified by: costasmanousakis-(Designer)-(9/20/10 17:58:34)
	Mods_2010_09
	//  `If record being added is a DES record make NEWBIN_b=true , move to Group 1
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($BDept_s)  // Command Replaced was o_C_STRING length was 6
C_LONGINT:C283($Loop_l)
$BDept_s:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
C_TEXT:C284($Bin_s; $Des_s)  // Command Replaced was o_C_STRING length was 3
For ($Loop_l; 1; Size of array:C274(PRJ_UnassignedBins_atxt))
	$Bin_s:=Substring:C12(PRJ_UnassignedBins_atxt{$Loop_l}; 7; 3)
	$Des_s:=Substring:C12(PRJ_UnassignedBins_atxt{$Loop_l}; (Length:C16(PRJ_UnassignedBins_atxt{$Loop_l})-3); 3)
	If (PRJ_UnassignedBinRecordNos_al{$Loop_l}<0)
		CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=$BDept_s
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=$Bin_s
		[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
		If ($Des_s="DES")
			[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=True:C214
			[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=1
		Else 
			[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
		End if 
		
		ProjectChangesMade_b:=True:C214
		SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
		UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
	Else 
		GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_UnassignedBinRecordNos_al{$Loop_l})
		ut_LoadRecord(->[PRJ_ProjectDetailsIncludedBINS:122])
		If ([PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6#0)
			ProjectChangesMade_b:=True:C214
			[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=0
			SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
			UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
		End if 
	End if 
	
End for 
//End PRJ_ProcessUnassigned