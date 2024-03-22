//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(2/23/2007 14:05:15)
//Added Lib pictures
//BMS TruckPostingSign
//BMS VertCLRSign
//BMS VertCLRSignItems

// Created Form(s) : 
//[Dialogs];"TruckPosting"
//[Dialogs];"VertCLR_Sign"
//  `Used in getting user info for letters

// Created Method(s) : 
//LTR_GenerateTruckPic 
//LTR_GenerateVertCLPic 
//LTR_GetVertCLtoFTIN 
//LTR_LoadPicture 
//LTR_VerifyTruckPosting 
//LTR_VerifyVertCL 
//  `Methods used to handle creating the images used in the Truck
//  `postings and Vert Cl posting letters.
//LTR_GetLastInspDate
//  `Get the last inspection date for letters.

// Modified Forms : 
//[Templates];"Input"
// Modified Form Methods : 
//[Templates];"Input"
//  `Added 2 pages with objects, buttons, and modified form method
//  `and object method to handle Images and Chart templates. 

// Modified Method(s) : 
//G_WRT_MakeDocument
//  `Added code to handle inserting a picture (LTR_PictureInsert_pict) in the document.
//G_WRT_GenericBridgeLetter
//  `Modified to load the pictures required for Truck posting and Vert Clearance letters.
//  `Also get the last inspection date.

// Modified Method(s) : 
//G_DisplayTable_generic
//  `Added option to sort by a field.
//P_ListTemplates
//  `Use the sort field option.

// Modified Object Methods : 
//[Templates];"Output".bAdd, .bDelete, bShowAll, bShowSubset, bQuery
//  `Added code to modify the window title and keeping things sorted.
//  `Also assigned shortcut keys to the buttons.

// Modified by: costasmanousakis-(Designer)-(2/26/2007 12:25:55)
// Created Method(s) : 
//OP_GetPassword
//OP_ErrorCheck
//WKHR_PAREMOTE_Search
//WKHR_PAREMOTE_SetLinks
//WKHR_PAREMOTE_LoadRec
//WKHR_PAREMOTE_UpdateValues
//WKHR_ProposalToAssignRemote
//WKHR_PropFund2Assgn 

// Modified Forms : 
//[Work_Estimate];"Input"
//  `Added button UpdateAssignment

//Created Help item
//WK_Prop2Assgn

// Modified Form Methods : 
//[Work_Estimate];"Input"
//  `Code to handle appearance of the UpdateAssignment button

// Modified Method(s) : 
//WKHR_Input_SetReviewRW
//Code to handle appearance of the UpdateAssignment button

// Modified by: costasmanousakis-(Designer)-(2/27/2007 11:40:09)
// Modified Method(s) : 
//GetDHDinfo
//  `Added variables and code to get the district address and phone from
//  `the [Town Address] table

// Created Method(s) : 
//WKHR_ApprvReject_OM
//  `Object method for the Approve button in [Work_Estimate];"Input" form

// Modified Object Methods : 
//[Work_Estimate];"Input".ApprvReject_p
//  `Use method WKHR_ApprvReject_OM

// Modified Method(s) : 
//WKHR_ProposalToAssgn
//  `Adjusted the messages and the code.

// Modified by: costasmanousakis-(Designer)-(2/27/2007 15:43:32)
// Modified Form Methods : 
//[Dialogs];"DesignToSIA"
//  `Fixed code getting the Deck and wearing surface codes
// Modified Forms : 
//[Dialogs];"DesignToSIA"
//  `Changed appearance and horiz margins
// Modified Method(s) : 
//BridgeDesignToSIA
//Use the CENTER_Window method

// Modified by: costasmanousakis-(Designer)-(2/28/2007 16:25:42)
// Modified Method(s) : 
//TEMP_UpdFutAdt
//  `Only update records if future ADT date is less than 21 yrs from inspection date;
//  `Also log the changes.

// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:46)
// Created Method(s) : 
//CM_GetPersonnelData
//  `Retrieve personnel data for contract mgmt letters

// Modified Method(s) : 
//CM_PrintExtTimeLetter
//CM_PrintAddenAssignm_Letter 
//CM_Print_NTP_Letter 
//CM_PrintRFP_Letter 
//CM_PrintAmendment_Letter 
//CM_PrintCostPlusTransfer_Letter 
//CM_PrintLumpSumTransfer_Letter
//  `Use method CM_GetPersonnelData

