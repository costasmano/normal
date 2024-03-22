// ----------------------------------------------------
// Form Method: SelectFileFromPF
// User name (OS): charlesmiller
// Date and time: 05/14/09, 14:25:10
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r001  `05/14/09, 14:25:12  `r001  `05/07/09, 11:28:58  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 13:57:11   `Merge PRJ Design Contract Changes
End if 
If (Form event code:C388=On Load:K2:1)
	OBJECT SET VISIBLE:C603(*; "DC_Description"; False:C215)
End if 
//End Form Method: SelectFileFromPF