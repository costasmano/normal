//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(11/15/07 08:46:38)
// Modified Method(s) : 
//ut_PRJRetrieveDesignContracts
//  `  Moved declaration and initialization of  $UpdateConsultantOveride_l
// ` to outside the if(601878) statement

//ResetNoTransfer
//  `Made sure [act log] table is in read write mode + Say how many records were locked

// **********  ` Modified by: costasmanousakis-(Designer)-(11/19/07 09:09:18)
// Modified Method(s) : 
//ut_LoadRecordInteractive
//  `Adjusted code to check for loaded record right after user clicks try again in the dialog.

// Created Method(s) : 
//SIA_GetUWItems
//  `Get Items 60,61,62 from UW inspection values to be displayed in SIA forms.
//INSP_CheckSpcMfrFreq
//  ` Check the requirements for Spec memb inspection.
//  ` If 58,69,60,61, or 62 <=4 Spec memb required
//  `  `=4 12 mo freq
//  `  `<= 3 6 mo freq

// Created Form(s) : 
//[Dialogs];"SpecFreqUpdate"
//  `Display the required changes if the spec memb settings may need to be changed

// Created Method(s) : 
//INSP_SpcFreqColorSet
//  `Used to indicate the ratings controlling the spec memb settings

// Modified Method(s) : 
//INSP_DiveDates2SIA
//G_RoutinetoBMS
//  `Call the new method INSP_CheckSpcMfrFreq
// Modified Object Methods : 
//[Bridge MHD NBIS];"SI & A Input".Item58, 59,60,61,62
//  `Added call to INSP_CheckSpcMfrFreq

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i".[PRJ_ProjectDetails]PRJ_CityOrTown_s
//  `Fixed call to got to area PRJ_ConsultantName_txt - was incorrectly coded

// Modified Object Methods : 
//[Work_Estimate];"Input".bDone
//  `When checking for modifications, check if WKHR_SaveRelated_B is also true

// Modified Forms : 
//[PRJ_ProjectFile];"PRJ_Selection.o"
//  `Made Cancel not the default btn; adjusted size of form
//[PRJ_DesignContracts];"PRJ_Selection.o"
//  `Made Cancel not the default btn; adjusted size of form; made it resizable
//[Conslt_Name];"PRJ_Selection.o"
//  `Made Cancel not the default btn; 

// **********  ` Modified by: costasmanousakis-(Designer)-(11/20/07 12:31:41)
// Created Method(s) : 
//ut_FindInHList
//  ` Find a string in an HList

//INSP_VerifySIAChanges
//  ` Verify the changes to be made on the SIA record.
//  ` Uses what is store in the ptr_changes array 1

// Created Form(s) : 
//[Dialogs];"TwoListMove"
//  `Used to move things between two lists.
// Created Method(s) : 
//G_MoveBtns_OM
//  ` Method for move buttons on form [Dialogs];"TwoListMove"

// Modified Method(s) : 
//G_RoutinetoBMS
//  `Use the new method INSP_VerifySIAChanges

// Modified Method(s) : 
//Startup_PL
//  `Added boolean vars ◊MacPL_b,◊WindowsPL_b
//GetPath
//  `Use var ◊PL_DirectorySep_s

// Modified Form Methods : 
//[Inspections];"Dive Pr  LowCl Pg1"
//[Inspections];"Routine Pr Pg 1"
//[Status Report];"P_StatusReport_HI" 
//  `Use Vars ◊MacPL_b,◊WindowsPL_b

