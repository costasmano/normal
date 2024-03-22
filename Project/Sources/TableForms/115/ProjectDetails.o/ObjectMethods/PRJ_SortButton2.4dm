// ----------------------------------------------------
// Object Method: SortColumn3_l
// User name (OS): cjmiller
// Date and time: 01/10/06, 11:50:46
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5303  //r004 changed name of array PRJ_ConsultantName_atxt
	// Modified by: costasmanousakis-(Designer)-(1/10/08 08:41:38)
	Mods_2007_CM_5401  //Added the Override consultants
	Mods_2009_05  //r001  `05/07/09, 11:30:40  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 14:04:17   `Merge PRJ Design Contract Changes
End if 


SET CURSOR:C469(4)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
ARRAY LONGINT:C221($RecordNo_al; 0)
ARRAY LONGINT:C221($ConsultantIDs_al; 0)
ARRAY LONGINT:C221($ConsultantOverIDs_al; 0)
ARRAY TEXT:C222($Names_atxt; 0)
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; $RecordNo_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2; $ConsultantIDs_al; [PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53; $ConsultantOverIDs_al)

ARRAY TEXT:C222($Names_atxt; Size of array:C274($RecordNo_al))

C_LONGINT:C283($Loop_l; $Loc_l)
For ($Loop_l; 1; Size of array:C274($RecordNo_al))
	If ($ConsultantOverIDs_al{$Loop_l}>0)
		$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantOverIDs_al{$Loop_l})
	Else 
		$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDs_al{$Loop_l})
	End if 
	
	If ($Loc_l>0)
		$Names_atxt{$Loop_l}:=PRJ_ConsultantName_atxt{$Loc_l}
	End if 
End for 

ut_SetSortColumns(7; 3)
If ((SortColumn3_l=0) | (SortColumn3_l=2))
	SortColumn3_l:=1
	SORT ARRAY:C229($Names_atxt; $RecordNo_al; >)
Else 
	SORT ARRAY:C229($Names_atxt; $RecordNo_al; <)
	SortColumn3_l:=2
End if 

CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; $RecordNo_al; "SortedProjects")
USE NAMED SELECTION:C332("SortedProjects")
CLEAR NAMED SELECTION:C333("SortedProjects")
ARRAY LONGINT:C221($RecordNo_al; 0)
ARRAY LONGINT:C221($ConsultantIDs_al; 0)
ARRAY TEXT:C222($Names_atxt; 0)

ut_SetSortColumns(7; 3)

//End Object Method: SortColumn3_l