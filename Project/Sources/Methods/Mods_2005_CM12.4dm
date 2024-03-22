//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/05, 09:32:23
	// ----------------------------------------------------
	// Method: Mods_2005_CM12
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

//Modified Method
//G_Insp_LockFormOnOff
//  `When $vbLock is true cancel the current transaction.

// Modified by: costasmanousakis-(Designer)-(4/14/2005)
//Modified Method  
//G_Insp_LockFormOnOff
//  `Added code to lock entry to rating request fields for External Inspectors

//Modified Method
//G_Insp_HideRatReq 
//  `Enabled always printing of Rating Request fields.

//Modified DB Method
//On Startup
//  `When Application is 4D Client Register Client with UserName.

//Created Method
//StartControlSrvProc 
//  `To launch the Control Server process. When launched directly from on Server Startup
//  `the process ControlServerProcess could not load any records.

//Modified DB Method
//On Server Startup
//  `Launch a process StartControlSrvProc that will launch the ControlServerProcess.

// Modified by: costasmanousakis-(Designer)-(4/20/2005)
//Modified Method
//SD_FixData 
//  `Added code to make sure there are no blanks in the imported fields.

// Modified by: costasmanousakis-(Designer)-(4/21/2005)
//Modified Method
//ADD_COMBINED_INSPECT
//  `Moved LogLink for [CombinedInspections]BMSInspID AFTER the LogNewRecord for [BMS Inspections]
//G_AddPontisToCombined
//  `Moved LogLink for [CombinedInspections]BMSInspID AFTER the LogNewRecord for [BMS Inspections]

// Modified by: costasmanousakis-(Designer)-(4/21/2005 16:32:38)
// Modified Methods : 
//G_SIA2Inspection
//  `Added code to make sure that [Inspections]Item93b is blank (00/00/00) if 92bb is not >0

// Modified by: costasmanousakis-(Designer)-(4/22/2005 09:42:14)
// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Enable MDC users access to Inspection Buttons.
//  `Created a group box instead of text and rectangle.

// Modified Passwords : 
//  `Added MDC to MHDInspectionRWAccess group

// Modified Methods : 
//G_Insp_SetPersUI
//  `Added code to select different inspection agency depending on Insp responsibility.
//  `Code to initialize agency according to employee of current user.
//  `Code to initialize DBrInspEngr based on Inspection responsibility.
//  `Code to change Agency to DCR from MDC when editing an inspection.
//InitPers
//  `When defining array aBIE check Division No to indicate other agencies.
//M_MDC 
//  `Changed Process name to DCR
//P_MDC 
//  `Changed Title to Department of Conservation ...
//P_OtherAgc
//  `Changed Title for MDC insp resp to Department of Conservation ...
//M_OtherAgc
//  `Change Process name to DCR when Other Agency=MDC

// Modified Forms : 
//[zDialogs];"FilesPalette"
//  `Changed Label of MDC button to DCR

//Modified Menu
//#1:Enter
//  `Changed Label of MDC button to DCR

// Modified Forms : 
//[Dialogs];"GetOtherAgc"
//  `Adjusted size and location of objects to better fit descriptions of agencies.

// Modified by: root-(Designer)-(4/26/2005 14:57:26)
// Modified Form Methods : 
//[inspections];"Underwater Special Member"
//[Inspections];"Dive LowCl"
//  `Added call to RememberCombined method

// Modified by: root-(Designer)-(4/29/2005 15:30:23)
// Modified Method : 
//G_WRT_GenericBridgeLetter
//  `Added code to launch automatically generated letter.
//Created Method : 
//G_WRT_MakeDocument
//  `To be called from a variety of M_WRT_xxxx methods.
// Modified Methods : 
//M_WRT_CsltInsp_ReqFee
//M_WRT_CsltInsp_ComplexNTP
//M_WRT_CsltInsp_ComplexReqFee
//M_WRT_CsltInsp_NTP
//M_WRT_CsltRating_ReqFee 
//M_WRT_CsltRating_NTP
//  `Use method G_WRT_MakeDocument

// Modified by: costasmanousakis-(Designer)-(5/3/2005 12:23:32)
// Modified Forms : 
//[Bridge MHD NBIS];"Rpt RPC Header1"
//[Bridge MHD NBIS];"Rpt RPC Footer"
//  `Adjusted size of rectangle to match the rest parts of the RPC Report.

// Modified by: costasmanousakis-(Designer)-(5/4/2005 13:46:02)
// Modified Forms : 
//[Inspections];"SpecialExtra"
//  `Adjusted size of vLetterxx variables

// Modified Form Methods : 
//[Inspections];"SpecialExtra"
//  `Added code to use a different increment of letters for pages. Uses a process variable defined
//  `in the Print_SpecMem_pg1 and Print_SpecMem_pg3 methods.

