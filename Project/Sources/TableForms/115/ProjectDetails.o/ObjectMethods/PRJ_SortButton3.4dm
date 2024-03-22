// ----------------------------------------------------
// Object Method: SortColumn4_l
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
If (SortColumn4_l=0) | (SortColumn4_l=2)
	SortColumn4_l:=1
	ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_FileNumber_l:3; >)
Else 
	SortColumn4_l:=2
	ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_FileNumber_l:3; <)
End if 

ut_SetSortColumns(7; 4)
//End Object Method: SortColumn4_l