// Created Method(s) : 
//CM_GetStrMntEngrs
//  `Get the list of struct maint engineers for a list of districts
// Modified Method(s) : 
//CM_PrintRFP_Letter 
//  `Use CM_GetStrMntEngrs

// Modified by: costasmanousakis-(Designer)-(3/1/2007 16:55:41)
// Modified Form Methods : 
//[InventoryPhotoInsp];"ReviewDialog"
//  `Disable the approve btn for all but designer and DBIEs

// Modified by: costasmanousakis-(Designer)-(3/2/2007 16:12:56)
// Modified Forms : 
//[Status Report];"I_StatusReport"
//[Status Report];"P_StatusReport"
//[Status Report];"P_StatusReport_HI"
//[Status Report];"P_StatusReport_new"
//  `Changed MDC labels to DCR

// Modified by: costasmanousakis-(Designer)-(3/12/2007 08:21:24)
// Modified Method(s) : 
//WKHR_ComputeAvgs
//  `Added short message and an alert that is is done when not on server.

// Created Method(s) : 
//ut_CheckTransfer2Pontis
//  `To check the status of the transfer of data to the Pontis DB.

// Modified Method(s) : 
//ut_CheckExternalTransf
//  `Added a call to the ut_CheckTransfer2Pontis method

// Modified by: costasmanousakis-(Designer)-(3/20/2007 08:28:47)
// Modified Method(s) : 
//GetChiefEngineer
//  `Hard coded Dave Anderson, added string vCEActing.
//GetDeputyChiefEngineer
//  `Call the GetChiefEngineer method

// Modified by: costasmanousakis-(Designer)-(3/22/2007 09:12:36)
// Modified Method(s) : 
//GRP_AddToGroup
//GRP_RemoveFromGroup
//  `Added checks to make sure there are entries in the lists.

// Created Method(s) : 
//GRP_4DUIDinGroup
//  `Find whether a 4D User ID is in a Personnel Group.

// Modified Table(s) : 
//[Cond Units]
//  `Added field [Cond Units]ScaleFactor - hidden for future use

// Modified by: costasmanousakis-(Designer)-(3/23/2007 10:40:05)
// Modified Table(s) : 
//[PERS_Groups]
//  `Added boolean field [PERS_Groups]PERS_Acting

// Modified by: costasmanousakis-(Designer)-(3/23/2007 16:02:02)
// Modified Forms : 
//[Dialogs];"MessageDia"
//  `Set the message area to resize and the OK button to move vertically

// Modified by: costasmanousakis-(Designer)-(3/26/2007 16:20:45)
// Modified List : 
//"INV_PhotoDesc_NS"
//  `Changed SOUTH elevation to EAST Elevation

// Modified by: costasmanousakis-(Designer)-(3/27/2007 09:33:55)
// Created Method(s) : 
//ut_ArrayToHL 
//  `Create an HList from an array
// Modified Method(s) : 
//TMPL_Do_Template_Choise
//  `Use Hlist methodology
// Modified Forms : 
//[Dialogs];"ReportTemplateSelect"
//  `Use Hlist methodology
// Modified Method(s) : 
//G_LoadSpecialReports 
//  `Use Hlist methodology
// Modified Forms : 
//[Dialogs];"SpecialReportSelect"
//  `Use Hlist methodology
// Modified Form Methods : 
//[Dialogs];"SpecialReportSelect"
//  `Use Hlist methodology

// Modified by: costasmanousakis-(Designer)-(3/27/2007 15:51:14)
// Modified Method(s) : 
//G_WRT_GenericBridgeLetter
//  `Save and restore the Highlighted set ("UserSet")

// Modified by: costasmanousakis-(Designer)-(3/28/2007 11:34:57)
// Modified Method(s) : 
//CM_GetChiefEngineer 
//  `Use method GetChiefEngineer for constancy

// Modified by: costasmanousakis-(Designer)-(3/28/2007 12:53:45)
// Created Method(s) : 
//CRTG_RatingStatus 
//CRTG_SubmStatus
//  `Methods to determine the status of a conslt rating report
// Modified Forms : 
// Modified Form Methods : 
//[Conslt Rating];"View Cslt Rating"
//  `Modified form and form method to display the Rating report status and to sort by it.
// Modified Method(s) : 
//G_CSRTG_InitSortBtns
//  `Added the variable for the RtgReportstatus sort

