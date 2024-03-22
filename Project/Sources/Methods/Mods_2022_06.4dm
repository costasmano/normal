//%attributes = {"invisible":true}
//Method: Mods_2022_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-06-06T00:00:00, 19:44:38
	// ----------------------------------------------------
	//Created : 
	Mods_2022_06
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-06)
//Method: DEV_ReplaceObjecSetColor
//Description
// Replace the _ o _object set color commands in all methods or selected ones

// [zDialogs];"QR_Dialog"  ***** in bug
//  `initialize report area on load
//  `delete the delete column and Header buttons on the form.
//  `enable contextual menus on the report area
//  // disable on Load event on the Report_area_l object on the form
//  // added Export to Excel and Preview buttons
//  // enabled on click event ib the Sort order hlist to adjust the order
//  // added Help text to hlists and buttons

// ut_NewSaveMethod   ***** in bug
//  `removed extra fileseparators when building folder path for form object methods
//  `added optional 3rd param with the method text

//Method: DEV_MethodPathToName
//Description
// convert a Method path to method name
// Parameters
// $0 : $methodname_txt
// $1 : $Methodpath_txt

// ADDUSER_Utils
//  `use OB is defined() instead of Undefined() 

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-08)
// [Dialogs];"ReportTemplateSelect"   ***** in bug
//  `changed Destination list to show Excel instead of 4D View and replace 4D chart with "-"

// [Inspections];"InspectionReview_LB".QRPrintButton   ***** in bug
//  `added On Alternative Click and enabled On Alternative Click in the object events
//  `added help tip "Click for Quick Report editor ; click on arrow for more options."

// [InventoryPhotoInsp];"ReviewDialog".QRPrintButton   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending aquick report to excel
//  // added help tip "Quick Report editor; click on arrow for more options."

// [ScourPOA];"Output_LB".bReport   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending aquick report to excel
//  // added help tip "Click for Quick Report editor ; click on arrow for more options."

// [Cons Inspection];"View Cslt Insp_LB".Variable8   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending aquick report to excel
//  // added help tip "Click for Quick Report editor ; click on arrow for more options."

// [Conslt Rating];"View Cslt Rating_LB".Variable8   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending a quick report to excel
//  // added help tip "Click for Quick Report editor ; click on arrow for more options."

// [RatingRequests];"Output".bReport   ***** in bug
//  // enabled long click and alternate click in events
//  // code to enable sending aquick report to excel
//  // added help tip "Click for Quick Report editor ; click on arrow for more options."

// [Contracts];"Contracts_LB".Variable8   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending aquick report to excel
//  // added help tip "Click for Quick Report editor ; click on arrow for more options."

// [Bridge Design];"View Bridge Design_LB".Variable8   ***** in bug
//  `  //  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending aquick report to excel
//  // added help tip "Click for Quick Report editor ; click on arrow for more options."

// [Conslt Address];"View Conslt Address_LB".Report   ***** in bug
//  // enabled long click and alternate click in events
//  // code to enable sending aquick report to excel
//  // added help tip "Click to print address forms ; click on arrow for more options."

// [Town Address];"View Town Address_LB".Variable8   ***** in bug
//  `added option to send a quick report to excel
//  `changed help tip to "Click for report options"

//[Status Report];"Output_LB".Variable12   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending a quick report to excel
//  // added help tip "Click for Quick Report editor ; click on arrow for more options."

// [NTI_TunnelInfo];"ListBoxOutput".bReport   ***** in bug
//  `added option to Generate a Quick report to Excel

// [TIN_Inspections];"ReviewList".bReport   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending a quick report to excel
//  // added help tip "Quick Report; click on arrow for more options."
//  // changed font size of all button titles to 10 from 12

// [Personnel];"Inspectors Out_LB".QRPrintButton   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending a quick report to excel
//  // added help tip "Quick Report editor; click on arrow for more options."

// [PERS_Groups];"PG_Output_LB".bReport   ***** in bug
//  `change button type to 3D button with separated menu - made button wider
//  // enabled long click and alternate click in events
//  // code to enable sending a quick report to excel
//  // added help tip "Quick Report editor; click on arrow for more options."

// [LSS_Inventory];"ListBoxOutput".bReport   ***** in bug
//  // enabled long click and alternate click in events
//  // code to enable sending a quick report to excel
//  // added help tip "Quick Report editor; click on arrow for more options."

// [LSS_Inspection];"InspectionReview".bReport   ***** in bug
//  // code to enable sending a quick report to excel
//  // added help tip "Quick Report editor ; click on arrow for more options."

// [PRJ_ProjectDetails];"BridgeProgram_LB".PRJ_QRDescriptions_atxt   ***** in bug
//  `adjusted code to allow running methods using EXCEUTE FORMULA.
//  `deleted duplicate buttons and pulldowns on form