// **********  ` Modified by: costasmanousakis-(Designer)-(11/21/07 12:00:46)
//Following are modifications so that the  [Bridge MHD NBIS];"PRJ_Selection.o" form can be used
//  `as a bridge selection tool, outside the Projects module.
// Modified Form Methods : 
//[Bridge MHD NBIS];"PRJ_Selection.o"
//  `On the Double click event, do the Call Process only if the ◊ProjectProcess_l variable is gt 0
// Modified Object Methods : 
//[Bridge MHD NBIS];"PRJ_Selection.o".bShowAll
//[Bridge MHD NBIS];"PRJ_Selection.o".bShowSubset
//[Bridge MHD NBIS];"PRJ_Selection.o".bQuery
//[Bridge MHD NBIS];"PRJ_Selection.o".bzSearch
//  `Sort the selection at the end of a search or any change.
//[Bridge MHD NBIS];"PRJ_Selection.o".Select btn
//[Bridge MHD NBIS];"PRJ_Selection.o".Cancel btn
//  `Do the Call Process only if the ◊ProjectProcess_l variable is gt 0, otherwise either
//  ` Cancel or Accept

// Modified Forms : 
//[Contract_Project_Maintenance];"Project Maintenance In" 
//  `Made vBridgeNo enterable, changed order and display of enterable fields/vars
// Modified Form Methods : 
//[Contract_Project_Maintenance];"Project Maintenance In" 
//  `Added code so that if a new record is not associated with an assignment it will cancel;
//  `also clear the BIN field on new records
// Modified Object Methods : 
//[Contract_Project_Maintenance];"Project Maintenance In".vBridgeNo 
//  `Added code to allow selection of a Bridge using form [Bridge MHD NBIS];"PRJ_Selection.o"
//[Contract_Project_Maintenance];"Project Maintenance In".btnSave 
//  `Don't save if the bridge has not been defined.
// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".btnSave
//  `Added code to prompt the creation of Projects if there are none defined, and there is  
//  `something that indicates that a bridge should be connected with this assignment.

// **********  ` Modified by: costasmanousakis-(Designer)-(11/26/07 10:01:06)
// Modified Method(s) : 
//InitPers
//  `Grouped all selection to array commands into single calls each case

// Modified Method(s) : 
//fUpforInsp
//  `Adjusted the code for the UW inspections. If the UW routine inspection was done
//  `after the UW Special, use that as a starting point for the UW Special cycle.
//  `Run thru the UWSpInsp code only if required.

// **********  ` Modified by: costasmanousakis-(Designer)-(11/28/07 09:01:14)
// Created Method(s) : 
//SIA_AccessibilityPrint
//  ` Calc the accessibility variables used in SIA print forms

// Modified Form Methods : 
//[Bridge MHD NBIS];"MHD Specific Items"
//[Bridge MHD NBIS];"SI & A (Insp)"
//  `Use method SIA_AccessibilityPrint ; Condense process variable declarations.

// Modified Method(s) : 
//G_InspGetRatings
//  `Get the values of item58,59 from the ratingreport table.

// Modified Method(s) : 
//InitPers
//  `Include Area Engineers and Bridge insp engineer in the team member list

// **********  ` Modified by: costasmanousakis-(Designer)-(11/30/07 09:33:53)
// Modified Forms : 
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"Damage Pg1"
//[Inspections];"DamagePg1_v2"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"Routine Arch Pr Pg 1"
//  `Made sure that the vTeamMbr variable has the same dimensions and the object is 
//  `named the same

// Created Method(s) : 
//G_FitPrintObject
//  ` Attempt to fit a printed object within its rectangle.
//  ` Allow for a vertical move.

// Modified Method(s) : 
//G_TmMemberList
//INSP_Item43Desc
//INSP_Item41Desc
//INSP_Item21Desc 
//INSP_Item22Desc 
//  `Use the new method G_FitPrintObject

// Modified Method(s) : 
//BridgeDesignToSIA
//  `Added code to a) keep the [bridge design] record in read only mode
//  `  `b) Make sure the SIA record has been loaded with write access.

//ut_ArrayToHL
//  `Accept an additional parameter to specify a custom Item reference array.

// Modified Form
//[Dialogs];"TwoListMove"
//  `Made the buttons not focusable
// Modified Method(s) : 
//G_MoveBtns_OM
//  `Use process variable TWOLIST_MOVEONLY_B to control whether items will can be in only
//  ` one list or both.