// Modified by: costasmanousakis-(Designer)-(3/28/2007 15:51:45)
// Modified Method(s) : 
//Init_Fields_DES1
//  `Added code for the Freeze Thaw list
//InitProcessVar
//  `Added code for the Freeze Thaw list-with check if the global arrays are defined.
// Modified Forms and  Form Methods : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Added MissingSigns fields and FreezeThaw pulldowns on page 10;
//  `Moved objects around for better fit;
//  `Modified form method to allow access to Freeze Thaw only to Inspection Eng (DBIEs)
//[Bridge MHD NBIS];"SI & A (Insp)"
//  `Added MissingSigns fields and FreezeThaw;
//  `Moved objects around for better fit;
//  `Modified form method to fill variables.
//[Bridge MHD NBIS];"SI & A (Normal)"
//  `Added MissingSigns fields;
//  `Moved objects around for better fit;
//  `Modified form method to fill variables.

// Modified by: costasmanousakis-(Designer)-(3/29/2007 17:36:19)
// Modified Method(s) : 
//CM_Print_NTP_Letter
//M_WRT_CsltInsp_ComplexNTP
//M_WRT_CsltInsp_NTP
//M_WRT_CsltRating_NTP
//  `Use the GetBridgeEngineer instead of getting the Chief Engineer info.
//GetBridgeEngineer
//  `Added variable vBEActing ( for future use)

// Modified by: costasmanousakis-(Designer)-(4/3/2007 10:04:57)
// Modified Object Methods : 
//[Contract Assignments];"Assignments In" . btnRetrieveCost
//  `Added Info on which assignements are not complete.

// Modified by: costasmanousakis-(Designer)-(4/4/2007 16:35:44)
// Modified Method(s) : 
//ControlServerProcesses
//  `Added a boolean to be used to stop this control process
// Created Method(s) : 
//StopControlSrvProcess
//  `To find / set the stop flag and wake up the ControlServerProcesses method
//ut_LaunchStopCtrlSrvProcess
//  `To launch the StopControlSrvProcess method on the server

// Modified by: costasmanousakis-(Designer)-(4/5/2007 12:20:49)
// Created Method(s) : 
//ut_LaunchStartCtrlSrvProcess
//  `To launch the ControlServerProcesses method on the server

// Modified by: costasmanousakis-(Designer)-(4/6/2007 08:46:04)
// Modified Method(s) : 
//On Server Shutdown
//  `Call the StopControlSrvProcess process

// Modified by: costasmanousakis-(Designer)-(4/7/2007 19:06:07)
// Modified Method(s) : 
//G_WRT_BrInspRpt
//  `Added code to retrieve the last inspection date as part of the assignment list;
//  `Set the [Templates] table to RO

// Modified by: costasmanousakis-(Designer)-(4/10/2007 09:08:25)
// Modified Method(s) : 
//Startup_PL
//  `Added definition of directory separator ◊PL_DirectorySep_s

// Modified by: costasmanousakis-(Designer)-(4/12/2007 09:14:03)
// Modified Table(s) : 
//[Conslt Rating]  `
//  `Renamed field RequestRatWho to [Conslt Rating]PriorityColorFlag

// Modified by: costasmanousakis-(Designer)-(4/13/2007 08:55:45)
// Modified Method(s) : 
//INV_InvInspListObjM
//  `Added declarations of locked variables

// Modified by: costasmanousakis-(Designer)-(4/13/2007 12:00:13)
// Created Method(s) : 
//CINSP_LoadAssgnList
//CINSP_Load_LRI_Note

// Modified Method(s) : 
//G_InitInspVars
//  `Added variables for items at time of rating
//G_WRT_MakeDocument
//  `Added code to handle the case of Assignements in Cons Insp
//  `req for fee proposals.
//INIT_UI_GV
//  `Added the InspFormRevDate4 variable

