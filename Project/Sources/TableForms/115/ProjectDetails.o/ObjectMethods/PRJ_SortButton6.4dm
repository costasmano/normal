// ----------------------------------------------------
// Object Method: SortColumn7_l
// User name (OS): cjmiller
// Date and time: 01/10/06, 11:50:46
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
SET CURSOR:C469(4)
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; $RecordNumber_al; [PRJ_ProjectDetails:115]PRJ_Status_s:35; $LastAction_txt)
If (SortColumn7_l=0) | (SortColumn7_l=2)
	SortColumn7_l:=1
	SORT ARRAY:C229($LastAction_txt; $RecordNumber_al; >)
	//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_LastActionDescription_txt;>)
Else 
	SortColumn7_l:=2
	SORT ARRAY:C229($LastAction_txt; $RecordNumber_al; <)
	//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_LastActionDescription_txt;<)
End if 
CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; $RecordNumber_al; "SortedProjects")
USE NAMED SELECTION:C332("SortedProjects")
CLEAR NAMED SELECTION:C333("SortedProjects")
ARRAY LONGINT:C221($RecordNumber_al; 0)
ARRAY TEXT:C222($LastAction_txt; 0)
ut_SetSortColumns(7; 7)

//End Object Method: SortColumn7_l