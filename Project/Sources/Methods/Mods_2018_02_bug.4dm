//%attributes = {"invisible":true}
// Method: Mods_2018_02_bug
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/15/18, 17:17:22
	// ----------------------------------------------------
	// First Release
	Mods_2018_02_bug
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(2/2/18)
// [Inspections];"PedBridge_p1"
//  `added missing  vYrRehab:=[Inspections]YrRehab

//**********`Modified by: Costas Manousakis-(Designer)-(2/15/18)
// Modified Method(s) : 
// SET_Item67
//  ``more fixes for load factor values in item66  - use <>SIA_LoadRtg_63_RF_txt to check on Item 65

//Move into Bug fix from development Due to changes in moving and dispolaying rating PDF forms
//Add code to allow for moving/copying rating reports to directory structure
//[Bridge MHD NBIS];"Bridge Input"//New button on Page 4
//SFA_GetAvailRatingRpts 
//OM_ControlOpenandMoveRatingPDF 
//Compiler_MoveRating 
//MR_CheckandResetDocumentLock
//OM_SetColoronForm 
//SFA_GetAvailRatingRpts 
//SIA_BridgeInpNavCTRL 
//ut_CheckRatingBDEPTandBIN 
//ut_CheckTownFolderNames 
//ut_ChkandRptRatingReportFolders 
//ut_MoveRatingsFromTownFolder 
//ut_ReturnServerIP 
//"RatingReportDisplayandMove"
//[Bridge MHD NBIS];"Bridge Input"

//Fix problem where duplicate structure numbers can be created
//Modified by: Chuck Miller (2/27/18 13:53:23)
//LSS_SetInventoryNumber
//Method: Object Method: [LSS_Inventory]."New_InventoryItem".LSS_Route_L
//Method: Object Method: [LSS_Inventory].Edit_SIN.LSS_RouteDesignation_atxt


//```
//```    **** End of Release 7.0.3 09-Mar-2018
//```