// Modified Object Methods : 
//[Dialogs];"TwoListMove".OmitList_HL
//  `Allow drop from itself, so items can be sorted.
//  `Call the G_MoveBtns_OM on the on drop event.
//[Dialogs];"TwoListMove".UseList_HL
//  `Call the G_MoveBtns_OM on the on drop event.

// Modified Method(s) : 
//EditTeam
//  `Modified to use the dialog [Dialogs];"TwoListMove" using option TWOLIST_MOVEONLY_B=true.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/3/07 13:54:05)

// Created Method(s) : 
//ut_LoadBridgeDesRecs
//  ` Method to load/update  [bridge design] records to a district db.
//  ` To be used to transfer these records from the Boston db where changes in
//  ` that table have not been getting logged.
//  `Step one is to create the export file while on the Boston server.
//  `Then import that file on the District server.
//  ` Will create local Activity log entries so that district users can get these records.
//  ` Will also create Record Resolutions.
//  ` Will prompt whether actlog records will be created, to address the case when it is run
//  ` on the External server.

// Modified Forms : 
//[Work_Estimate];"List"
//  `Made form resizable and added margins
// Modified Form Methods : 
//[Work_Estimate];"Input"
//  `Added process variables for user roles instead of checking all the time for user in group.
//  `Done mainly for testing purposes to control access from one point.

// Modified Method(s) : 
//WKHR_ClearOutCategory
//WKHR_ZeroAll
//  `Use the Role process variables

// Modified Forms : 
//[Work_Estimate];"Input"
//  `Removed extra blank pages.
//  `Added button to Accept review values on page 2
// Modified Method(s) : 
//WKHR_Input_GotoPage
//  `Adjust code for the removal of extra blank pages in the input form.
//  `Add code to control the visibility of the Accept review values button on page 2

// Created Method(s) : 
//WKHR_AcceptReviewer
//  ` Accept the reviewers values for an  item
//WKHR_AcceptRevwCat
//  ` Accept All reviewer values for the current category

// Modified Forms : 
//[Work_Estimate];"LineEntry"
//  `Added button to accept reviewer changes.
// Modified Form Methods : 
//[Work_Estimate];"LineEntry"
//  `Control the visibility of the AcceptReviewer button and label

// **********  ` Modified by: costasmanousakis-(Designer)-(12/4/07 11:39:57)
// Modified Method(s) : 
//NewTellServer
//  `Set the folder where the transfer log files are supposed to be stored.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/4/07 16:37:38)
// Modified Method(s) : 
//G_SecureInspection
//  ``make sure the tables are readonly if inspection locked. This way the inspection record 
//  `is not locked for other users.
// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `make sure the Bridge MHD NBIS record is in readonly mode so we don't lock it.
//  `Also made sure that all tables are in readwrite when exiting the form.
//  `Also hide the 'Press this button' button until we exit the form...
//  `And unload any related records.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/5/07 10:13:40)
// Modified Forms : 
//[Work_Estimate];"Print3"
//  `Fixed object names and formats to allow displaying sub-items
// Modified Form Methods : 
//  `For items whose value is negative display them in a smaller font
// Modified Method(s) : 
//WKHR_Print
//  `Added code to print sub-items.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/6/07 14:34:03)
// Modified Form Methods : 
//[Inspections];"Dive Pr Pg 1"
//[Inspections];"Dive Pr  LowCl Pg1"
//  `Use the global arrays ◊ELMTDICT_Txt_as and ◊ELMTDICT_ELNum_ai instead of 
//  `doing selection to array locally.

// Modified Method(s) : 
//MakeInspection
//G_AddDefInspElmts
//  `Use the global arrays ◊ELMTDICT_Txt_as and ◊ELMTDICT_ELNum_ai instead of 
//  `doing selection to array locally.

// Modified Forms : 
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"Damage Pg1"
//[Inspections];"DamagePg1_v2"
//[Inspections];"Dive Pr  LowCl Pg1"
//  `Fixed style sheets on text and objects`