// Modified Methods : 
//Print_SpecMem_pg1 
//Print_SpecMem_pg3
//  `Added code to initiallize and increment process variable vSpecMemStartLetter which is used to
//  `keep better track of the numbering of the letters in 2nd pages of spec memb/fract critr/ damage
//  `inspection forms

// Modified Methods : 
//G_RoutinetoBMS 
//G_CulverttoBMS
//  `Added calls to G_Insp_VerifyItem to make sure valid values are passed to NBI Items.
//  `Added loging of date/time modified, modified by.

// Modified Methods : 
//GetTownAddress
//  `Set table [town address] to read only when querying
//G_WRT_GenericBridgeLetter 
//  `Set Tables [Personnel], [Conslt Address], [Templates] to read only.

// Created Method : 
//M_WRT_CsltRating_Complete

//Added Menu Item
//Adde menu item Notice of Completion to Menu Bar # 4 using method M_WRT_CsltRating_Complete

// Modified by: costasmanousakis-(Designer)-(5/9/2005 12:42:55)
// Modified Methods : 
//P_ListConsRating 
//P_ListConsInsp 
//P_ListContracts
//P_ListBridgeDesign
//  `Added code to set to read only all other tables.

// Modified Methods : 
//P_ListConsAddress 
//P_ListTownAddress 
//  `Set other tables to read only; Mount menu bar (3)

// Modified Object Methods : 
//btnShowAddress
//  `Add code to change status of [Conslt Address] table to read write and read only and unload the record at the end.

// Modified Methods : 
//GetConsltAddress 
//  `Unload record after entering a new address. Change size of asComboItem to 250
//M_WRT_CsltRating_ReqFee
//  `Added call to GetBIE to fill in new vars in Template.

// Modified by: costasmanousakis-(Designer)-(5/10/2005 08:35:53)
// Modified Methods : 
//Server_GenCondRep 
//  `Execute SD_CreateMonthlyData only on weekdays.

// Modified Object Methods : 
//[Inspections];"Pontis".InspDate
//  `Fix recording of Dates.

// Modified by: costasmanousakis-(Designer)-(5/11/2005 12:21:58)
// Modified Methods : 
//GetTownAddress
//  `Changed code to allow choice from multiple towns. Lookup is done using the Official town name;
//  `Changed logic to make sure all vars are defined in all cases.

//Created New Form
//[Dialogs];"SelectTownAddress"
//  `Used in GetTownAddress method

// Modified by: costasmanousakis-(Designer)-(5/13/2005 16:16:31)
// Modified Method : 
//G_WRT_MakeDocument
//  `Added one parameter to indicate which case of doc settings should be used.

// Modified Methods : 
//M_WRT_IOMcover_cslt 
//M_WRT_IOMcover_inhouse 
//M_WRT_CsltInsp_Review 
//  `Use method G_WRT_MakeDocument with a parameter indicating case of document settings.

// Modified by: costasmanousakis-(Administrator)-(5/20/2005 14:51:47)
// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Added code to lock fields and buttons for users not in "SIA Access" group.
//[Bridge MHD NBIS];"Cslt Insps",
//[Bridge MHD NBIS];"Cslt Ratings"
//  `Disable add button for users not in Conslt Rating Read Wrtie group
//[Bridge MHD NBIS];"Other Info"
//  `Disable entries and buttons if user not memebr of "SIA Access" group

// Modified by: costasmanousakis-(Designer)-(5/25/2005 09:44:15)
// Modified Methods : 
//M_WRT_CsltRating_ReqFee 
//M_WRT_CsltInsp_ComplexNTP 
//M_WRT_CsltInsp_ComplexReqFee 
//M_WRT_CsltInsp_ReqFee 
//M_WRT_CsltRating_NTP 
//M_WRT_CsltInsp_NTP 
//  `Added calls to method GetBIEinfo
//GetInspContact
//  `Check in Personnel for code 12 = NBIS consultant contracts engineer

// Modified Forms : 
//[Conslt Rating];"View Cslt Rating"
//[Cons Inspection];"View Cslt Insp"
//  `Added shortcut keys to form buttons

// Modified Methods : 
//ut_PutFieldDescriptionIntoBlob 
//  `Added code when executing on server to save the Document in the Mac4DX and Win4DX folders.

// Modified Form Methods : 
//[Inspections];"Dive Pr  LowCl Pg1"
//  `Only need for one xR1 variable in this form.

// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//  `Disable copying of Pontis Inspections.

// Modified Methods : 
//Print_RTN_Cmts
//  `Fixed code which printed Item 60 header.

// Modified Form Methods : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Disable bID button for External Inspectors.

// Modified Form Methods : 
//[Inspections];"InspectionReview"
//  `Restore Named selection on Close Detail only if the selection of [Inspections] has
//  `been reduced to zero.