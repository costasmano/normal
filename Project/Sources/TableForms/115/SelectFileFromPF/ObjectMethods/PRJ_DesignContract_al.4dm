// ----------------------------------------------------
// Object Method: PRJ_DesignContract_al
// User name (OS): charlesmiller
// Date and time: 05/14/09, 14:23:45
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r001  `05/14/09, 10:13:41  `r001  `05/07/09, 11:28:58  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
End if 

//End Object Method: PRJ_DesignContract_al

If (PRJ_DesignContract_al>1)
	QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=PRJ_DesignContract_al{PRJ_DesignContract_al})
	
	OBJECT SET VISIBLE:C603(*; "DC_Description"; True:C214)
Else 
	
	OBJECT SET VISIBLE:C603(*; "DC_Description"; False:C215)
End if 
//End Object Method: PRJ_FileNumbers_al