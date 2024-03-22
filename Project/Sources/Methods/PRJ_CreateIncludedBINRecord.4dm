//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_CreateIncludedBINRecord
// User name (OS): cjmiller
// Date and time: 01/04/07, 15:04:55
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_TEXT:C284($1; $Bin_s)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($2; $BDEPT_s)  // Command Replaced was o_C_STRING length was 6
$Bin_s:=$1
$BDEPT_s:=$2
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=$Bin_s)

If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])=0)
	CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
	[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
	[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=$Bin_s
	[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=$BDEPT_s
	[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
	SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
	UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
End if 
//End PRJ_CreateIncludedBINRecord