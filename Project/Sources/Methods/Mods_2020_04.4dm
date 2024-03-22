//%attributes = {"invisible":true}
//Method: Mods_2020_04
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/01/20, 09:22:22
	// ----------------------------------------------------
	//Created : 
	Mods_2020_04
End if 
//

// ControlMenuBar
//  `added new item in Special menu of Bridgelistmenu to load SU EV loads
// G_SortTable_new
//  `stop placing the list of tables and fields in the pasteboard
// RatRep_LoadSU_EV_data
//  `added confirm before processing the clipboard

//QR_ReturnPhotoType 
// changed param 1 from pointer to picture

//**********`Modified by: Costas Manousakis-(Designer)-(4/15/20)
// P_ListTownAddress
//  `switch back to old output form
// P_ListConsAddress
//  `switched back to old output form

// Modified Forms : 
// [Town Address];"View Town Address"
//  `more adjustments in form layout. changed report button to toolbar btn with menu and allow alt click

// [Town Address];"View Town Address".Report
//  `added alt click option to bring up quick report editor
// M_SearchTownAddress
//  `Use center_window_2

// [Conslt Address];"View Conslt Address"
//  `adjustments in layout for better display, changed report button to allow alt click
// [Conslt Address];"View Conslt Address".Report
//  `added alt click option to bring up quick report editor
// M_SearchConsltAddress
//  `use Center_window_2

//**********`Modified by: Costas Manousakis-(Designer)-(4/17/20)
// [Bridge MHD NBIS];"NewMBTANBIS_StackInfo".NBISStack_LB
//  `adjustments in the on header click to capture the current sort and fix the milepoint sort.

// Modified Forms : 
// [Bridge MHD NBIS];"NewNBIS_StackInfo"
//  `enabled on header click on Bridge Listbox to capture sorts

// [Bridge MHD NBIS];"NewNBIS_StackInfo".NBISStack_LB
//  `use on header click to capture the sort for use in the search, select button methods

// ut_HFS_to_POSIX
//  `fixed to use Convert path system to POSIX and then escape other characters.
//  `the : is escaped because Convert changes / to : , ex 4/17/20 -> 4:17:20
//  `/Volumes/ does not need to be prefixed to the result  CallReference #709

// GetTownAddress
//  `Use a Query by formula to search for the town address to strip City of and Town of

//**********`Modified by: Costas Manousakis-(Designer)-(4/27/20)
// G_Insp_ApplyLineSpacing
//  `don't do any adjustments if there is nothing in the document ($vlEndSel=0)
//  `addresses CallReference #710


//ut_ReturnBackupInfo
//Modified to make sure no errors occur whn running on a test platform
//Modified by: Chuck (4/28/20 15:47:59)

//ut_NewSaveMethod
//Modified so that if BOX not found export is skipped
//Modified by: Chuck (4/28/20 16:06:56)

//**********`Modified by: Costas Manousakis-(Designer)-(4/30/20)
// Modified Forms : 
// [LSS_Inventory];"ListBoxOutput"
//  `minor adjustments in pos of listbox, buttons to center them, and allow hor. line to grow.
// [LSS_Inspection];"StructureDamageMoreMembers"
//  `fixed size of labels for Previous , present, deficiencies
// Modified Object Methods : 
// [Bridge MHD NBIS];"Bridge Input".InvExport
//  `added the BDEPT_BIN in the name of export file
// INSP_ImportInventoryPhotos
//  `added Set channel(11) at the end to close the file

// Modified Method(s) : 
// INSP_ImportInventoryPhotos
//  `added Set channel(11) at the end to close the file
//  `Added BIN to the fields to skip for the Inspection - use LogLink for TM and TL if not zero
//  `Added InvPhotInspID to fields to skip for the photos

// INSP_DuplicateInventoryPhotos
//  `when duplicating use LogLink for TL and TM if they are not zero
//  `also do not log the BIN

// NTI_ApplyImageSort
//  `added the missing test when called from LSS_Inspection forms
//  `added setting of LSS_PhotoUpdateSeq_b for LSS

// INSP_MoveImages
//  `added setting of LSS_PhotoUpdateSeq_b for LSS

// FM_SaveInspection
//  `execute the image sorting method in the subform.
// LSS_GotToInspectionPage
//  `execute the image sorting method in the subform. - only if LSS_PhotoUpdateSeq_b is true

// Modified Forms : 
// [LSS_Photos];"PhotoSubFormLB"
//  `adjusted size of + , warning msg and apply button to fit new text in warning that move to another tab also saves.

// BinRequestDisplayandMove
//  `add the date and time to $NewName_ instead of using the name of the upload file.

//End Mods_2020_04