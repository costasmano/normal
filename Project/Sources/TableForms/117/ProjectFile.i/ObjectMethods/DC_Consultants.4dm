// ----------------------------------------------------
// Object Method: PRJConsultantHList_l
// User name (OS): cjmiller
// Date and time: 03/03/06, 12:00:45
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2009_05  //r001  `05/08/09, 14:38:41  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//[PRJ_ProjectFile]DC_DesignContractID_l to [PRJ_ProjectDetails]DC_DesignContractID_l
	Mods_2009_06  //r002 `06/11/09, 14:05:19   `Merge PRJ Design Contract Changes
End if 
POPUP_HL_MENUC(PRJ_ConsultantHList_l; ->[PRJ_DesignContracts:123]ConsultantNameID_l:2)
QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltAddressID:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
DC_ConsultantName_txt:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
[PRJ_ProjectFile:117]PF_FileNumber_l:3:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
//End Object Method: PRJConsultantHList_l