// **********  ` Modified by: costasmanousakis-(Designer)-(12/7/07 10:39:24)
// Modified Forms : 
//[Inspections];"FCPrPg1_v2"
// [Inspections];"RoutinePrPg2_v2"
//[Inspections];"SpecialExtra"
//  `Fixed style sheets on text and objects

// **********  ` Modified by: costasmanousakis-(Designer)-(12/10/07 10:15:10)
// Modified Method(s) : 
//IncSeqRemote
//  `1-declare arguments
//  `2-add return value the error code
//GetServerBIN
//  `Error check from IncSeqRemote
//TellServerGRD 
//TellServerNRC
//G_UpdateServerActLog
//  `better trapping of OP errors `Error check from IncSeqRemote

// Modified Forms : 
//[Standard Photos];"Standard Photos"
//  `Deleted one of the [Standard Photos]Portrait fields on the form.
// Created Method(s) : 
//INSP_StdPhotoType_OM
//  ` Handle the Picture Type dropdown in the
//  ` [Standard Photos];"Standard Photos" form and form method

// Modified Form Methods : 
//[Standard Photos];"Standard Photos"
//  `Use method INSP_StdPhotoType_OM
// Modified Object Methods : 
//[Standard Photos];"Standard Photos".aPictType
//  `Use method INSP_StdPhotoType_OM.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/11/07 17:01:59)
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//  `More descriptive Confirm statement; Cannot change if it has been approved by DBIE.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/12/07 14:38:03)
// Modified Menu
//MenuBar BridgeListMenu, Menu Records, Item 'Load BINs from text file'
//  `Renamed item to 'Search from text file...'
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bAddInsp
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//  `Enabled the On Load event on the form objects, and set them visible only for members
//  `of the MHDInspectionRWAccess user group.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/17/07 09:56:17)
// Modified Method(s) : 
//G_CheckRoutineInsp
//G_CheckCulvertInsp 
//G_CreateImageLog
//  `Combine selection to array commands

// Modified Method(s) : 
//INSP_DeleteLocalInsp
//G_DeleteInspection
//  `Fix in FlushGrpDeletions code
// Modified Object Methods : 
//[ExtendTime_Maintenance];"ExtTime In".btnDelte
//  `Fix in FlushGrpDeletions code
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//  `Don't allow inspections that are in the review process : after completion
//  `Delete BMS inspections and CUS when switching from a routine type inspection

// Modified Forms : 
//[Standard Photos];"Standard Photos"
//  `Added hidden button to trap the ESC key; Assigned the Enter key to the save button;
//  `Added filter and Min,Max numbers to the sequence field.

// Modified Object Methods : 
//[Town Address];"View Town Address".aDistrictSelect
//  `Declare the aDistrictSelect array on the On Load event.

// Modified Method(s) : 
//P_ReviewInspcts
//  `Use sets instead of arrays to merge inspections.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/18/07 15:38:59)
// Created Method(s) : 
//Server_UpdateSDFO
//  ` Run an update for AASHTO and the SD FO status.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/19/07 10:11:11)
// Modified Method(s) : 
//INIT_FIELDS_DES 
//  `Added IsPar_b array for element dict
//  `Fixed the filling of arrays ◊aInspType,◊aInspCod,◊aCulvertI,◊aCulInspCod.
//ut_CompareStoredBlobData 
//ut_RetrieveBlobDocument 
//   `Added IsPar_b array for element dict

// Modified Form Methods : 
//[Inspections];"Routine Combined"
//[Inspections];"Culvert Combined"
//  `Use the ◊aInspCod, ◊aCulvertI arrays if they are populated. 

// **********  ` Modified by: costasmanousakis-(Designer)-(12/20/07 08:53:51)
// Modified Object Methods : 
//[Inspections];"InspectionReview".GetAllDistrInsp
//[InventoryPhotoInsp];"ReviewDialog".GetAllDistrInsp
//  `Use var ◊CurrentUser_UID

