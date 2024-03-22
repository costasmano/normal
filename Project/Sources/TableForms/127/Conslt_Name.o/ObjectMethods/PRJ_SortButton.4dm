// ----------------------------------------------------
// Object Method: PRJ_Type_l
// User name (OS): cjmiller
// Date and time: 01/10/06, 11:48:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
SET CURSOR:C469(4)
If (SortColumn1_l=0) | (SortColumn1_l=2)
	SortColumn1_l:=1
	ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2; >)
Else 
	SortColumn1_l:=2
	ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2; <)
End if 
ut_SetSortColumns(2; 1)
//End Object Method: PRJ_Type_l