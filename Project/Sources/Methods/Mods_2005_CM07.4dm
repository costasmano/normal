//%attributes = {"invisible":true}
//15-Feb-2005 *************

//Modified Method
//SD_NewSummaryReport 
//  `Added code to provide totals;
//  `Changed page numbering scheme to 31 lines per page
//  `Added Last Page Break to spool print Job.

//Added Form
//[SD_History];"SummaryBreak.rpt"
//  `To print Totals in summary report.

//Modified Method
//bDataFileLocked  
//  `Use an non-Empty table ([Months]).
//***** TRANSFERED TO SERVER ****** Mods_2005_CM05

//Modified Method
//ArchiveLogFile    
//  `Flush buffers at display intervals.
//***** TRANSFERED TO SERVER ****** Mods_2005_CM05

//Modified Object method
//[Inspections];"InspectionReview".bzApprove 
//  `Log date approved by DBIE or AreaEngineer.
//***** TRANSFERED TO SERVER ****** Mods_2005_CM05

//Modified Method
//Server_GenCondRep 
//  `Added code to run the SD_CreateMonthlyData method on the first of the month.

//Modified Method
//INIT_UI_GV
//  `Added declaration for variable ◊InspFormRevDate_2
//***** TRANSFERED TO SERVER ****** Mods_2005_CM05

//Created Methods
//f_Insp_Revision2 
//G_Insp_ApplyRev2_PR 
//G_InspConsCompany 
//  `Created to print the Consultant QC Engineer Box in inspection forms.
//***** TRANSFERED TO SERVER ****** Mods_2005_CM05

//Modified Forms:
//[Inspections];"Closed Insp Pg1"
//  `Implement consultant QC MGR signature Box.
//***** TRANSFERED TO SERVER ****** Mods_2005_CM05

//Modified Method
//bDataFileLocked 
//  `Use new Is Data File Locked 4D command.

//Modified Form Method
//[Inspections];"SpecialExtra"
//  `Fixed error in assigning pointers to vRemarks variables.

//Modified Method
//ControlServerProcesses 
//  `Fixed code defining $Hour; Added a 2 min delay before starting loop.