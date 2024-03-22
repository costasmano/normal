//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetUpUnasssignedBins
// User name (OS): cjmiller
// Date and time: 05/27/08, 10:56:52
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v55  //r009 `05/27/08, 10:56:54     
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $Subtitle_txt)
$Subtitle_txt:=$1
SET QUERY DESTINATION:C396(Into set:K19:2; "IncludedBinSet")
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6=0)
USE SET:C118("IncludedBinSet")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_LONGINT:C283($Count_l; $Loop_l)
ARRAY LONGINT:C221(PRJ_UnassignedBinRecordNos_al; 0)
ARRAY LONGINT:C221(PRJ_UnassignedBinGroup_al; 0)

SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_UnassignedBinRecordNos_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6; PRJ_UnassignedBinGroup_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $Bins_as)
ARRAY TEXT:C222(GroupDD_as; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(PRJ_UnassignedBins_atxt; Size of array:C274($Bins_as))
C_TEXT:C284($Group_s)  // Command Replaced was o_C_STRING length was 5

For ($Loop_l; 1; Size of array:C274($Bins_as))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$Bins_as{$Loop_l})
	
	$Group_s:=$Subtitle_txt
	
	PRJ_UnassignedBins_atxt{$Loop_l}:=$Group_s+"-"+$Bins_as{$Loop_l}+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+"("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
End for 
CLEAR SET:C117("IncludedBinSet")
//End PRJ_SetUpUnasssignedBins