//%attributes = {"invisible":true}
//Method: Mods_2022_01
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-01-03T00:00:00, 17:11:42
	// ----------------------------------------------------
	//Created : 
	Mods_2022_01
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-03)
// [LSS_Inspection];"InspectionReview"
//  `added code for on Activate and Deactivate
// LSS_PrintMultipleInspections
//  `create a new sorted selection of the highlited records and then run the printing

//Method: UI_StackWindows
//Description
// Stack all open windows - Can be used in case some windows have gone off screen on Mac or windows

// Menu Tools in menu bar #1
// added "Stack all windows" item 

// [LSS_Inspection];"InspectionReview"
//  `added code for on Activate and Deactivate


//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-06T00:00:00)
// [Activity Log];"ViewExtras"
//  `added Button on pg 0 to change dataview - Can be used on windows when start pop up menu does not display

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-10T00:00:00)
//Method: TownAddrDistrSel_OM
//Description
// object method for the Select byt District int the Town Address lists

// [Town Address];"View Town Address_LB".District Select
//  `Use method TownAddrDistrSel_OM
// [Town Address];"View Town Address".District Select
//  `Use method TownAddrDistrSel_OM

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-11T00:00:00)
// ****  Changes to work better as a service not using a Local user account
// ut_ReturnUserDocFolder
//  `Change if running as a server, return the Data file folder.
// Startup_PL
//  `set <>MyDocumentsFolder_txt to the data file folder if running as a server.
// ut_SaveBlobDataToDoc
//  `use Get 4D folder(Database folder) and Folder separator - create Extras folder if it does not exist on server
// G_DisplayTable_generic
//  `if output form ends in _LB use DIALOG command
// INSP_ReportIncompleteInsp
//  `use ut_ReturnUserDocFolder to set the folder path - takes into account when running on server
//  `use parameter "PRODSERVERIP" to get the production server IP

// Startup
//  `no need to call ut_ResetPathToServer

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-14T00:00:00)

// ====
//  verified  all forms with Write Pro Areas - for events  On load, On Unload, On Losing focus 
//  enabled in both form and WP objects ; set all Write Pro areas to Page view mode from embedded 
//  Dive forms were not set correctly.
// ====

// G_Insp_LockFormOnOff
//  `when inspection is locked, enable _WP areas so text can be selected and copied from them.

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-14T00:00:00)
// ====
//  2nd round to verify  all forms with Write Pro Areas - for events  On load, On Unload, On Losing focus 
//  enabled in both form and WP objects ; set all Write Pro areas to Page view mode from embedded 
// ====

//  Added to Resources missing INSP/Image Arrangement.pdf

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-18)
// ut_ACTLOG_addInsp
//  `added third parameter for last RefID

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-19)
// made field [Activity Log]Forward indexed

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-20)
// On Server Startup
//  `make sure we have a preferences record, even if blank
// On Startup
//  `for non-client make sure there is a preferences record

//  **  **  **  **  **  **  **  **  **  **  **  **
//  ** made v18 test release on 2022-01-20
//  **  **  **  **  **  **  **  **  **  **  **  **

//**********`Modified by: Costas Manousakis-(Designer)-(2022-01-21T00:00:00)
// DesignForward.OKButton
//  `allow for vsForward to be blank

//End Mods_2022_01