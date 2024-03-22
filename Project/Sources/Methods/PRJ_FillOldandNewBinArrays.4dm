//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_FillOldandNewBinArrays
// User name (OS): cjmiller
// Date and time: 04/22/08, 13:05:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r004 `04/22/08, 13:05:27     
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
USE SET:C118("OldBinSet")
ARRAY LONGINT:C221(PRJ_ExstSelectedBinGroup_al; 0)
ARRAY TEXT:C222($BDepts_atxt; 0)
ARRAY TEXT:C222($Bins_as; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_ExstSelectedBinRecordNos_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6; PRJ_ExstSelectedBinGroup_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3; $BDepts_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $Bins_as)
ARRAY TEXT:C222(PRJ_ExistSelectedBins_atxt; 0)
ARRAY TEXT:C222(PRJ_ExistSelectedBins_atxt; Size of array:C274($Bins_as))
C_LONGINT:C283($Loop_l)
C_TEXT:C284($Group_s)
For ($Loop_l; 1; Size of array:C274($Bins_as))
	$Group_s:=String:C10(PRJ_ExstSelectedBinGroup_al{$Loop_l}; "G ##0")
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$Bins_as{$Loop_l})
	PRJ_ExistSelectedBins_atxt{$Loop_l}:=$Group_s+"-"+[Bridge MHD NBIS:1]BIN:3+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+"("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
End for 

USE SET:C118("NewBinSet")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
ARRAY TEXT:C222($QueryString_as; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $QueryString_as)
QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $QueryString_as)
SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_NewSelectedBinRecordNos_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6; PRJ_NewSelectedBinGroup_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3; $BDepts_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $Bins_as)
ARRAY TEXT:C222(PRJ_NewSelectedBins_atxt; 0)
ARRAY TEXT:C222(PRJ_NewSelectedBins_atxt; Size of array:C274($Bins_as))

For ($Loop_l; 1; Size of array:C274($Bins_as))
	
	$Group_s:=String:C10(PRJ_NewSelectedBinGroup_al{$Loop_l}; "G ##0")
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$Bins_as{$Loop_l})
	PRJ_NewSelectedBins_atxt{$Loop_l}:=$Group_s+"-"+[Bridge MHD NBIS:1]BIN:3+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+" ("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
End for 

//End PRJ_FillOldandNewBinArrays