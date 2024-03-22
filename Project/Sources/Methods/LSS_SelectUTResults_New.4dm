//%attributes = {"invisible":true}
//Method: LSS_SelectUTResults_New
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/01/20, 12:21:26
	// ----------------------------------------------------
	//Created : 
	Mods_2020_09
End if 
//
QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=[LSS_UT:175]LSS_UTId_s:1)

LSS_SortUTResults

COPY NAMED SELECTION:C331([LSS_UtResult:176]; "UTResults_LB")

OBJECT SET VISIBLE:C603(*; "PlusButton_UTResults"; LSS_AllowInspectionEdit_B)
OBJECT SET ENABLED:C1123(*; "PlusButton_UTResults"; LSS_AllowInspectionEdit_B)

REDRAW:C174(UTResults_LB)
//End LSS_SelectUTResults_New