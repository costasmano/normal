//%attributes = {"invisible":true}
//Method: Mods_2012_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/02/12, 14:26:21
	// ----------------------------------------------------
	//Created : 
	Mods_2012_11
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(11/2/12)
// Modified Method(s) : 
//Duplicate_Inspection 
//  `Clear all review comments.
//G_AddElmtTxt2Area
//  `Declare vInspFontNumber and assign it only if > 0
//SCPOA_PhotoListBox_OM 
//  `Added updating of variable SCPOA_PhotoAttach_L after double-click
//SCPOA_Variables
//  `Moved update of SCPOA_PhotoAttach_L and SCPOA_DetourAttach_L after loading from the  data blob.
//SCPOA_InstCountMsrChkBoxes 
//  `Fixed problem with setting var SCPOA_InstCNT_L to value higher than 1; would cause checkboxes
//  `not to be printed.
//WRUTIL_Function 
//  `Added debug text copied to clipboard for design users in the CLEANCHARS code 

//[Bridge MHD NBIS];"BDEPT Input"
//  `Changed label from Replacement BDEPT to BDEPT being Replaced
//[Dialogs];"InspectConfig"
//  `Added page 2 for new method of setting the insp type - test ibkt for Design users

//[Conslt Rating];"Cslt Rating In"
//  `Re-arranged delete, save and cancel buttons to put more space between them
//[Cons Inspection];"Cslt Insp In"
//  `Re arranged nav, del, cancel, save buttons to allow more space between them 

// Modified Method(s) : 
//GetInspType 
//  ` New var INSP_SelectedNewInspType_txt set by page 2 of the [Dialogs];"InspectConfig" dialog

// Created Method(s) : 
//FHWA_InspReport 
//  ` Generate an fhwa frequency check report. Metric 6 of the FHWA review.

//INSP_InspTypesUtil 
//  ` Utility method
//  ` Parameters
//  ` $1 : $Task_txt ("LOADFROMDATA" | "SAVETODATA" | "LOADTYPES" | "CLEAR")

//ut_GetChildTables 
//  ` Add to arrays information about the children of a table starting from a Key field ptr

//ut_DocumentTableandFields 
//  `Utility

//ut_ResetNonUniqueIndices 

//insp_NewCreateElementDictHlist 

//insp_NewAddElmtCat2HL 

//QR_YearBuiltReBuilt 
//  ` Return the Year Built or rebuilt based on items 27 or 106
// ` Parameters
//  ` $0 : $YrBltRBlt_L
//  ` $1 : $Item27_L (optional) - if not zero - must pass $2
//  ` $2 : $Item106_L (optional)

//insp_LoadaInspType_ 

//` Make changes for Pedestrian bridge input
//INSP_KiloPtValues ` Make changes for Pedestrian bridge input
//New form
//[Inspections];"PedestrianInspection-PED"
//  `Note to complete we must create new field to hold ada accessible data and identify how drop downs are filled on this page
//[Inspections];"RailCulvertCombined-RRC"
//[Inspections];"MHD_Special_Member98"

//End Mods_2012_11