//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJCreateDCPFJoinRecord
// User name (OS): charlesmiller
// Date and time: 04/29/09, 10:56:37
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 pointer to combined key
//$2 pointer to DC_DesignProjectID_l
//$3 pointer to File ID
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/29/09, 10:56:39 `PRJ Design Contract Changes
	Mods_2009_06  //r002 `06/11/09, 13:23:10   `Merge PRJ Design Contract Changes
End if 
C_POINTER:C301($1; $2; $3; $CombinedKey_ptr; $DCProjectID_ptr; $PFFileID_ptr)
$CombinedKey_ptr:=$1
$DCProjectID_ptr:=$2
$PFFileID_ptr:=$3
CREATE RECORD:C68([PRJ_DCPFJoin:135])
[PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1:=$CombinedKey_ptr->
[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2:=$DCProjectID_ptr->
[PRJ_DCPFJoin:135]PF_FileID_l:3:=$PFFileID_ptr->
SAVE RECORD:C53([PRJ_DCPFJoin:135])
UNLOAD RECORD:C212([PRJ_DCPFJoin:135])
//End ut_PRJCreateDCPFJoinRecord