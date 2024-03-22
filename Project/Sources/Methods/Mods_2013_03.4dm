//%attributes = {"invisible":true}
//Method: Mods_2013_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/06/13, 16:34:33
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(3/6/13)
// Modified Method(s) : 
//G_CopyPontisToCombined
//  `Filter out inspections with no CUs before displaying the list of dates

//**********`Modified by: Costas Manousakis-(Designer)-(3/11/13)
// Modified Method(s) : 
//PreviewCurrentPhoto
//  `Added missing  ":"  at the end of the Photo numbers

//PRINT_Damage
//  `Use method  G_CountSpInspPgs

// Modified Object Methods : 
//[Standard Photos]Standard Photos.vbPrintImages
//  `Added the Rail Inspections when counting inspection pages

//
//Add items and to allow for custom sort when displaying mbta bridges
//[Bridge MHD NBIS];"NBIS Stack Info MBTA"
//mbta_ReturnBridgeType 
//mbta_ReturnHwySelection
//mbta_SortRecords 
//BRGList_SortControl 
//Created so that we can have two nbis stack info forms
//NBISStackInfo_FM

//r001 ` 
//Modified by: Charles Miller (3/12/13 16:36:46)
//Change alerts and messages for MBTA based upon group
//INSP_ReviewAction 

//Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
//SIA_BridgeInput_FM 
//[Bridge MHD NBIS];"Bridge Input"
//[Bridge MHD NBIS];"Cslt Insps"
//[Bridge MHD NBIS];"InventoryPhoto"
//[Inspections];"Critical Member"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"Closed Bridge"
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Damage Form"
//[Inspections];"Damage Pg1"
//[Inspections];"Routine Combined"
//[Inspections];"Culvert Combined"
//[Inspections];"Pontis Form"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"DamagePg1_v2"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"FrzThawPg1"
//[Inspections];"FreezeThaw"
//[Inspections];"RailRoutineInput"
//[Inspections];"RailRoutinePrPg1"
//[Inspections];"Railfc_rr_p1"
//[Inspections];"RailRoutine Culvert"
//[Inspections];"RailRoutine Arch Pr Pg 1"
//[Inspections];"MHD_Special_Member98"
//[Inspections];"PedestrianInspection-PED"
//[Inspections];"RailCulvertCombined-RRC"
//[InventoryPhotoInsp];"ReviewDialog"

//Add code for access for MBTA users Group MBTA ad MBTA_RO
//Form Method: [Bridge MHD NBIS];"SI & A Input" 

//**********`Modified by: Costas Manousakis-(Designer)-(3/13/13)
// Created Method(s) : 
//SR_ut_AddColumnsToStatusRpt
//  ` Add new colums to table [Status Report]
// Created Method(s) : 
//SR_CalculateAreas 
//  ` Calculate the variables used in the 'input' and print forms for
//  ` display of deck areas.
// ` Will do either straight display or convert to english SqFT based on STATREP_ENGLISH_b
//  ` Data is assumed to be in metric
//SR_StatusRptPrint_FM
//  ` form method for the printed bridge status reports
//SR_ut_MakeDirectives
//  `CODE THAT GENERATES COMPILER DIRECTIVES FOR VARIABLES USED
//  `IN THE STATUS REPORTS

// Modified Method(s) : 
//DataToCondRep 
//  `Clean up code
//GenerateCondRep
//  ` Added the new metric of SD by deck area calculations
//PrepStatusRep
//  ` Call  SR_CalculateAreas at the end of method
//G_InitCondRepVars 
//  `Clean up code, removed code that generates compiler directives to a new method SR_ut_MakeDirectives
//Compiler_SR
//  ` Added the new metric of SD by deck area calculations
//ut_SRVMonthlyReports
//  `Added  STATREP_ENGLISH_b:= true for new SD by deck area reports
//prt_substdrep
//  `Added to the list the _old reports

// Modified Forms : 
//[Status Report];"I_StatusReport"
//  `Added 4 pages for the new metrics by bridge deck area

//[Status Report];"P_StatusReport_MDOT_5D"
//[Status Report];"P_StatusReport_HI"
//[Status Report];"P_StatusReport_MDOT"
//  `Renamed to @_old

// Created Form(s) : 
//[Status Report];"P_StatusReport_MDOT_5D"
//[Status Report];"P_StatusReport_HI"
//[Status Report];"P_StatusReport_MDOT"
//  `New forms with the new metrics

//*********
//********* End of release 6.0.9.c
//*********

// Modified Method(s) : 
//ut_CreateSQLVariables
//  `Decreased the limit of the text variable to 20000 from 25000 to avoid reaching the limit of a text var before adding the info for a table

//**********`Modified by: Costas Manousakis-(Designer)-(3/14/13)
// Modified Forms : 
//[ScourPOA]Print1-A
//  `Added var for checkbox SCPOA_SourceRefList_L  : not _P becauce it gets calculated only at print time

// Modified Method(s) : 
//SCPOA_PrintPG1_FM
//  `Added calc for checkbox SCPOA_SourceRefList_L 

//**********`Modified by: Costas Manousakis-(Designer)-(3/15/13)
// Modified Table(s) : 
//[Bridge MHD NBIS]
//[BridgeMHDNBISArchive]
//Added field
//[Bridge MHD NBIS]FHWAItem8-A 15
//[BridgeMHDNBISArchive]FHWAItem8-A 15

// Created Method(s) : 
//ut_PopulateFHWAItem8
//  ` Populate the new FHWAItem8 field in the [Bridge MHD NBIS] for NBI recrods only

// Modified Method(s) : 
//ExportNBI 
//  `Added $item8_txt to get FHWAItem8 field if it is populated

//**********`Modified by: Costas Manousakis-(Designer)-(3/18/13)
// Modified Method(s) : 
//SIA_BridgeInput_FM
//SIA_BridgeInpNavCTRL 
//  `Added code to enable MBTA users access to Rail Info button


//*********
//********* End of release 6.1.0
//*********

//**********`Modified by: Costas Manousakis-(Designer)-(3/22/13)
// Created Form(s) : 
//"EditLists"
//  `dialogue that allows modifications of lists 

// Created Method(s) : 
//ut_EditList
//  ` bring up a dialogue that allows modifications of lists 
//  `that are marked as editable by user in the design enviroment


//End Mods_2013_03