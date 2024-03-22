//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2009_10
// User name (OS): charlesmiller
// Date and time: 10/01/09, 13:41:28
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_10  // CJ Miller`10/01/09, 13:41:30   
End if 
//Modify what and how attributes are retrieved
//Modified stored sql call named sp_RTRVAttributes in parameters table
//New records in parameters table named PRJ_TypeCode and PRJ_TypeDescription, whcih was filled from tish
//Create new export for Bridge Scour Category report

//ut_BridgeScourReport

//Add Item 2 to page 0 (District)
//PRJ_LoadBridgeData 
//Compiler_PRJ 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//End Mods_2009_10

// **********  ` Modified by: costasmanousakis-(Designer)-(10/2/09 09:03:40)
// Modified Method(s) : 
//ut_BridgeScourReport
//  `Moved initialization of text variables so they are cleared for each BIN.  
//  `Added Progress bar

// **********  ` Modified by: costasmanousakis-(Designer)-(10/7/09 10:37:14)
// Modified Method(s) : 
//PRJ_BPGM_PrintSelection
//  `added Set Print option, Print Settings and the ">" param in the Print Selection command

// **********  ` Modified by: costasmanousakis-(Designer)-(10/8/09 16:15:14)
// Modified Method(s) : 
//ut_BridgeScourReport
//  `Added Items 2,41, 61, and 113 in the output; Get Only NBI records

// **********  ` Modified by: costasmanousakis-(Designer)-(10/13/09 14:27:37)
// Created Method(s) : 
//SIA_ScourRank_OM
//  ` define and control display/printing of Scour Priority values in SIA forms
//  ` Uses new 4D User group "BridgeScourRankDisplay"
// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Added display of Scour Categry and rank; call SIA_ScourRank_OM in form method

//Add check to make sure triggers run only on inside data base
//On startup
//On server startup

// **********  ` Modified by: costasmanousakis-(Designer)-(10/27/09 15:21:42)
// Modified Method(s) : 
//G_InitInspVars 
//G_Insp_SetDeptFont
//  `MassDOT change

// **********  ` Modified by: costasmanousakis-(Designer)-(10/30/09 12:55:40)
// Modified Method(s) : 
//SIA_SecureInputForm
//  `Added code to secure Item 113
// Modified Forms : 
//[Templates];"Input"
//  `Added buttons to save 4D write are to db field, and to flip thru the references


// **********  `
//Mods_2009_10 ("MASSDOT")
//Modifications for the transition to MASSDOT
// Created Method(s) : 
//STATREP_GetFieldPTR
//  ` get a pointer to a field in [status report] from the name
//STATREP_DistrNo
//  ` Get the district number based either on Item 2 or BDEPT
//ut_Distr6Towns
//  `A query for the records in [Town Data] that will be part of the new D6

// Modified Method(s) : 
//G_InitCondRepVars
//  `Added D6 variables ; and a series of variables starting with STATREP_
//fStateBridge
//  `Use the new DOT designation for a State bridge
//GenerateCondRep
//  `Modified to use new STATREP_ variables and methods for ease of coding;
//  `include the new LegacyOwner field in the arrays,  so that an 'old' version of report
//  `can be generated.
//DataToCondRep
//  `Use the new STATREP_GetFieldPTR and STATREP_arrays  to simplify coding
//PrepReportTotal
//  `Use the new STATREP_GetFieldPTR and STATREP_arrays  to simplify coding
//PrepStatusRep
//  `Use the new STATREP_GetFieldPTR and STATREP_arrays  to simplify coding
//prt_substdrep
//  `modified to give multiple print form options to designer
//ControlMenuBar
//  `Change text on enter menu, to indicate Insp. by
//M_GetMHD_NBI 
//M_GetMHDnonNBI 
//  `Use the new DOT designation 

// Modified Forms / Form Methods : 
//[zDialogs];"FilesPalette"
//  `Added a text to indicate that buttons are by inspection responsibility
//[Status Report];"I_StatusReport"
//  `Made form changes to add District 6 and change the logo; also 
//  `changed the delete button to invis when not allowed to delete
//[Status Report];"O_StatusReport"
//  `change the logo; also 
//  `changed the delete button to invis for all except designer
// Created Form(s) : 
//[Status Report];"P_StatusReport_MDOT"
//  ``New DOT report with all 6 districts.
//[Status Report];"P_StatusReport_MDOT_5D"
//  ``New DOT report but with 5 districts shown

// Modified Method(s) : 
//Server_GenCondRep
//  `modified to generate two status reports , one with DOT ,one using legacy owner
//Mail_BridgeStatusRpt
//  `create and mail two reports; one normal the other using the legacy owner
