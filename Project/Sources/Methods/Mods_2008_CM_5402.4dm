//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(1/29/08 12:04:09)
// Modified Method(s) : 
//P_ReviewInspcts
//  `Added MTA Insp approval check;
//  `Modified DCR to use the PERS_Group DCRInspApp.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/4/08 10:03:04)
// Modified Method(s) : 
//CM_PrintAmendment_Letter
//  `Modified to allow saving of record in order to continue with the printing of the letter.

// Modified Forms : 
//[Contract_Maintenance];"Contract Maintenance In"
//  `Increased the size of the ProjInfo button on page 1.

// Modified Method(s) : 
//ut_Request
//  `Declare ut_Request_Value_txt as text - helps with CTRL-V

// **********  ` Modified by: costasmanousakis-(Designer)-(2/13/08 14:14:09)
// Modified Form Methods : 
//[Dialogs];"TwoListMove"
// `Make Cancel button invisible, if the label is passed as "INVISIBLE"

// Modified Method(s) : 
//INSP_VerifySIAChanges
//  `Give CancelButton label invisible. so that only the PROCEED button is shown

// **********  ` Modified by: costasmanousakis-(Designer)-(2/15/08 16:41:17)
// Modified Method(s) : 
//M_DeficientElementRpt
//  `Sort the bridges by BDPET,BIN before printing

//Copied from ScourLib file
// table
// [Scour Report]
//Forms:
//[Scour Report];"I_ScourReport"
//[Scour Report];"Output"
//[Scour Report];"Scour Report - Agencies"
//[Scour Report];"Scour Report - Mass"
//[Scour Report];"Scour Report - State"
//[Scour Report];"Scour Report - Summary"

//methods
//M_ScourReport 
//P_ScourReport 
//ScourReport_Calculate 
//ScourReport_CreateRecord

// **********  ` Modified by: costasmanousakis-(Designer)-(2/19/08 11:10:10)
// Modified Method(s) : 
//ut_PontisUpdateInspections
//  `Move declaration of $RoundFactor_l,$Total_l outside loop; 
//  `Added call to set $RoundFactor_l after the loop;
//  `Go thru the CUs only if there are any in the selection.

// **********  ` Modified by: ChuckMiller-(Designer)-(2/22/08 08:31:22)
// Modified Method(s) : 
//SQL_ClearArrays
//SQL_FillBuiltStatements
// ut_prjRetrieveModifiedProjects
//  `Added retrieval of status for projects, if project is inactive the ad dates and other info
//  `will be 'zeroed-out' and description will be set to 'Inactive'   
// Modified Forms : 
//[PRJ_ProjectFile];"User.i"
//[PRJ_ProjectFile];"UserList.o"
//  `Added Description and Project type