// Created Method(s) : 
//INSP_SetInspRtgVars
//INSP_PR_RatgBlock
//INSP_CulvertPrPg1_FM
//  `Form method for the culvert print form page 1
//INSP_DamagePg1_FM
//  `Form method for the damage print form page 1
//INSP_FCPrPg1_FM
//  `Form method for the FC And Spec memb print form page 1
//INSP_SetUI_Rev4
//  `Change the User int in inspection input forms for Rev 4
//INSP_InspDate_OM
//  `object method for the inspection date field in inspection input forms.
//INSP_RoutinePrPg2_FM
//  `Form method for the Routine print form page 2
//M_SearchBrgInInspections
//  `Search in inspection table by bin or bdept
//M_WRT_CsltInsp_ComplexReqFee
//  `Use methods CINSP_LoadAssgnList and CINSP_Load_LRI_Note.

// Modified Method(s) : 
//PRINT_CULVERT_F
//PRINT_ROUTINE_F
//Print_SpecMem_pg1
//Print_SpecMem_pg3

// Modified Form Methods : 
//[Inspections];"Culvert Pr Pg 1" 
//[Inspections];"Damage Pg 1"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Routine Pr Pg 2"
//  `Use the new INSP_xxxx_FM form methods

// Created Form(s) : 
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"DamagePg1_v2"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"RoutinePrPg2_v2

// Modified Forms  and FMs : 
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined Form"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined Form"
//  `Added fields [Inspections]Itemxx_r and [Inspections]InspDate_r with the rating info block;
//  `Re-arranged other field to fit on form.
//  `Addded code in form method to show hide the new fields according to inspection date.

// Modified Forms : 
//[Cons Inspection];"Cslt Insp In"
//  `Added field [Cons Inspection]LoadRatingInfo on page 1

// Modified Object Methods : 
//[Inspections];"Closed Bridge".Insp Date
//[Inspections];"Critical Member".Insp Date
//[Inspections];"Culvert Combined".Insp Date
//[Inspections];"Damage Form".Insp Date
//[Inspections];"Routine Combined".Insp Date
//  `Replaced code with call to new INSP_InspDate_OM method

//[Inspections];"Culvert Combined".vbPGPreview
//[Inspections];"Routine Combined".vbPGPreview
//  `Adjusted code to account for new inspection forms for InspRev 4

// Created Method(s) : 
//utf_GetKeyfieldNum
//  `Get the key field for a table.`

// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Added button bzSearch to search by BIN or BDEPT

// Modified Object Methods : 
//[Templates];"Input".bDelete
//  `Moved the Delete record after the LogDeletion.

// Modified Table(s) : 
//[Parameters]
//  `renamed field [Parameters]Type to [Parameters]ParamType to avoid name conflicts.

// Modified Form Methods : 
//[Parameters];"Input"
//  `Added code to start login changes

// Modified Object Methods : 
//[Parameters];"Input".bValidate
//  `Set the shortcut Enter
//[Parameters];"Input".bDelete
//  `Made button not auto action
//[Parameters];"Input".ParamCode
//[Parameters];"Input".ParamType
//[Parameters];"Input".Value
//[Parameters];"Input".Description
//  `Added code to log changes new records and deletions.

// Modified by: costasmanousakis-(Designer)-(4/17/2007 14:53:56)
// Modified Forms : 
//[Dialogs];"SelectFromList"
//  `Deleted hidden text array; made buttons focusable

// Modified Form Methods : 
//[Parameters];"Output"
//  `Added call to declare the ptr_changes array; and to check for quit.

// Modified by: costasmanousakis-(Designer)-(4/18/2007 08:35:32)
// Created Method(s) : 
//INSP_PrintRevCmts_2
//  `Print comments from the approve dialog.

// Modified Forms  anf FM: 
//[Dialogs];"ApproveInsp"
//  `Added picture button to print the comments.
//  `Gave names to the buttons ending with "btn"
//  `Added code in Form method to hide the print button in case of Inventory photos

// Modified by: costasmanousakis-(Designer)-(4/18/2007 15:42:49)
// Modified Form Methods : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Added group ExternalDesigners to list of disabling

// Modified by: costasmanousakis-(Designer)-(4/19/2007 11:17:51)
// Created Method(s) : 
//INV_InvInspRWAccess
//  `Define RW access to inventory inspections

// Modified Method(s) : 
//INV_InvInspListObjM
//  `Allow creation only for MHDInspectionRWAccess members and not external inspectors
// Modified Object Methods : 
//[Bridge MHD NBIS];"InventoryPhoto".bAddInvInsp
//  `Allow creation only for MHDInspectionRWAccess and not external inspectors
