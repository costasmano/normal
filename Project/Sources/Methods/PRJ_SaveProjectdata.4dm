//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SaveProjectdata
// User name (OS): cjmiller
// Date and time: 12/14/06, 16:34:06
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //05/03/07, 16:03:46`
	Mods_2021_03  //Fix so that changes on input form are updated on list box
	//Modified by: CJ (3/11/21 13:40:58)
End if 

PRJ_DetailsResetLBArrays("Modify")
//Make sure to create history of structural project manager
PRJ_SetProjectChangesMade(->[PRJ_ProjectDetails:115]; ->[PRJ_ProjectDetails:115]PRJ_ModifiedBy_s:46; ->[PRJ_ProjectDetails:115]PRJ_ModifiedTimeStamp_s:47; "val")

Case of 
	: (Old:C35([PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)=0)
	: (Old:C35([PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)#[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)
		QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=Old:C35([PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39))
		C_TEXT:C284($Name_txt)
		C_DATE:C307($Current_d)
		$Name_txt:=[Personnel:42]Last Name:5+", "+[Personnel:42]First Name:3
		$Current_d:=Current date:C33(*)
		CREATE RECORD:C68([PRJ_StrPrjManagerHistory:128])
		[PRJ_StrPrjManagerHistory:128]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
		[PRJ_StrPrjManagerHistory:128]SPMH_Replaced_d:3:=$Current_d
		[PRJ_StrPrjManagerHistory:128]SPMH_StructuralProjManager_txt:2:=$Name_txt
		SAVE RECORD:C53([PRJ_StrPrjManagerHistory:128])
		UNLOAD RECORD:C212([PRJ_StrPrjManagerHistory:128])
End case 
//End PRJ_SaveProjectdata