
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
	Mods_2009_06  //r002 `06/12/09, 13:46:40   `Merge PRJ Design Contract Changes
End if 

If (PRJ_Chapter85_l=1)
	[PRJ_ProjectDetails:115]PRJ_Chapter85_b:52:=True:C214
	PRJ_DEProjectFileNo_l:=0
	[PRJ_ProjectDetails:115]PF_FileID_l:3:=0
Else 
	[PRJ_ProjectDetails:115]PRJ_Chapter85_b:52:=False:C215
	C_TEXT:C284($msg_txt)
	$msg_txt:="Are you sure you wish to change from Chapter 85 and select a new project file"+Char:C90(Carriage return:K15:38)
	$msg_txt:=$msg_txt+"Enter a new project file number."
	PRJ_DEProjectFileNo_l:=Num:C11(ut_Request($msg_txt; ->DummyField_txt; ""; "Proceed"; "Skip"))
	If (OK=1)
		PRJ_ControlSelectFileNumber
	Else 
		[PRJ_ProjectDetails:115]PRJ_Chapter85_b:52:=True:C214
		PRJ_Chapter85_l:=1
	End if 
	PRJ_SetChapter85Access
End if 
//End Object Method: PRJ_Chapter85_l
