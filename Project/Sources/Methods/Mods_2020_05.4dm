//%attributes = {"invisible":true}
//Method: Mods_2020_05
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/01/20, 12:39:41
	// ----------------------------------------------------
	//Created : 
	Mods_2020_05
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(5/1/20)
// Modified Forms : 
// [Inspections];"RailRoutineInput"
//  `adjusted size of tab object on page 0 - was causing resize event on load.

// [Bridge MHD NBIS];"NewMBTANBIS_StackInfo"
//  `made all columns in LB not editable

// CU_CondUnitsSubForm_FM
//  `Fixed name of LB

//**********`Modified by: Costas Manousakis-(Designer)-(5/4/20)
// [Inspections];"Dive Template".DE Button Accept
//  `added resequence of images
// INSP_UWSaveInsp
//  `added resequence of images and a redraw window at the end
// INSP_SaveRecords
//  `remove set cursor commands - added redraw window at the end

// INSP_MoveImages
//  `added short message about moving...

//**********`Modified by: Costas Manousakis-(Designer)-(5/5/20)
// INSP_SaveRecords
//  `added a resize of window at the end  -  Removed it does not help
// INSP_UWSaveInsp
//  `added a resize of window at the end -  Removed it does not help

//**********`Modified by: CJMiller-(Designer)-(5/5/20)
// OpenRatingFolderError
//Add to make sure rating folders can be created

//**********`Modified by: Costas Manousakis-(Designer)-(5/6/20)
// Modified Form Methods : 
// [LSS_Inventory];"ListBoxOutput".Inventory_LB
//  `make "Line" grow horiz and when exiting the input form also resize the "Line" obj same as the LB 

// [BridgeMHDNBISArchive];"Rpt RPC Detail"
// adjusted size and location of object for better printing

// [Bridge MHD NBIS];"Rpt RPC"
//  `adjusted pos and ht of pbjects to use as single form for the RPC report printing
//  `also adjusted marker locations and removed break1 to match values in M_RPC_Report method

// [BridgeMHDNBISArchive];"Rpt RPC FedAid"
// adjusted location, size of objects and markers for better printing

// M_RPC_Report
//  `modified to use only the "Rpt RPC" form by printing sections of it.

//**********`Modified by: Costas Manousakis-(Designer)-(5/7/20)
//LO: [Inspections];"Critical Member"
//  `Renamed obj EJDMT Label because it was not 'hiding' inside the weightpostarea.

//Form : [Bridge MHD NBIS];"Bridge Input"
//  `made all buttons on page 1 3D buttons bevel ht 30 - will show that they have been clicked

//Form: [PON_ELEM_INSP];"LB_PON_ELEM_INSP"
//made all button objects 3D buttons

// [LSS_Inventory];"ListBoxOutput"
//  `adjusted labels of buttons to split in two lines when needed, and re-spaced them.

// [LSS_Inventory];"ListBoxOutput".bCustomSearch
//  `made button use alternative click instead of always showing popup menu

//**********`Modified by: CJMiller-(Designer)-(5/7/20)
//[Bridge MHD NBIS];"Bridge Input".OpenRatingFolder
// Make change so that only folks in (GRP_UserInGroup ("MoveRatingReports") can create folders  

//OM_ControlOpenandMoveRatingPDF
// Make change as we assume $baseSpec_txt folders are always there

// PRJ_LoadForBINHierarchyDialog
//Fix bug where when no groups to start of loop make sure v_122_006_L is set correctly

//**********`Modified by: Costas Manousakis-(Designer)-(5/11/20)
// G_SIA2Inspection
//  `adjustments made to comparing culvert ht, wdth to account for the transition from integer to real for the SIA values.


//**********`Modified by: Costas Manousakis-(Designer)-(5/12/20)
// M_NEW_BIN
//  `modified code to fix the problem where after getting back to the listbox display,
//  `doubleclicking on a line was not working correctly and the UserSet set was not maintained

//modified Fields :
//[Bridge MHD NBIS]BarrelsHeight
//[Bridge MHD NBIS]BarrelsWidth
//  `changed field to real from integer.

//**********`Modified by: Costas Manousakis-(Designer)-(5/13/20)
//modified table [Town Address]
//  //Added field  [Town Address]TownBDEPTPrefix - Alpha 3

// [Town Address];"Town Address In"
//  `added drop down for field [Town Address]TownBDEPTPrefix - adjusted location of objects and form size limits
//  `removed the template form and copied all buttons - adjusted appearance, object properties....
//  `added two buttons to add lines to the Addressed to and Street fields