// Modified Method(s) : 
//INSP_GetUserAgency
//  `Use var ◊CurrentUser_UID

// Modified Method(s) : 
//G_GetElmtLabel
//  `Use the ◊ELMTDICT_@ arrays instead of the table and pushing poping records for parent.
//Print_Dive_Cmt_a_new 
//Print_RTN_Cmts 
//Print_CUL_Cmts 
//Print_DefElement_Cmts 
//INSP_FCPrPg1_FM
//  `Use the ◊ELMTDICT_@ arrays instead of relate many

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Set  [Element Cat] [ElementDict] tables to read only

// Modified Method(s) : 
//G_RoutinetoBMS 
//  `Use the single axle posting if it is not zero and apply equal to the SIA record 2,3,5 axle

// **********  ` Modified by: costasmanousakis-(Designer)-(1/2/08 10:40:43)
// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Added MTA users

// **********  ` Modified by: costasmanousakis-(Designer)-(1/4/08 12:31:01)
// Created Method(s) : 
//SIA_ReleaseBridgeRec
//  ` Release the current Bridge record.

// Modified Form Methods : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Release the current bridge record
//[Bridge MHD NBIS];"SI & A Input" 
//[Bridge MHD NBIS];"ID Input"
//[Bridge MHD NBIS];"Other Info"
//  `Release the curr bridge rec if the user is not part of the SIAAccess group
//[Bridge MHD NBIS];"CombinedInspections
//[Bridge MHD NBIS];"Cslt Insps
//[Bridge MHD NBIS];"Cslt Ratings
//[Bridge MHD NBIS];"2nd Records
//[Bridge MHD NBIS];"InventoryPhoto
//  `Release the curr bridge rec 

// **********  ` Modified by: costasmanousakis-(Designer)-(1/7/08 10:16:55)
// Modified Table Relation(s) : 
//  `Made relation between Conslt_Name] and [PRJ_DesignContracts] automatic both ways

// Modified Forms : 
//[Activity Log];"Input"
//  `Adjusted page 2 and added a subform for [FileIDRes Table]; with query buttons.
//[FileIDRes Table];"Output"
//  `Adjusted sizes of objects; made all fields, vars non-enterable; added style sheets.

// Modified Forms : 
//[Contract_Maintenance];"Contract Maintenance Out"
//  `Changed title to Preservation Consultant Contracts.
//  `Added drop down object CM_SelByStatus to select contracts by contract status.

// Modified Method(s) : 
//M_ListContractMaintenance
//  `Changed name of process to PreservationContracts
//P_ListContractMaintenance
//  `Consider input output form widths and heights for the window size.
//CM_SortOutputList
//  `When doing default sort  set the vSortContract var to 1.

// **********  ` Modified by: costasmanousakis-(Designer)-(1/8/08 12:03:54)
// Modified Method(s) : 
//SRC_SearchByBridge
//  `Moved the COPY NAMED SELE before the dialog to properly handle the cancel
//  `so we return to the original selection.

// Modified Object Methods : 
//[Dialogs];"Search Bridge".bFind
//  `Modified to detect the Control(win) or Command(Mac) key, in which case
//  `we attempt to search of stuff that is in the clipboard. What is searched for
//  `is controlled by the length of the first 'element' in the clipboard.
//  `if len=3 then it is BIN , if len=6 then it is BDEPT.
//  `Will handle Bdepts in form X-XX-XXX by stripping the "-", but 
//  `anything else will not be used.

// Modified Method(s) : 
//SRC_DeclareBrgVars
//  `Added var SRC_HideLooking_b

//CreateRandomSet
//  `Use var SRC_HideLooking_b

// **********  ` Modified by: costasmanousakis-(Designer)-(1/9/08 13:25:24)
// Created Method(s) : 
//ut_ClipBoardSearch
//  ` Search a table by a field from text stuff in the clipboard

