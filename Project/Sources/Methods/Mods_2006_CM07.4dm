//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/05/06, 11:30:27
	// ----------------------------------------------------
	// Method: Mods_2006_CM07
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
// Modified by: costasmanousakis-(Designer)-(10/5/2006 11:30:33)
// Modified Method(s) : 
//ut_CheckCombines
//  `Fix and log errors in BMS Insp date mismatches.

// Modified by: costasmanousakis-(Designer)-(10/30/2006 15:22:15)
// Modified Method(s) : 
//G_Insp_LockFormOnOff
//  `Unlock the View all comments btn for personnel in "Ratings and Overloads" group

// Modified by: costasmanousakis-(Designer)-(10/31/06 16:12:03)
// Modified Method(s) : 
//P_ListContracts
//   `Determine width of window from output form witdh

// Modified Forms : 
//[Contracts];"Contracts Out"
//  `Added column to display the Fed Aid status in Y/N format. 
//  `Added sort buttons and code to sort by Fed Aid.
//  `Modified obj code of other sort buttons to account for the Fed Aid sort.

// Modified by: costasmanousakis-(Designer)-(11/1/06 11:39:53)
// Created Method(s) : 
//INSP_GetUserAgency
//  ` Get the Agency of the current user.
// Modified Method(s) : 
//G_SIA2Inspection
//  `Use new method INSP_GetUserAgency for above water inspections only.

// Modified by: costasmanousakis-(Designer)-(11/3/06 15:12:42)
// Modified Forms : 
//[Cons Inspection];"Cslt Insp In"
//  `Turned off autospellcheck in remarks field on page  : would cause colorwheel.

// Modified by: costasmanousakis-(Designer)-(11/3/06 17:26:29)
// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Set Automatic relations to FALSE;FALSE before loading input form and 
//  `reset to TRUE;TRUE after the Cancel. 
//  `Fixes problem in Review Pending screen with adding Pontis CUs which caused loosing the current record of 
//  `[BMS Inspections].

// Modified by: costasmanousakis-(Designer)-(11/8/2006 09:08:26)
// Modified Method(s) : 
//ut_CheckExternalTransf
//  `Get the address of the external server from the [parameters] table

// Modified Form Methods : 
//[Parameters];"Output"
//  `Added code to sort by parameter code
// Modified Object Methods : 
//[Parameters];"Output". add, all records, delete, query, show subset buttons
//  `Added code to sort by parameter code and keep display lists or add to current list new records.

// Modified Form Methods : 
//[Dialogs];"LetterDateDialog"
//  `Get the number of days in advance from the parameters table.
// Modified Forms : 
//  `Use an embedded variable to display the num of days in advancce in the 'Label' of the window

// Modified Method(s) : 
//G_WRT_GenericBridgeLetter
//  `Added code to calculate size of window for the LetterDate dialog

// Modified by: costasmanousakis-(Designer)-(11/13/2006 12:22:31)
// Created Method(s) : 
//utf_GetUserPID
//  ` Get the Personnel ID of current user

// Modified Method(s) : 
//INIT_UI_GV
//  `Create new global var ◊CurrentUser_PID

// Modified by: costasmanousakis-(Designer)-(11/24/2006 12:07:53)
// Modified Object Methods : 
//[Personnel];"Inspectors Out".bzSearchLay
//  `Use the M_SearchEditor method instead of M_SearchSel

// Created Method(s) : 
//SRC_SearchByBridge
//  `Do a generic search on a table based on pointers to fields of the [Bridge MHD NBIS] table
// Modified Method(s) : 
//CreateRandomSet 
//  `Add an optional logic for searching based on pointer of fields and master table.
//M_SearchBridge
//  `Use the new method SRC_SearchByBridge
// Modified Forms : 
//[Dialogs];"Search Bridge"
//  `Added horiz and vert margins of 10

// Modified by: costasmanousakis-(Designer)-(11/27/2006 09:26:31)
// Modified Method(s) : 
//M_SearchBridgeinConsInspection 
//M_SearchBridgeinConsltRating 
//M_SearchBridgeinDesign
//  `Use the new method SRC_SearchByBridge

// Modified by: costasmanousakis-(Designer)-(12/1/2006 17:49:00)
// Modified Method(s) : 
//HI_CalcBridgeHI
//  `For non-MHD bridges use any inspections that have po.
//  `For MHD bridges look for approved inspections that have CUs.

// Modified by: costasmanousakis-(Designer)-(12/11/2006 16:53:45)
// Modified Forms : 
//[Bridge MHD NBIS];"BridgeTemplate"
//  `Added fields Item 7 and 6A on the form. Request by F.Rastegari

// Modified by: costasmanousakis-(Designer)-(12/12/2006 11:24:34)
// Modified Forms : 
//[Personnel];"Inspectors In"
//   `Re-arranged layout of objects on form; Added Phone_s and EmailAddress_s fields; 
//  `Added button to create the email address from the user info
//[Bridge MHD NBIS];"2nd Records"
//[Bridge MHD NBIS];"Bridge Design"
//[Bridge MHD NBIS];"Bridge Input"
//[Bridge MHD NBIS];"Cslt Ratings"
//[Bridge MHD NBIS];"Cslt Insps"
//[Bridge MHD NBIS];"Maintenance"
//[Bridge MHD NBIS];"Other Info"
//[Bridge MHD NBIS];"Pontis"
//[Bridge MHD NBIS];"Ratings"
//  `Adjusted size of Form Label
//[Conslt Rating];"Cslt Rat Out"
//  `Replaced Field Request byt DBIE with Rroj. manager ;
//  `Added field MostRecentSubmission

// Created Method(s) : 
//INI_LoadDBIEPhones
//  `Load the DBIE phone array from the database

// Modified Method(s) : 
//InitProcessVar
//  `Use method INI_LoadDBIEPhones instead of loading from a List

// Modified by: costasmanousakis-(Designer)-(12/21/2006 16:18:33)
// Created Method(s) : 
//Mail_SendInspRevuNotif
//  `Send mail notification to consultants upon review action by DBIE
// Modified Method(s) : 
//G_Insp_ApproveReject
//  `Use method Mail_SendInspRevuNotif
