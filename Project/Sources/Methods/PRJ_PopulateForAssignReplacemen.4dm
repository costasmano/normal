//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_PopulateForAssignReplacemen
// User name (OS): cjmiller
// Date and time: 06/24/08, 12:01:57
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v56  //r001 `06/24/08, 12:01:58   `Add alternate function number for PAs use      
End if 
PRJ_SetUpUnasssignedBins("Unass")
SET QUERY DESTINATION:C396(Into set:K19:2; "IncludedBinSet")
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6>0)

USE SET:C118("IncludedBinSet")
SET QUERY DESTINATION:C396(Into set:K19:2; "OldBinSet")
QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=False:C215)
USE SET:C118("IncludedBinSet")
SET QUERY DESTINATION:C396(Into set:K19:2; "NewBinSet")
QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=True:C214)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

PRJ_FillOldandNewBinArrays
//End PRJ_PopulateForAssignReplacemen