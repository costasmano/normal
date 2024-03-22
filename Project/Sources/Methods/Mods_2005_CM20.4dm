//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(12/7/2005 12:38:20)
// Modified Table(s) : 
//[Conslt Rating]
//  `Renamed previous field DeleteMe to FinalCost_B
//[Cons Inspection Cost]
//  `Added boolean field FinalCost_B

// Modified Forms : 
//[Conslt Rating];"Cslt Rating In"
//  `In Actual cost page shrank and made noneditable the breakdown of direct costs;
//  `Enabled entry in total direct cost field and added object method to it;
//  `Added button for [Conslt Rating Cost]FinalCost_B field;
//  `Adjusted location/size of objects on pages 3 and 4.
//[Cons Inspection];"Cslt Insp In"
//  `In Actual cost page shrank and made noneditable the breakdown of direct costs;
//  `Enabled entry in total direct cost field and added object method to it;
//  `Added button for [Cons Inspection Cost]FinalCost_B field;
//  `Adjusted location/size of objects on page 3.

// Modified Form Methods : 
//[Conslt Rating];"Cslt Rating In"
//[Cons Inspection];"Cslt Insp In"
//  `Set actual detail direct costs to invisible;

// Modified Method(s) : 
//GetAreaBIEinfo
//  `Set it retrieve GK as distr 4-5 area engineer.
//P_AllBridges 
//P_DISTRICT1 
//P_DISTRICT2 
//P_DISTRICT3 
//P_DISTRICT4 
//P_DISTRICT5 
//P_MBTA 
//P_MDC 
//P_MTA 
//P_OtherAgc 
//P_LoadSelection 
//  `Increased window height to 456 to accomodate new button icons.

// Modified Forms : 
//[WorkHour_Config];"Input".AssignType
//  `Added Choise list to object AssignType; modified size and layout of objects.
//  `Added dropdown to select AssignType.

// Modified by: costasmanousakis-(Designer)-(12/8/2005 12:04:12)
// Modified Forms : 
//[WorkHour_Config];"Input"
//  `Added pulldown to copy values from another type.

// Modified Form Methods : 
//[WorkHour_Config];"Input"
//  `Added code to initialize to pulldown that copies values from other type.

// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".btnSave
//  `Added code to update, if necessary, fields in Work hour estimates related to
//  `this assignment.

// Modified Method(s) : 
//INSP_ImportInspection 
//  `Added Line to store the newly created [BMS Inspections]Inspection ID, so that it is properly
//  `assigned to the combined inspection.

// Modified Method(s) : 
//On Startup
//  `Added a 5 sec delay to the REGISTER CLIENT command.
//HI_CalcBridgeHIFields 
//  `Fixed check for ◊Abort statement - IFs were not in correct order.

// Modified by: costasmanousakis-(Designer)-(12/14/2005 12:42:28)
// Modified Object Methods : 
//[Contract Assignments];"Assignments In".btnRetrieveCost
//  `Added logic to get actual costs only if all projects for this assignment,
//  `have been marked as Rescinded or Completed and have Final Costs.

// Modified by: costasmanousakis-(Designer)-(12/15/2005 09:42:14)
// Modified Object Methods : 
//[Inspections];"InspectionReview".bzSearchLay
//  `If the user is designer allow search for the whole table, not just the selection.

// Modified by: costasmanousakis-(Designer)-(12/16/2005 11:12:33)
// Modified Method(s) : 
//G_Insp_SaveContinue 
//G_Insp_SaveInspection
//  `When checking for BMSInspID check if gt zero;
//  `Use Current date(*) and Current time(*) instead of  ◊LDifference , ◊hDifference.
//  `Use Method INSP_SaveRecords
//RememberCombined
//G_Insp_SetPersUI
//  `Adjusted the logic of re-loading other inspection records : 
//  `Check first if they are not loaded.
//  `Use Method INSP_CheckLinks

// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bOpenInsp
//  `Abort loading if there is a mismatch in relations 
//[Cond Units];"Cond Units In".vElemNo
//  `Added check for is new record, don't query [bms inspections] - if it is not here Cancel ;
//  `Also log the ElemID and Env when a new record is saved.

// Created Method(s) : 
//INSP_CheckLinks
//  `Extracted code from RemberInspections used elsewhere.
//INSP_SaveRecords
//  `Extracted code G_Insp_SaveInspection used in G_Insp_SaveContinue.

// Modified Method(s) : 
//G_DeleteInspection
//  `Execute the commands related to [Cond Units] only if there are
//  `[Cond Units] records.

// Modified by: costasmanousakis-(Designer)-(12/20/2005 15:30:02)
// Modified Method(s) : 
//WKHR_Print
//  `Added sorting of Arr_WKHR_CommentCat when sorting the comments 
//  `(- lead to mismatched labeling).

// Modified Forms : 
//[Work_Estimate];"Print3"
//[Work_Estimate];"Print4"
//  `Adjusted break levels and object positions for better printing on Windoz enviroment.

// Modified Form Methods : 
//[Cons Inspection];"Cslt Insp In"
//[Conslt Rating];"Cslt Rating In"
//  `Lock pulldown for Assignement status cboAssignmentStatus to only the
//  `Bridge Inspection Engineer.