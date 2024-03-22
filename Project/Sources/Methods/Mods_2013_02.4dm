//%attributes = {"invisible":true}
//Method: Mods_2013_02
//Description
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/07/13, 09:00:37
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2/7/13)
// Modified Method(s) : 
//ut_CreateSQLVariables
//  `Added complete method code including comments and date of update.
//  `Also can update the methods themselves 

// Modified Forms : 
//[ScourPOA];"Input-A"
//[ScourPOA];"FieldVerificationCardpg1"
//[ScourPOA];"Print4-A"
//  `Changed NOAA label from "Stage (WSE) at Gage" to "Storm Surge at Gage"


//**********`Modified by: Costas Manousakis-(Designer)-(2/11/13)
// Modified Method(s) : 
//LB_ShowSelection 
//LB_OmitSelection
//  `Run only if records have been selected

//**********`Modified by: Costas Manousakis-(Designer)-(2/12/13)
// Modified Method(s) : 
//Duplicate_Inspection
//  `Clear the in-depth review flag also

//ut_DocumentUniqueKeys 
//Fix printed inspection forms where dot and mbta dat appearing at the same time
//Fix object names which where DOTEngineeer or MBTAEngineeer. Engineeer was mispelled and fixed to read Engineer 

//Create new table [ScourCriticalInfo] and forms to match
//Compiler_ScourCriticalItems 
//New list item named UB Item for 113 in table of lists
//[ScourCriticalInfo];"Input"
//SIA_BridgeInput_FM
//[Bridge MHD NBIS];"Bridge Input"
//SIA_BridgeInput_FM
//SC_ScourCriticalButton_OM
//Create new group named ScourCritical

//r001 ` Allow for different headings on weights
//COMPILER_Inspections 
//INSP_SetWPHeadings 
//INSP_CulvertPrPg1_FM 
//INSP_DamagePg1_FM
//INSP_FCPrPg1_FM 
//INSP_RoutinePrPg2_FM
//INSP_ElmSft_Input_FM
//INSP_FormatTitle_new
//INSP_SetWPHeadings 
//[Inspections];"Routine Pr Pg 1"
//[Inspections];"Routine Pr Pg 2"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"Damage Form"
//[Inspections];"Damage Pg1"
//[Inspections];"SpecialExtra"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"DamagePg1_v2"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"RoutinePrPg2_v2"
//[Inspections];"Railfc_rr_p1"
//[Inspections];"RailRoutine Culvert"
//[Inspections];"MHD_Special_Member98"
//[Inspections];"RailCulvertCombined-RRC"
//[Inspections];"RailRoutine Arch Pr Pg 2"
//[ElementsSafety];"Safety ElmInput"
//[ElementsSafety];"SafetyElementInputEx"
//[Conslt Rating];"Rating Print Form"

//Modified so that we can use either new method or old based upon bridge owner
//G_Insp_FormatTitle


//Created so that we can have two nbis stack info forms
//NBIS Stack Info` new form
//[Bridge MHD NBIS];"NBIS Stack Info MBTA"

//NBIS Stack Info MBTA 
//NBISStackInfo_FM
//P_MBTA
//BRGList_SortControl 


// Allow for different headings on weight postings
//INSP_SetWPHeadings 
//COMPILER_Inspections
//INSP_CulvertPrPg1_FM
//INSP_DamagePg1_FM
//INSP_FCPrPg1_FM 
//INSP_RoutinePrPg2_FM 
//INSP_ElmSft_Input_FM 

//Forms and related form methods
//[ElementsSafety];"Safety ElmInput"
//[Inspections];"RailRoutine Arch Pr Pg 2"
//[Inspections];"RailCulvertCombined-RRC"
//[Inspections];"MHD_Special_Member98"
//[Inspections];"RailRoutine Culvert"
//[Inspections];"Railfc_rr_p1"
//[Inspections];"RoutinePrPg2_v2"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"DamagePg1_v2"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"Culvert Combined"
//[Inspections];"Routine Combined"
//[Inspections];"SpecialExtra"
//[Inspections];"Damage Pg1"
//[Inspections];"Damage Form"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Routine Pr Pg 2"
//[Inspections];"Critical Member"

//**********`Modified by: Costas Manousakis-(Designer)-(2/22/13)
// Created Method(s) : 
//DEV_UPDATE_STRUCTURE_LOG
//  `/*Log changes to the structure of the database
//  `Can run at any time  `
//  `creates two files: structure_log & strucuture_data
//  `and keeps them in a folder call _structure_log next to the
//  `database strucutre.

// Modified Method(s) : 
//QR_BridgeArea_r
//  `Added optional parameters for all items

//ut_ControlClone
//  `Added short message at the start

//End Mods_2013_02