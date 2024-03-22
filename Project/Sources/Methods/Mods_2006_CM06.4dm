//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(8/11/2006 15:51:45)

// Modified Method(s) : 
//P_ReviewInspcts
//  `Made J Shutt same as G Krikoris.

// Modified by: costasmanousakis-(Designer)-(8/22/2006 10:11:30)
// Modified Method(s) : 
//G_WRT_GenericBridgeLetter
//  `Added code to generate a second town letter for townline bridges.

// Modified by: costasmanousakis-(Designer)-(8/28/2006 15:42:00)
// Modified Method(s) : 
//Startup
//  `Added option for designer not to have tables sorted on startup.

// Modified by: costasmanousakis-(Designer)-(8/29/2006 12:43:37)
//GetAreaBIEinfo
//  ` Sylvia is for d1,2,5 ; krikoris for others
//GetDBIEccInfo
//  ` Sylvia is for d1,2,5 ; krikoris for others

// Modified by: costasmanousakis-(Designer)-(8/29/2006 16:06:34)
// Modified Method(s) : 
//GetDHDinfo 
//GetDBIEinfo
//  `Modified formula that makes the name var to add space after Middle init. 
//  `also make sure there are no spaces in the MI

// Modified by: costasmanousakis-(Designer)-(8/30/2006 16:04:20)
// Modified Method(s) : 
//CM_PrintAddenAssignm_Letter
//  `Round the final numbers to 5 dec to avoid precision errors; 
//  `Use method G_WRT_MakeDocument to create the letter.

// Modified by: costasmanousakis-(Designer)-(8/31/2006 10:37:19)
// Modified Object Methods : 
//[Addendum_Maintenance];"Addendum In".AddendAssgnLtr
//  `Update the date only when user confirms.

// Modified by: costasmanousakis-(Designer)-(8/31/2006 11:42:30)
// Modified Method(s) : 
//P_ReviewInspcts
//  `Added Bruce Sylvia as area eng for 1,2,5

// Modified by: costasmanousakis-(Designer)-(8/31/2006 15:26:00)
// Modified Method(s) : 
//G_MyConfirm
//  `Added options to label Ok and Cancel buttons
// Modified Form Methods : 
//[Dialogs];"MyConfirm"
//  `change the label of the OK and Cancel buttons if needed.
//M_WRT_CsltInsp_Review
//  `Added check for some date errors in the records being printed;
//  `Made new distr of AreaEng districts 1,2,5 and 3,4;
//  `Set the tables to read only before and reset after

// Modified by: costasmanousakis-(Designer)-(9/1/2006 15:52:09)
// Modified Method(s) : 
//CM_UpdateInvoiceTotals
//  `Removed checking for 0 values for RetainageAmtInit and RetainagePct and then using defaults. 
//  `New contracts can have zero values for these.
// Modified Form Methods : 
//[Contract_Maintenance];"Contract Maintenance In"
//  `Removed default values for RetainageAmtInit and RetainagePct in new contracts.
//  `New contracts can have zero values for these.

// Modified by: costasmanousakis-(Designer)-(9/8/2006 10:47:52)
// Modified Object Methods : 
//[Contracts];"Contracts In".cboType
//[Contracts];"Contracts In".cboStatus
//  `Use POPUPMENUC to handle events
// Modified Forms : 
//[Contracts];"Contracts In"
//  `Added "Other/Emergency Services" at the cboType List.

// Modified by: costasmanousakis-(Designer)-(9/19/2006 12:26:45)
// Created Method(s) : 
//INSP_ut_FixTeamMember
//  `To  fix Team member mixups by replacing one team member Id with another. Scan both
//  `[Field Trip] and [BMS Field Trip] tables.

// Modified by: costasmanousakis-(Designer)-(9/19/2006 16:37:52)
// Modified Method(s) : 
//CIR_RecalcAddFunds
//  `Do not count Add funds if they are not approved (appr date #0)
//M_ContractRpt_Cost
//  `Do not show Add funds if they are not approved (appr date #0);
//  `include Fund transfers- assume they are approved.

// Modified by: costasmanousakis-(Designer)-(9/20/2006 09:02:29)
// Modified Method(s) : 
//M_ContractRpt_Assignment
//  `Fixed logic that average scores were calculated. Do avg per assignment only for completed.

// Modified by: costasmanousakis-(Designer)-(10/2/2006 14:18:48)
// Modified Form Methods : 
//[Conslt Rating];"View Cslt Rating"
//[Cons Inspection];"View Cslt Insp"
//  `Adjust the way the Assignment phase is displayed