// Method: F_GetCityOrTown
//  `modified to take advantage of the new field [Town Address]TownBDEPTPrefix
//  `will try that first and then use the old method.

// GetTownAddress
//  `modified to take advantage of the new field [Town Address]TownBDEPTPrefix
//  `will try that first and then use the old method.

//Method: TownAddressUpdate
//Description
//Method to update the new BDEPT prefix field in Town Address table
//Will match the town name in the official town name field with the Town name in Town data.
//Can be repeated and it will only update differences
// only for DesignUsers
// Parameters
// ----------------------------------------------------

//**********`Modified by: Costas Manousakis-(Designer)-(5/14/20)
// Method: CM_MailInvoiceNotice_2
//  `include part of the comments in the email. 
//  `it is assumed to have funding allocation info up to the first blank line

//Form :[Parameters];"Input"
//  `adjusted size location of objects, made Value field grow horiz.
//  `removed obj method from ParamCode - added code to lock it for existing records

//modified output forms for [Bridge Design] [Contracts] [Town Address] `Cons Inspection]
//  //[Conslt Rating] [Conslt_Name] [PRJ_ProjectDetails] [PRJ_DesignContracts]
//  // made all fields to have automatic color for better display when rows are selected.

//**********`Modified by: Costas Manousakis-(Designer)-(5/18/20)
// [LSS_Inspection];"SignStructurePg1"
//  `increased number of rows for Section 2 to 19 for Vibration Dampener

// [Bridge MHD NBIS];"RAIL_SIA_Input"
//  `adjusted tab order in geometry tab

//Method: DEV_ParseStructureExport
//Description
// parse the XML export of a structure to create export .xls files
// same as ut_exportfieldtitles but include the comments found in the XML export
// Parameters
// ----------------------------------------------------

//Method: CompareVersion
//Description
// compare two versions and return if the first is at or greater than the second
// Versions starting with major and minors separated by "."  ex 7.2.1.a
// the basis of comparison is based on the second version. 
// if the nth minor of the second verion is a number, the comparison is numeric, 
// otherwise it is a string comparison
// Parameters
// $0 : $GTE_b
// $1 : $V1 
// $1 : $V2 
// ----------------------------------------------------

// fGetDataType
//  `updated with list from manual for Type

//Modified Ratings display so mount and movement can be from windows as well as macs

//OM_ControlOpenandMoveRatingPDF 
//"RatingReportDisplayandMove"
//Method: RatingReportDisplayandMove

//Method: RatingReportDisplayandMove.MatchedDocuments_atxt
//Method: RatingReportDisplayandMove.Button


//Modified by: Chuck (5/26/20 12:16:15)
//Add in progress bar to resource move on load
//Method: From Method SelectResources
//Test to see if blob needs to be compressed on create activity log button
//Method: "SelectResources".Button1

//**********`Modified by: Costas Manousakis-(Designer)-(5/26/20)
// Modified Forms : 
// CountDownTimer
//  `added button with option to Run Now
// DelayedTransfer
//  `Added Interval in minutes to allow transfers at an interval (default = 120 min)

// Modified Method(s) : 
// ut_DelayDBSynch
//  `modified to allow transfers at a given interval.

// M_Exec Transfer
//  `added option to hold mac command key for delayed transfer

//**********`Modified by: Costas Manousakis-(Designer)-(5/29/20)
// "RatingReportDisplayandMove"
//  `made the _MAC webareas NOT use the integrated webkit
//  `enabled on Activate and on Unload on form events
//  `use the PDFJS component to display the pdf on a mac to fix problems in OSX 10.13
//  `use the copy of the pdf made by the component to display the pdf on WIN so the original is not locked by Adobe

// "RatingReportDisplayandMove".DeleteButton
//  `load "about:blank" before updating the area with text. 

// "RatingReportDisplayandMove".ExistingRatingReport2A
//  `modified to use the PDFJS component.  For Mac use the PDFJS viewer, 
//  `for WIN use the copy of the pdf made by the component to avoid locking original by Adobe

// "BinRequestDisplayandMove"
//  `enabled on Activate and on Unload events in form events 
//  `use the PDFJS component to display pdf to avoid problems with OSX 10.13 pdf display in web areas.
// "BinRequestDisplayandMove".ExistingBinDropDown
//  `modified to use the PDFJS component.

//End Mods_2020_05