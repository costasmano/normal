//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_CreateNewIncludeBIN
// User name (OS): cjmiller
// Date and time: 06/30/08, 11:06:43
// ----------------------------------------------------
// Description
// 
//
// Parameters`
//$1 group number
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v56  //r004 `06/30/08, 11:06:45  ``Add code to create include bin record when not replacement
End if 
C_LONGINT:C283($1)  //group number

C_BOOLEAN:C305($NewBin_b)
$NewBin_b:=True:C214
If ($1=0)
	$NewBin_b:=False:C215
End if 
CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=$1
[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=[Bridge MHD NBIS:1]BDEPT:1
[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=NewBin_s
[PRJ_ProjectDetailsIncludedBINS:122]PDB_Date_d:5:=Current date:C33(*)
[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=$NewBin_b
[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])

//End PRJ_CreateNewIncludeBIN