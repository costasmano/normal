//%attributes = {"invisible":true}
// Method: Mods_2015_01
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 01/05/15
	// ----------------------------------------------------
	// First Release
	Mods_2015_01
End if 

// Modified by: manousakisc (1/5/2015)

// Created Form(s) : 
//[Inspections];"TunnelDamagePg1"
//[Inspections];"TunnelDamageForm"

//modified form method
//[Inspections];"BlankCombinedStarter"
//  `Added Tunnel damage type "TDA"

// Modified Object Methods : 
//Object Method: [Inspections].Tunnel Template.bPrint
//  `added TDA : tunnel damage

// Modified Method(s) : 
//PRINT_Critical
//Print_Dive_Cmt_a_new 

//INSP_PreviewBtn_OM 
//INSP_FCPrPg1_FM 
//INSP_UpdateInspList 
//SIA_OnDisplayDetail 
//INSP_ReturnCMLength 
//INSP_SetSpMbPrintForm 
//FM_SpecialExtra
//  `added TDA : tunnel damage
//INSP_SaveRecords 
//  `check for tunnel inspections starting with "T"

//**********`Modified by: Costas Manousakis-(Designer)-(1/12/15)
// Modified Table(s) : 
//[Inspections]
//  `added field [Inspections]InspDBIE1stApprDate


// Modified Forms : 
// [ScourPOA];"Print2-A"
//  `changed labels, rasized objects per request from CHA
// [ScourPOA];"Summary-A"
//  `adjustments in labels and order of channel scour / uw insp

// Created Method(s) : 
//Method: ut_TempUpdateScourCritCmts
//  ` method to load into [ScourCriticalInfo] comments from a text file 
//  ` text file is tab delimited two columns BIN, comments.
//  ` After import, need to execute Relog records for [ScourCriticalInfo] to transfer info to other servers

//**********`Modified by: Costas Manousakis-(Designer)-(1/13/15)
// Modified Forms : 
//[ScourPOA];"Print4-A"
//  `changed wording of 3f.
// [ScourPOA];"Print6-A"
//  `removed Priority str countermeasure from here - stays on summary
//[ScourPOA];"Input-A"
//  `cleanup 

// Modified Method(s) : 
//SCPOA_FldMonPgmChecks
//  `need to run  SCPOA_MonitorChecks  after changing SCPOA_OtherMonitDev_L this links also to section 6b as needed

//**********`Modified by: Costas Manousakis-(Designer)-(1/14/15)
// Created Method(s) : 
//Method: fn_MinBridgeCondition
//Description
//  ` Return the minimum bridge condition based on items 58,59,60,62
//  ` will return -1 if all items are not numeric
//  `Can either pass 1-4 ratings (string 1) or if not passed will use current Bridge record
// Parameters
// $0 : $MinBridgeCond_L 
// $(1-4) : $cond1-4_s : optional : 
//Method: fn_BridgeCondMeasure
//Description
//  ` will return either "GOOD", "FAIR" or "POOR" based on FHWA Performance meeasure
//  ` 9-7 = Good , 6-5 = Fair , 4-0 = Poor
// Parameters
// $0 : $BridgeCondMeas_s
// $1 : $MinBridgeCond_L (optional - if not passed will use the min cond of current bridge record)

//**********` Modified by: Costas Manousakis-(Designer)-(1/15/15 17:05:25)
// Created Method(s) : 
//Method: INSP_FieldWorkComplCheck
//Description
//  ` Check if field FieldWorkCompleteDate has been entered.
//  ` intended to be called before inspection is marked as complete.
//Method: INSP_FieldWorkComplEntry
//Description
//  ` Set the visibility of field FieldWorkCompleteDate

// Modified Method(s) : 
//INIT_UI_GV
//  `added ◊INSPFORMREVDATE_8
//G_Insp_SaveInspection 
//  `added check for INSP_FieldWorkComplCheck, and autofill [Inspections]InspCompleteDate
//Duplicate_Inspection
//  `added  initializing of new date tracking fields 
// Method: INSP_ReviewAction
//  `remove version checks - now all is effective


// Modified Forms : 
//[Inspections];"Critical Member"
//[Inspections];"Closed Bridge"
//[Inspections];"Routine Combined"
//  `INSP_FieldWorkComplEntry

//**********` Modified by: Costas Manousakis-(Designer)-(1/16/15 10:47:07)
// Modified Form
//[Inspections];"Dive Form"
//[Inspections];"Underwater Special Member"
//[Inspections];"Dive LowCl" 
//[Inspections]StormDamageInspection 
//  `added fiield [Inspections]InspFldWorkComplDate  `  `

//[Inspections]Dive Template 
//  `added obj method to the vInspTitle var to run on Load INSP_FieldWorkComplEntry

// Modified Object Methods : 
//[Inspections].Dive Template.vInspTitle
//  `Call method INSP_FieldWorkComplEntry on load
//ZZ8 form [inspections]Dive Form
//  `Addition of INSP_FieldWorkComplCheck

// Modified Forms : 
// [Inspections]CustomInput
//  `added new  inspections tracking fields

// Modified Method(s) : 
// Method: INSP_SaveRecords
//  `check for tunnel inspections starting with "T"
//Compiler_Inspections
//  `added  C_DATE(◊INSPFORMREVDATE_8)
//  `added  INSP_FieldWorkComplCheck

// Modified Forms : 
//[Inspections];"RailRoutinePrPg1"
//  `fix  : vRN59_8 was incorrectly coded as vRN59_7


//**********`Modified by: Costas Manousakis-(Designer)-(1/29/15)
// Modified Method(s) : 
//maximo_UpdateMaximo
//  `Added check if inspection has any records in [standard photos]
