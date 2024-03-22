//%attributes = {"invisible":true}
//mods in printing inspections 
//cleans up the page setups,
//cleans up the 4d write printing
//so that can make one print job
//the job goes to same printer when switching from land-portrait
//with a given name

// Modified Method(s) : 
//G_Insp_FontAlert
//  `Check with a process var if alerted previously
//G_InitInspVars
//  `initialize the vInsp_FontAlertShown var on the On Load form event

// Modified Forms : 
//[Inspections];"Culvert Pr Pg 2"
//  `Removed the 4D Write area ; replaced with a pic variable
// Modified Form Methods : 
//[Inspections];"Culvert Pr Pg 2"
//  `Removed 4D Write code

// Created Form(s) : 
//[Inspections];"CmtsPrint"

// Created Method(s) : 
//INSP_ViewAllComments
//INSP_PRN_InitVars

// Modified Method(s) : 
//PRINT_CULVERT_F
//Print_CUL_Cmts 
//PRINT_ROUTINE_F
//Print_RTN_Cmts 
//PRINT_Critical 
//Print_Dive_F
//PRINT_Closed
//Print_Dive_Cmt_a_new
//G_Insp_AddGenCmts
//G_Insp_AddOrientation
//G_AddElmtTxt2Area 
//G_addItemtoWr 

//G_GetElmtLabel 
//  `Added code to add a header for sub-items 60.1.x, etc
// Created Method(s) : 
//f_Insp_Revision3 
//  `To check for rev 3
// Modified Method(s) : 
//INIT_UI_GV 
//  `Added var ◊InspFormRevDate_3

//Print_DefElement_Cmts
//  `Use the new ver of G_GetElmtLabel

// Modified by: costasmanousakis-(Designer)-(1/14/2007 21:26:23)
// Modified Object Methods : 
//[Inspections];"Culvert Combined".vbPGPreview
//[Inspections];"Routine Combined".vbPGPreview
//  `Do not Reload bms insp if [Combined Inspections]BMSInspID <=0

// Created Method(s) : 
//INSP_PreviewBtn_OM
//  `To be used from preview buttons in Damaga and critical forms

// Modified Object Methods : 
//[Inspections];"Damage Form".vbPGPreview
//[Inspections];"Critical Member".vbPGPreview
//  `Use new method INSP_PreviewBtn_OM

// Modified by: costasmanousakis-(Designer)-(1/17/2007 10:28:11)
// Modified Form Methods : 
//[zSpecialReports];"Input"
//  `Changed var ZSPRPT_LogActivity_b to true

// Modified Method(s) : 
//G_ListTable
//  `Added call to menu bar(3)

// Created Method(s) : 
//ut_SelectFieldNum 
//ut_SelectTableNum 
//ut_CustomTableExport
//ut_CustomTableLoad 
//ut_LogCompleteTable

// Modified by: costasmanousakis-(Designer)-(1/17/2007 15:09:11)
// Modified Method(s) : 
//G_WRT_MakeDocument
//  `Added code to better handle extensions of files created.
//  `Win and Mac documents get the .DOC extension.
//  `Also added a 5th property set

//CM_CreateDocument
//  `Use method G_WRT_MakeDocument with set 5
//G_WRT_BrInspRpt
//  `Use method G_WRT_MakeDocument with set 4
//M_WRT_GenericBridgeLetter
//  `Use method G_WRT_MakeDocument with set 4
//M_WRT_BrInspRpt
//  `Use method G_WRT_MakeDocument with set 4
