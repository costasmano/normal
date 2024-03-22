//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/04/12, 10:23:46
//----------------------------------------------------
//Method: Mods_2012_12
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_12  //r001 ` 
	//Modified by: Charles Miller (12/4/12 10:35:41)
End if 
//Add print routines for new inspection types. This occurred on various days
//PED
//RRA
//RRR
//RRC
//Form Method: [Inspections];"BlankCombinedStarter"
//Compiler_NewInspReports
// Method: Object Method:[Inspections];"AboveWater Template" bPrint
//PRINT_ROUTINE_F
//[inspections];"PedBridge_p1"
//[Inspections];"PedBridge_p2"
//[Inspections];"RailRoutine Culvert"
//[Inspections];"RailRoutine Arch Pr Pg 1"

//MakeInspection 
//Temp_SetItem8 
//G_DefInspElmts 
//INSP_KiloPtValues 
//SIA_BrKeyPrefix_OM 
//SIA_BrkeyOwner_OM 
//INSP_PrintInspBtn_OM 
//PRINT_ROUTINE_F
//PRINT_CULVERT_F 
//[Inspections];"MHD_Special_Member98"
//[Inspections];"PedestrianInspection-PED"
//[Inspections];"RailCulvertCombined-RRC"


//**********`Modified by: Costas Manousakis-(Designer)-(12/7/12)
// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Moved ForDesigner objects on page 0 20 pix lower to increase size of window so that SIA input form fits better.

// Modified Method(s) : 
//CalcItem91
//  `Do nothing for ALL non-NBI records
//SIA_SecureInputForm
//  `For ALL non_NBI records unlock Item91 Inspection frequency
//fUpforInsp
//  `For Routine Inspection if FHWA record set $freq to 24, else use Item91
//GetInspContact
//  `Retrieve the phone from the Personnel table
//G_Insp_LockFormOnOff
//  `Use ◊CurrentUser_Name instead of  command Current user
//GRP_RemoveFromGroup
//  `Use the LogLink method for the changes in [PERS_Groups]PERS_Primary, [PERS_Groups]PERS_Acting
//COMPILER_InspElmtVars
//  `Updated for new method of selecting inspection type.
//GRP_Primary_Acting
//  `Use the LogLink method for the changes in [PERS_Groups]PERS_Primary, [PERS_Groups]PERS_Acting
//COMPILER_Utilities
//  `added ut_SpecialReport

// Created Method(s) : 
//ut_SpecialReport
//  ` method to generate a custom text report file from records in a 4D server db.
//  ` will download required fields from the nbi records in the server db. 
//  ` the field must be entered in the code.
//  ` this method is meant as a tool to be run in interpreted mode against a production db
//QR_Archive_AvgBrgCondNextYear
//  `return the average bridge condition from the next year; -1 if an error or invalid values
//ut_setIndexes 
//  ` Set the indexed fields on all tables in the datbase 

//XMLErrorHandler
//COMPILER_XMLUtils
//  ` Utilities for reading XML trees

// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Moved ForDesigner@ objects on page 0 20 pix lower to increase size of window so that SIA input form fits better.

// Modified Forms : 
//[Inspections];"Critical Member"
//[Inspections];"Closed Bridge"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//[Inspections];"RailRoutineInput"
//  `Moved and resized objects in the comments page for better visual when menu is shown in 4D Write areas.

//[Inspections];"Culvert Combined"
//  `Moved and resized objects in the comments page for better visual when menu is shown in 4D Write areas.
//  `Move some array declarations outside an IF THEN ELSE statement

// Modified Object Methods : 
//[Inspections];"RailRoutineInput".vTabRoutingPages
//  `Fixed the object method

// Modified Method(s) : 
//G_GetElmtLabel
//  `Use arrays ◊ALLElmtCatCode_as, ◊ALLElmtCatDesc_as instead of querying [Element Cat]

//*********
//********* End of release 6.0.9
//*********


//Add code for new inspection types

//Object Method:[Inspections];"AboveWater Template" bPrint
// `Method: Form Method: [Inspections]PedBridge_p2
//Method: Form Method: [Inspections]PedBridge_p1
// Form Method: [Inspections];"RailRoutineInput"
//  `Method: Form Method: [Inspections]RailRoutine Culvert

//PRINT_CULVERT_F
//PRINT_ROUTINE_F
//G_DefInspElmts
//COMPILER_InspElmtVars
//INSP_PrintInspBtn_OM
//Form Method: [Inspections];"BlankCombinedStarter"
//MakeInspection
//INSP_KiloPtValues
//

