// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 03/09/06, 10:49:08
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($Loop_l)


For ($Loop_l; 1; Size of array:C274(PRJ_AvailableBinRecordNos_al))
	
	If (PRJ_AvailableBinRecordNos_al{$Loop_l}>=0)
		GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_AvailableBinRecordNos_al{$Loop_l})
		DELETE RECORD:C58([PRJ_ProjectDetailsIncludedBINS:122])
		ProjectChangesMade_b:=True:C214
	End if 
	
End for 
C_TEXT:C284($BDept_s)  // Command Replaced was o_C_STRING length was 6
$BDept_s:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
For ($Loop_l; 1; Size of array:C274(PRJ_NewSelectedBinRecordNos_al))
	If (PRJ_NewSelectedBinRecordNos_al{$Loop_l}<0)
		ProjectChangesMade_b:=True:C214
		
		CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=$BDept_s
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=Substring:C12(PRJ_NewSelectedBins_atxt{$Loop_l}; 1; 3)
		[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
		
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=True:C214
		
	Else 
		GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_NewSelectedBinRecordNos_al{$Loop_l})
		ut_LoadRecord(->[PRJ_ProjectDetailsIncludedBINS:122])
		Case of 
			: (Not:C34([PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4))
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=True:C214
				ProjectChangesMade_b:=True:C214
				
			: ([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2#Substring:C12(PRJ_ExistSelectedBins_atxt{$Loop_l}; 1; 3))
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=Substring:C12(PRJ_ExistSelectedBins_atxt{$Loop_l}; 1; 3)
				ProjectChangesMade_b:=True:C214
				
		End case 
		
	End if 
	SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
	UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
End for 
For ($Loop_l; 1; Size of array:C274(PRJ_ExstSelectedBinRecordNos_al))
	If (PRJ_ExstSelectedBinRecordNos_al{$Loop_l}<0)
		ProjectChangesMade_b:=True:C214
		
		CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=$BDept_s
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=Substring:C12(PRJ_ExistSelectedBins_atxt{$Loop_l}; 1; 3)
		[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
		
	Else 
		GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_ExstSelectedBinRecordNos_al{$Loop_l})
		ut_LoadRecord(->[PRJ_ProjectDetailsIncludedBINS:122])
		Case of 
			: ([PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4)
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
				ProjectChangesMade_b:=True:C214
				
			: ([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2#Substring:C12(PRJ_ExistSelectedBins_atxt{$Loop_l}; 1; 3))
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=Substring:C12(PRJ_ExistSelectedBins_atxt{$Loop_l}; 1; 3)
				ProjectChangesMade_b:=True:C214
				
		End case 
		
	End if 
	SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
	UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
End for 


CANCEL:C270
//End Object Method: Button1