// **********  ` Modified by: costasmanousakis-(Designer)-(1/14/08 16:53:10)
// Created Method(s) : 
//ut_ReLog_PERSGroups 
//  ` Re-Create Activity Log entries for records in the [PERS_Groups] table
//  ` and the related records in [PERS_GroupMembers]
//ut_Relog_PersonnelRecs
//  `Relog records in the [Personnel] table for transfer to districts.

// **********  ` Modified by: costasmanousakis-(Designer)-(1/17/08 10:33:06)
// Modified Method(s) : 
//InitFOSDFields
//  `Make sure the bridge table is RW

//ControlMenuBar
//  `Give access to the Data menu to members of Inspection Admin only when in Client.
//  `In Standalone apps everybody will be able to run the AASHTO Calc and SD FO setting.
//  `The items "Fix Location" and "Set Item 75" have been moved under the Amdin tasks custom menu.

// **********  ` Modified by: costasmanousakis-(Designer)-(1/22/08 12:10:05)
// Modified Form Methods : 
//[ElementsSafety];"Safety Elm Inp Dive"
//[ElementsSafety];"Safety Elm Inp DiveS"
//[ElementsSafety];"Safety ElmInput"
//[ElementsSafety];"SafetyElementInputEx"
//  `Fixed code to correctly cancel the form on a new record. before it was continuing in the form.

// Created Method(s) : 
//INSP_ElmSft_Inc_FM
//  `Method for the include forms in [ElementsSafety]. Uses arrays.

// Modified Form Methods : 
//[ElementsSafety];"Inc Safety Crit"
//[ElementsSafety];"Inc. Safety"
//[ElementsSafety];"Inc. Safety Clsd"
//  `Use new method INSP_ElmSft_Inc_FM

// Created Method(s) : 
//INSP_ElmSft_Input_FM
//  `Method for the input forms in [ElementsSafety]. Uses arrays.

// Modified Form Methods : 
//[ElementsSafety];"Safety Elm Inp Dive"
//[ElementsSafety];"Safety Elm Inp DiveS"
//[ElementsSafety];"Safety ElmInput"
//[ElementsSafety];"SafetyElementInputEx"
//  `Use new method INSP_ElmSft_Input_FM

// **********  ` Modified by: costasmanousakis-(Designer)-(1/23/08 12:13:05)
// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".btnDelete
//  `Delete the related work hour estimate if there is any. Will not delete if the Work estimate is locked somehow

// **********  ` Modified by: costasmanousakis-(Designer)-(1/24/08 09:29:49)
// Modified Forms : 
//[PRJ_ProjectFile];"PRJ_Selection.o"
//  `Added field  [PRJ_ProjectFile]PF_Description_txt; resized existing fields; text alignments;
//  `made form resizable so that more of the descri field can be seen; added sort by filenumber to the
//  `show all, show subset, query buttons; changed the show all button to show only filenumbers > 0.

// **********  ` Modified by: costasmanousakis-(Designer)-(1/25/08 10:11:06)
// Created Method(s) : 
//FN_IFF
//  ` IF function. Returns a text depending on the 1st param.
//  ` Ex.
//  ` $Result_txt:=FN_IFF (($a>$b);"A is greater than B";"A is not !!!")

// Modified Form : 
//[zSpecialReports];"Output"
//  `Added sorts to all relevant buttons.

// Created Method(s) : 
//ut_WarmUpDatabase
//  ` Perform a 'Warm-up' of the database, by attempting to create and 
//  ` then delete a record. To be used during startup of a standalone compiled
//  ` app or on server startup.

// Modified Method(s) : 
//On Server Startup 
//Startup
//  `Use Method ut_WarmUpDatabase

// **********  ` Modified by: costasmanousakis-(Designer)-(1/29/08 10:40:01)
// Created Method(s) : 
//M_ExecArchiveLog
//  ` Method to execute the archive Log to file operation,
//  ` either locally or on the server.
