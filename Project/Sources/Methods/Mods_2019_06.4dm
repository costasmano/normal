//%attributes = {"invisible":true}
//Method: Mods_2019_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/03/19, 17:35:07
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//


//**********`Modified by: Costas Manousakis-(Designer)-(6/3/19)
// Created Method(s) : 
//Method: RTGReport_ScannedRptURL
//Description
// returns a URL to open a scanned report found using method RTGReport_FindScanned 
// result can be used in an excel file to open the link
// Parameters
// $0 : $URL_txt
// $1 : $BDEPT
// $2 : $BIN
// $3 : $RatingReportDate_d


//Add code to make sure windows open and take into account 13" mac books
//Modified by: Chuck Miller (6/4/19 13:52:21)
//[LSS_Inspection];"Inspection_Template"
//[LSS_Inspection];"Input_Signal"
//Method: Form Method: [LSS_Inspection]Input_Signal

//[LSS_Inspection];"Input_Sign"
//Method: Form Method: [LSS_Inspection]Input_Sign

//[LSS_Inspection];"Input_Light"
//Method: Form Method: [LSS_Inspection]Input_Light

//[LSS_Inspection];"Input_ITS"
//Method: Form Method: [LSS_Inspection]Input_ITS
//LSS_SetInspInputFormHeight 
//m_ListInspReview
//m_ListInventory

//Add a new group called SingleSignOn. If user is in that group check for other logins and if found quit
//on startup

//Add code to allow for addition or replacement of a resource file on the server
//Compiler_MoveResources 
//Resource_control 
//Resource_Error 
//Resource_FolderStructure 
//Server_SaveDocToResourceFolder
//"SelectResources"
//  //Method: SelectResources.ResourceList
//  //Method: SelectResources.Button3
//  //Method: SelectResources.Button4

//Add remote key for table to alert if record locked

//ut_SQLSelectForLoad

//Modified by: Chuck Miller (6/6/19 16:47:23)


//Modified by: Chuck Miller (6/11/19 11:48:24)
//Add code to return create date and time and Mod date and time for last backup
//ut_ReturnBackupInfo

//**********`Modified by: Costas Manousakis-(Designer)-(6/12/19)
// [Bridge MHD NBIS];"Bridge Input".OpenInspButton
//  `Unload all records when inspection is found to have link problems.
// SIA_ControlDoubleClick
//  `Unload all records when inspection (bridge or tunnel) is found to have link problems.
// [Bridge MHD NBIS];"Bridge Input".Dupl Insp Button
//  `close all tables except the Bridge table when done

//**********`Modified by: Costas Manousakis-(Designer)-(6/17/19)
// Modified Forms : 
// [Bridge MHD NBIS];"Bridge Input"
//  `Enabled On Resize event on form

// Modified Method(s) : 
// SIA_BridgeInput_FM
//  `Enabled on Resize event on the [Bridge MHD NBIS];"Bridge Input" form and added code to redraw any listboxes on the current page



//Modify sql server retrieves to not use ODBC plugin but native 4D SQL
// Also replaced open window and update status with new progress bar component
//Modified by: Chuck Miller (6/18/19 11:13:10)

//Compiler_SQL 
//Compiler_SPRetrieve 
//Compiler_PRJ 
//PRJ_ReturnFileNumber 
//SQL_ClearArrays 
//SQL_Connect_New 
//SQL_Direct 
//SQL_Direct_ReturnArrays

//ut_PRJCntrlRetrieveOfAmounts 
//ut_PRJCtrlRetrieveProjectData 
//ut_PRJGetAEData 
//ut_PRJGetCPAmounts 
//ut_PRJNewFiscal 
//ut_PRJRetrieveAdDate 
//ut_PRJRetrieveAEData 
//ut_PRJRetrieveAttributes 
//ut_PRJRetrieveConstructionCont 
//ut_PRJRetrieveCPAmounts 
//ut_PRJRetrieveCPName 
//ut_PRJRetrieveDCAmounts 
//ut_PRJRetrieveDesignContracts 
//ut_PRJRetrieveModifiedProjects 
//ut_PRJRetrievePRJ_Bridge 
//ut_PRJRetrievePRJxrefs 
//ut_PRJRetrieveProjectEvents 
//ut_PRJRetrieveProjectFileData 
//ut_PRJRetrieveProjTypes 
//ut_PRJRetrieveVendorID 
//ut_PRJSetRetrieveDate
//ut_PRJGetCPAmounts



//Add new button to move scanned bin request form
//NBISStackInfo_FM
//Bridge_CopyBinRequest

//Utilities created as part of the above
//ut_MountVolume
//ut_ReturnMountIfMounted
//End Mods_2019_06