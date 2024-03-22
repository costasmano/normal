//%attributes = {"invisible":true}
//Method: Mods_2016_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/04/16, 15:43:36
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
End if 
//
//**********//Modified by: Costas Manousakis-(Designer)-(11/4/16)
// Created Method(s) : 
//PON_VerifyUniqueKeys
//Description
// Check current inspection for duplicate element key combination
// StructUnit + elemkey + envKey + parentkey + grandparentkey
// report any/all errors in a text
// Parameters
//$0 : $PontisErrors_txt

// Modified Method(s) : 
//PON_VerifyNBEQuantities
//  //added call to PON_VerifyUniqueKeys to add to the error messages

//Compiler_PON 
//  //added PON_VerifyUniqueKeys

//**********//Modified by: Costas Manousakis-(Designer)-(11/7/16)
// Modified Method(s) : 
//Mail_SendInspRevuNotif
//  //added code instead of bringing up EmailDailog, try to script outlook on windows, and then open dialog if there is error. For Mac- bring up the EmailDialog

//MAIL_scriptOutlook 
//  //made this  so it is for both platforms. added name in mac outlook email address

//Compiler_MailUtils
//  //added $0 param to MAIL_scriptOutlook

//ActualDataToAssignmnt
//  //changed the BDEPTBIN_Pattern to accound for  bdept -BIN entered as B-16-281 (3BP)


//**********//Modified by: Costas Manousakis-(Designer)-(11/9/16)
// Modified Method(s) : 
//PON_VerifyNBEQuantities
//  //added check for quantities to add up correctly. added retrieval of the Grandparent key for reference

// Created Method(s) : 
//MAIL_ParseAddress
//Description
// parse a text containign email address into the email address and the display name.
// Parameters
//$1 : $address_txt
//$2 : $EmailAddr_ptr
//$3 : $Name_ptr
// ----------------------------------------------------

// Modified Method(s) : 
//Compiler_MailUtils
//  //added MAIL_ParseAddress
//MAIL_scriptOutlook
//  //use MAIL_ParseAddress

//PON_ExportToBrM
//  //more changes to catch errors in NBEs

//**********//Modified by: Costas Manousakis-(Designer)-(11/10/16)
// Modified Method(s) : 
//PON_VerifyNBEQuantities
//  //slight  mods in the error report log

//**********`Modified by: Costas Manousakis-(Designer)-(11/14/16)
// Modified Forms : 
//[ElementsSafety];"SafetyElmtTemplate"
//  `added keyboard shortcuts to navigation buttons and changed obj methods to include the shortcut in the help tip
//[Standard Photos];"Standard Photos"
//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; changed object method code.

// Modified Forms : 
//[LSS_ElementInspection];"Input"
//[LSS_Photos];"Input"
//[LSS_SignPanel];"Input"
//[LSS_TowerDistance];"Input"
//[LSS_VerticalClearance];"Input"
//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; changed object method code.

//[PON_ELEM_INSP];"Input"
//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; 

// Modified Method(s) : 
//LSS_ModifyTowerorPost
//  `added  declaration of  "LSS_TowerDistance" selection
//PON_NavigateInput_OM
//  `Handle new method of diplaying the help tip with new kbd shortcuts

// Created Method(s) : 
//INSP_ImageNavigation_OM 
//Description
// Use in the record navigation buttons of standard Photos input form
// Parameters
// $1 : $HelpMessage_txt
// $2 : $KbdShortcut_txt - mac os shortcut : if Cmd is used will be replaced with CTRL on Windows

//INSP_ElementNavigation_OM
//Description
// Use in the record navigation buttons of ElementSafety input form
// Parameters
// $1 : $HelpMessage_txt
// $2 : $KbdShortcut_txt - mac os shortcut : if Cmd is used will be replaced with CTRL on Windows

//**********`Modified by: Costas Manousakis-(Designer)-(11/16/16)
// Modified Forms : 
//[NTI_ELEM_BIN_INSP];"Input"
//[NTI_ELEM_TIN_INSP];"Input"
//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; 
//  //only add on load event in v15 -rest is in object method

//[TIN_Insp_Images];"Input"   -- copied to v15 modified to use new commands
//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; added code in obj methods

// Modified Method(s) : 
//NTI_NavigateInput_OM    -- copied to v15 modified to use new commands
//  `Use on Load event instead of mouse enter/leave Handle new method of diplaying the help tip with new kbd shortcuts

// Modified Forms : 
//[LSS_DMeter];"Input"
//[LSS_UT];"Input"
//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; added code to object methods
//in v15 only add on load event to nav buttons - rest done in object method
//[LSS_UtResult];"Input"
//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; added code to object methods
//in v15 only add on load event to nav buttons - rest done in object method
//  //removed automatic action from the .bnext button

// Modified Method(s) : 
//Compiler_Inspections
//  `added INSP_ImageNavigation_OM  and  INSP_ElementNavigation_OM

//**********`Modified by: Costas Manousakis-(Designer)-(11/17/16)
// Modified Forms : 
//[PON_ELEM_INSP];"Input"
//  `navigation buttons : removed shortcuts/helpmessage/on mouse enter-on mouse leave - added on load event 

// Modified Method(s) : 
//Method: PON_NavigateInput_OM
//  `use on load event to set the keyboard shortcut and the help tip

//**********`Modified by: Costas Manousakis-(Designer)-(11/18/16)
// Modified Forms : 
//[Activity Log];"Output" 
//  `changed most buttons to 3D buttons using resources

//**********`Modified by: Costas Manousakis-(Designer)-(11/21/16)
// Modified Method(s) : 
//G_SIA2Inspection
//  `update Culvert items also
//G_RoutinetoBMS
//  `added Culvert items in the list to be transferred to SIA

//**********`Modified by: Costas Manousakis-(Designer)-(11/23/16)
// Modified Method(s) : 
//CM_MailInvoiceNotice_2
//  `If SMTP was not sent correctly; try scripting Outlook; and if that fails bring up dialog for manual send

//**********`Modified by: Costas Manousakis-(Designer)-(11/28/16)
// Modified Method(s) : 
//INSP_VerifySIAChanges
//  `clear HLists at the end

// Created Method(s) : 
//Method: MAP_PrepBridgeData
//Description
// Prepare the bridge data arrays to be used in a kml export
// Parameters
// $0 : required parameter so that it is available for HTML tags
// $1 : required parameter so that it is available for HTML tags

//Method: MAP_SetLabelFields
//Description
// Set the fields to be used in the point label

//Method: MAP_SetDataFields
//Description
// Set the Bridge table data fields to be used in the KML export

//Method: MAP_BuildContent
//Description
// Builds and KML file from the current list of bridges 
//- requires BridgesTemplate.KML in MAP folder in Reqources

//Method: MAP_UpdatePosFromKML
//Description
// Read a KML file and update the LatLon values if they are different
// will only work with the current list of bridges
// run from a menu which is allowed only to Field group

// Modified Menus(s) : 
//added item "Generate KML file" in bridgelistmenu/Tools  -> MAP_BuildContent
//added item "Import LatLon from KML" in bridgelistmenu/Data  -> MAP_UpdatePosFromKML available only to "Field Group"


//End Mods_2016_11