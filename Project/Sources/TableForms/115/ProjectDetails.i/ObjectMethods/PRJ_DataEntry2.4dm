// ----------------------------------------------------
// Object Method: PRJ_CityOrTown_s
// User name (OS): cjmiller
// Date and time: 10/09/07, 10:40:36
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r003 `10/09/07, 10:40:38
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:16:10`Fix to use chapter 85 booloean
	// Modified by: costasmanousakis-(Designer)-(11/19/07 10:13:16)
	Mods_2007_CM_5401
End if 
If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
	GOTO OBJECT:C206(PRJ_ConsultantName_txt)
Else 
	GOTO OBJECT:C206(PRJ_DEProjectFileNo_l)
End if 
//End Object Method: PRJ_CityOrTown_s