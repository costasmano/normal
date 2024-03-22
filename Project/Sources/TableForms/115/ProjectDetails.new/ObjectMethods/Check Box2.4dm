
// ----------------------------------------------------
// Object Method: PRJ_Chapter85_l
// User name (OS): cjmiller
// Date and time: 11/06/07, 12:36:58
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r006 `11/06/07, 12:37:03
	Mods_2009_06  //r002 `06/12/09, 13:47:16   `Merge PRJ Design Contract Changes
End if 

If (PRJ_Chapter85_l=1)
	[PRJ_ProjectDetails:115]PRJ_Chapter85_b:52:=True:C214
	PRJ_DEProjectFileNo_l:=0
	[PRJ_ProjectDetails:115]PF_FileID_l:3:=0
Else 
	[PRJ_ProjectDetails:115]PRJ_Chapter85_b:52:=False:C215
	
End if 
PRJ_SetChapter85Access
//End Object Method: PRJ_Chapter85_l