// Make following tables read only as we will never update from this process
//[Bridge MHD NBIS];"NBIS Stack Info" form method
//[Element Cat]
//[ElementDict]
//[Inspection Type]

//**********`Modified by: Costas Manousakis-(Designer)-(12/17/12)
// Modified Method(s) : 
//G_SortTable_new
//  `Caught case where a field is undefined.  Field must be  removed from arrays
//InitPers 
//  `Discontinued calculating array ◊aDBIEUnames. Set array size to 0 to avoid problems in the blob storage sequence.

//**********`Modified by: Costas Manousakis-(Designer)-(12/18/12)
// Modified Method(s) : 
//GetInspContact 
//  `Removed erroneous call to  GetDBIEinfo
//SC_SetRanking
//  `Added saving of calc date in parameters table under parameter SC_DateCalc

//**********`Modified by: Costas Manousakis-(Designer)-(12/20/12)
//GRP_Primary_Acting
//  `Use PushChange when primary or acting is set to 0
// Modified Forms : 
//[Inspections];"Routine Pr Pg 1"
//  `Fixed misplaced objects for dbie, tmleader and consqc

//**********`Modified by: Costas Manousakis-(Designer)-(12/21/12)
// Modified Method(s) : 
//ut_LoadBridgeRank
//  `Added saving of calc or load date in parameters table under parameter BRG_RANKINGDATE instead of showing the Alert

// Modified Forms : 
//[ScourPOA]FieldVerificationCardpg1
//  `Moved obejcts to left to align w 2nd page
//[ScourPOA]FieldVerificationCardpg2
//  `Moved obejcts to left to align w 1st page

//Add code to validate  [Inspection Type]ElementNumbers_txt
//utl_ValidateInspectionelements
//insp_ValidateElementNumbers
//[Inspection Type];"Input"`

//Create code to set up 
//[ElementsSafety] records for testing print
//utl_SetUpNewElementTest


//**********`Modified by: Costas Manousakis-(Designer)-(12/26/12)
// Modified Forms / Form Method: 
//[Dialogs]About
//  `Added variable sdbAccessMode;
//  `Moved all on Load code from objects to this form method.
//  `Re-Arranged objects

// Modified Method(s) : 
//About
//  `Removed the space for the 4D credits

// Modified Forms , FormMethod: 
//[Dialogs];"InspectConfig"
//  `More mods for the use of Page 2 both in On Load and On Clicked events
// Modified Object Methods : 
//[Dialogs].InspectConfig.INSP_SelType_atxt
//  `More mods for the use of Page 2 both in On Load and On Clicked events


//**********`Modified by: Costas Manousakis-(Designer)-(12/27/12)
// Created Method(s) : 
//INSP_RailRtnPg1_FM
//  ` Form method for Rail Routine and Arch page 1 s

// Modified Method(s) : 
//Print_RTN_Cmts
//Print_Dive_Cmt_a_new
//INSP_FRZ_PrintCmts
//  ` Clear picture var CommentsPrevw_P when done printing
//Print_CUL_Cmts
//  ` Clear picture var CommentsPrevw_P when done printing; also clear before printing just a blank page

// Modified Method(s) : 
//insp_ValidateElementNumbers
//insp_NewCreateElementDictHlist
//insp_LoadaInspType_
//utl_ValidateInspectionelements
//utl_SetUpNewElementTest
//insp_LoadESForReport

// Created Method(s) : 
//INSP_LoadElmLabelsforReport
//  ` Load the Element Labels for a report

// Modified Method(s) : 
//GetElmtNumber 
//GetParentPrefix
//  `Added special case for Rail RR@

//**********`Modified by: Costas Manousakis-(Designer)-(12/28/12)

// Created Method(s) : 
//Insp_SortElmtSfty 
//  ` Sort the current selection of ElementsSafety based on the current Inspection type.
//  ` Inspection type can be passed as an argumanet (optional)

//G_InspElmtCatPopup
//  `Use new method Insp_SortElmtSfty
//Print_RTN_Cmts
//Print_CUL_Cmts
//  `Use new method Insp_SortElmtSfty ;  do the sorting  only if there are records in the selection
//  `Clean up all code enclosed in "IF (False)"

//Print_Comments
//  `Use new method Insp_SortElmtSfty

//utl_SetUpNewElementTest
//  `Added code for testing of 4d Write comments.

//ut_NewTextToArray
//  `Use $Offset_L:=$MaxOffset_L+1 and $Offset_L>$MaxOffset_L  to account for cases when the delimited parts are single characters

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `added code for RRS RRF RRD RRO Inspection types (Rail fract crit, Spec mem, Damage, Other)

// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Added separators between the different  categories of inspection types

//End Mods_2012_12