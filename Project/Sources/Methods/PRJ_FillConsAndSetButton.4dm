//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_FillConsAndSetButton
// User name (OS): charlesmiller
// Date and time: 04/29/09, 12:08:35
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/29/09, 12:08:37 `PRJ Design Contract Changes
	Mods_2009_05  //r001  `05/07/09, 12:31:46  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 13:47:16   `Merge PRJ Design Contract Changes
End if 
C_LONGINT:C283($1; $ConsultantIDToUse_l; $Loc_l)
$ConsultantIDToUse_l:=$1
$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)
If ($Loc_l>0)
	PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
End if 
If ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53=0)
	OBJECT SET TITLE:C194(PRJ_SelectConsultant_l; "Override Consultant")
Else 
	OBJECT SET TITLE:C194(PRJ_SelectConsultant_l; "Remove Override")
End if 
//End PRJ_FillConsAndSetButton