// [PRJ_ProjectDetails];"ProjectDetails_LB".PRJ_QRDescriptions_atxt   ***** in bug
//  `adjusted code to allow running methods using EXECUTE FORMULA.

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-13)
// ut_SQLDownloadNewRecords   **** in Dev
//  `ignore value stored in [Preferences]LastRefID_L - 

// DEV_compareFolders   ***** in bug
//  `moved start progress bar after choosing the folders; added message getting directories

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-15)
//Method: ACTFIX202206   ***** in bug
//Description
// Fix Activity log transfers by clearing activity refids from Owners of data table.
// Activity log records were not downloaded for the user because they were still 
// reserved in a transaction on the server when a download was executed.
// This method will find which records were missed, and then clear record IDs for 
// downstream activity records that were downloaded.  
// If that is not done, earlier activity will overwrite the later one.
// Keep track of whether the method was completed in parameter ACTFIX202206

// ut_SQLDownloadNewRecords   ***** in bug
//  `call method ACTFIX202206 to fix owners of data on remote server

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-16)

//Resources   ***** in bug
// added icons Resources:MADOTIcons:Spelling_32px.png
// Resources:MADOTIcons:LineHeight.png

//"WPToolbar"   ***** in bug
//added button to do spell check

//"WriteTest" WPToolbarnameWPToolbar2"   ***** in bug
//[ElementsSafety];"Safety Elm Inp Dive"   ***** in bug
//[ElementsSafety];"Safety Elm Inp DiveS"   ***** in bug
//[ElementsSafety];"Safety ElmInput"   ***** in bug
//[ElementsSafety];"SafetyElementInputEx"   ***** in bug
//[ElementsSafety];"TunnelSafetyElmInput"   ***** in bug
//[ElementsSafety];"TunnelSafetySpElmInput"   ***** in bug
//[Inspections];"Closed Bridge"   ***** in bug
//[Inspections];"Critical Member"   ***** in bug
//[Inspections];"Culvert Combined"   ***** in bug
//[Inspections];"Damage Form"   ***** in bug
//[Inspections];"Dive Form"   ***** in bug
//[Inspections];"Dive LowCl"   ***** in bug
//[Inspections];"PedestrianInspection-PED"   ***** in bug
//[Inspections];"RailCulvertCombined-RRC"   ***** in bug
//[Inspections];"RailRoutineInput"   ***** in bug
//[Inspections];"Routine Combined"   ***** in bug
//[Inspections];"TunnelDamageForm"   ***** in bug
//[Inspections];"TunnelInspection"   ***** in bug
//[Inspections];"TunnelOverheadInspection"   ***** in bug
//[Inspections];"TunnelSpecial"   ***** in bug
//[Inspections];"Underwater Special Member"   ***** in bug
//[NTI_ELEM_BIN_INSP];"Input"   ***** in bug
//[NTI_ELEM_TIN_INSP];"Input"   ***** in bug
//[TIN_Inspections];"Input"   ***** in bug
// adjusted width of subform with WPToolbar to show the new spellcheck button, and renamed subform to WPToolbar

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-17)
// ACTFIX202206   ***** in bug
//  `added log file at the end  and parent id in the RecordSearch array

// [Activity Log];"Output_LB".Variable9   ***** in bug
//  `added option to convert a Quick report to Excel

// Build_SearchFormula   ***** in bug
//  `if the blob from getpasteboard data("Text"; is empty, try get text from pasteboard

// [Dialogs];"TransferSet"   ***** in bug
//  `added dropdown to select usernames belonging to group "Field Group"

//```
//```    **** End of Release 8.0.0.c 2022-06-17
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-22)
//Method: PERS_GetLastLoginDate   ***** in bug
//Description
// Get the last login date for a user in the [Personnel] table. Can be used in quick reports.
// Parameters
// $0 : $LastLogin_d
// $1 : $UserPID (optional) if not passed use the current record  personID

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-27)
// ACTFIX202206   ***** in bug
//  `when saving parameter ACTFIX202206  mark the act log records created with Destination=notransfer

// ut_ControlDBSycnh   ***** in bug
//  `add call to ACTFIX202206 - needs to run the check before an upload

//```
//```    **** End of Release 8.0.0.d 2022-06-27
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-28)
// ACTFIX202206   ***** in bug
//  `fixed code saving param record; changed vars used in Execute immediate commands to process variables

//```
//```    **** End of Release 8.0.0.e 2022-06-28
//```


//**********`Modified by: Costas Manousakis-(Designer)-(2022-06-30)
// ut_SaveSysParam
//  `unload the parameters record at the end

//End Mods_2022_06