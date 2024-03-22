// ----------------------------------------------------
// Object Method: PRJ_RemovePF_l
// User name (OS): root
// Date and time: 10/30/07, 13:47:48
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r004 `10/30/07, 13:47:50
	Mods_2007_CJM_v5302  //r006 `11/06/07, 10:34:19
End if 
CONFIRM:C162("Are you sure you want to remove the assigned File Number "+String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3); "Yes"; "No")
If (OK=1)
	[PRJ_ProjectDetails:115]PF_FileID_l:3:=0
	PRJ_DEProjectFileNo_l:=0
	PRJ_LoadProjectFileData
	PRJ_LoadPage_0
	PRJ_ControlPageMovement
	OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; True:C214)
	OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Editable)
	OBJECT SET VISIBLE:C603(*; "PRJ_ProjectFileButton"; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_RemovePF_l; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_SelectConsultant_l; False:C215)
End if 
//End Object Method: PRJ_RemovePF_l