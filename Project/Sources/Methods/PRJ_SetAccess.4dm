//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetAccess
// User name (OS): cjmiller
// Date and time: 05/16/07, 11:42:14
// ----------------------------------------------------
// Description
// This method wil set access on layouts
//
// Parameters
//$1 "out for output forms, otherwise for input forms
//$2 group
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/16/07, 11:42:16 `Add code to control access 
	Mods_PRJSELECTION
	Mods_2007_CJM_v5303  //r004 `10/23/07, 14:37:39`Make sure designers can delete
	Mods_2007_CJM_v5303  //r004 `10/23/07, 16:10:40`Add code to allow for overide  consultant
End if 

OBJECT SET VISIBLE:C603(*; "bAdd@"; False:C215)
OBJECT SET VISIBLE:C603(*; "bDelete@"; False:C215)
OBJECT SET VISIBLE:C603(*; "PRJ_ToolList_atxt@"; False:C215)
OBJECT SET VISIBLE:C603(PRJ_SelectConsultant_l; False:C215)
OBJECT SET VISIBLE:C603(PRJ_RemovePF_l; False:C215)
If (GRP_4DUIDinGroup(<>CurrentUser_UID; "PRJ_ToolAccess")=1) | (User in group:C338(Current user:C182; "Design Access Group"))
	OBJECT SET VISIBLE:C603(PRJ_RemovePF_l; True:C214)
	OBJECT SET VISIBLE:C603(*; "PRJ_ToolList_atxt@"; True:C214)
End if 
If (GRP_4DUIDinGroup(<>CurrentUser_UID; "Struct Proj Managers")=1)
	OBJECT SET VISIBLE:C603(*; "PRJ_ToolList_atxt@"; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_SelectConsultant_l; True:C214)
End if 
If (GRP_4DUIDinGroup(<>CurrentUser_UID; "PRJ_CreateGroup")=1) | (User in group:C338(Current user:C182; "Design Access Group"))
	OBJECT SET VISIBLE:C603(*; "bAdd@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "bDelete@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "PRJ_ToolList_atxt@"; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_SelectConsultant_l; True:C214)
End if 
//End PRJ_SetAccess