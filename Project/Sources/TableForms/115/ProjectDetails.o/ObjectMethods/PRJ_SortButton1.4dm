// ----------------------------------------------------
// Object Method: SortColumn2_l
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
If (SortColumn2_l=0) | (SortColumn2_l=2)
	SortColumn2_l:=1
	ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; >)
Else 
	SortColumn2_l:=2
	ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; <)
End if 
ut_SetSortColumns(7; 2)

//End Object Method: SortColumn2_l