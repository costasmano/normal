//%attributes = {"invisible":true}
//Method: Mods_2016_04_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/01/16, 16:39:18
	// ----------------------------------------------------
	//Created : 
	Mods_2016_04_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(4/1/16)
// Modified Method(s) : 
//INSP_ImportInspection
//  `added code to unload records from all tables loaded
//G_Insp_ApproveReject_new
//  `added ut_UnloadAllTables - need twice - one to set arrays - one to unload tables

//**********`Modified by: Costas Manousakis-(Designer)-(4/3/16)
// Created Method(s) : 
//Method: NTI_ut_LoadDEFS
//Description
//load definitions for NTI elements from a spreadsheet saved in xml format supplied by
//J Rigney.
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(4/4/16)
//ut_FixFileIDRes_pt2
//  `removed all alerts/confirms

//**********`Modified by: Costas Manousakis-(Designer)-(4/7/16)
// Created Form(s) : 
//Form : [LSS_Inspection];"Print_DMeter1"
//  `copy from Print_DMeter  to allow entry for Notes

//**********`Modified by: Costas Manousakis-(Designer)-(4/11/16)
// Modified Method(s) : 
//P_ReviewChanges 
//P_ReviewLogged 
//  `Change params to modify selection/display selection to display in list even a single record

// Modified Method(s) : 
//ut_SQLReturnActLogRecords 
//  `Removed  scanning for district 6 inspections, inv inspection, etc. when doing District 4

// Modified Menubar(s) : 
//BridgeList Menubar (2)
//  `Removed Item "Create BIN Remotely" from Menu "Records"

// Modified Method(s) : 
//SIA_CustomQRBtn_OM 
//  `added Pon_elem_insp, [TunnelInspection]

// Created Method(s) : 
//Test_SearchNBEs

// Modified Method(s) : 
//G_CloseAllTables
//  `Added check for table number valid

//**********`Modified by: Costas Manousakis-(Designer)-(4/12/16)
// Modified Table(s) : 
//[Bridge MHD NBIS]InspRequired
//  `Made field visible for searching and reporting

//**********`Modified by: Costas Manousakis-(Designer)-(4/13/16)
// Modified Form Methods : 
//Form Method: [Town Address];"View Town Address"
//  `disable the add button except on the Boston server and with write access OR design user

//**********`Modified by: Costas Manousakis-(Designer)-(4/14/16)
// Modified Method(s) : 
//WRUTIL_Function
//  `Added code in "CLEANCHARS" to address "?"  which could be a foot or inch mark - look in the styled text last two bytes

// Modified Forms : 
//[Inspections];"RailRoutinePrPg1"
//[Inspections];"RailRoutinePrPg2"
//  `Modified to show Dive ratings

//**********`Modified by: Costas Manousakis-(Designer)-(4/20/16)
// Modified Method(s) : 
//F_CompressPic
//  `replaced call to compress picture with Convert Picture ( this does not use quality parameter)
//  `compress picture used Quicktime

// Created Method(s) : 
//Method: ut_FitPrintFormObjectbyName
//Description
// Fit a printed object on a form specifiec by the object name.
// start with current font size down to a minimum font.

// Modified Forms : 
//Method: Form Method: [LSS_Inspection];"Print_DMeter"
//  `copy from Print_DMeter  to allow entry for Notes -added code to fit the Skech Notes

// Created Method(s) : 
//Method: LSS_SetDefDMeterNotes
//  `Description
//  ` set the Default D Meter notes

//Method: LSS_EditDMeterSketchNotes
//Description
//  ` Edit the Notes for the D-Meter Sketch

//Method: LSS_PreviewDMeter
//Description
//  ` Preview the D-Meter Page

// Modified Forms :
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"
//  `added buttons on D-Meter page to edit Dmeter sketch notes and do a preview of the dmeter page.

// Modified Method(s) : 
//LSS_PrintDMeter 
//  `added call to LSS_SetDefDMeterNotes to make sure we have the  sketch notes as needed

// Modified Method(s) : 
//COMPILER_Utilities
//  `added ut_FitPrintFormObject , ut_OpenNewWindow, ut_FitPrintFormObjectbyName
//dev_convertPicLibToJPEG
//  `added 6662, 10383, 10396

//**********`Modified by: Costas Manousakis-(Designer)-(4/21/16)
//****  NTI (National Tunnel Inspection Elements 
// Created Table(s) : 
//[NTI_ELEM_DEFS]
//[NTI_ELEM_BIN_INSP]
//[TIN_Inspections]
//[NTI_ELEM_TIN_INSP]
// Created Form(s) : 
//[NTI_ELEM_BIN_INSP];"Input"
//[NTI_ELEM_BIN_INSP];"Print"
//[NTI_ELEM_BIN_INSP];"PrintField"

// Created Method(s) : 
//NTI_@@
//**** END *** NTI (National Tunnel Inspection Elements 


//**********`Modified by: Costas Manousakis-(Designer)-(4/25/16)
// Modified Forms : 
//[Activity Log];"Print"
//  `changed font of data to Arial6

// Created Method(s) : 
//Method: ut_DOM_GetElementIndex
//Description
// find the index in a DOM tree of an element
// Parameters
// $0 : $Index_L
// $1 : $DomTree_txt
// $2 : $ElementPath_txt
// $3 : $FindElemValue_L

//**********`Modified by: Costas Manousakis-(Designer)-(4/27/16)
// Modified Method(s) : 
//COMPILER_XMLUtils
//  `add ut_DOM_GetElementIndex

//**********`Modified by: Costas Manousakis-(Designer)-(4/29/16)
// Modified Method(s) : 
//ut_UpdateorCreatePhotoRecord
//  `fixed length of var $key_s to match the id field


//End Mods_2016_04_bug