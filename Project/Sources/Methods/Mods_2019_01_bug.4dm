//%attributes = {"invisible":true}
//Method: Mods_2019_01_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/16/19, 09:57:08
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(1/16/19)
// Modified Method(s) : 
// G_ElmtDefPopup
//  `changed _o_ commands to OBJECT SET - CallReference #596

// Created Method(s) : 
//Method: INSP_Deficiency_OM
//Description
// object method for the deficiency field in [ElementsSafety] input forms
// made to fix CallReference #596

// Modified Object Methods : 
// [ElementsSafety];"Safety ElmInput".DE Deficiency fld
// [ElementsSafety];"Safety ElmInput".DE Deficiency fld RTN
// [ElementsSafety];"SafetyElementInputEx".DE Deficiency fld
// [ElementsSafety];"TunnelSafetyElmInput".DE Deficiency fld
// [ElementsSafety];"TunnelSafetyElmInput".DE Deficiency fld1
// [ElementsSafety];"TunnelSafetySpElmInput".DE Deficiency fld
//  `use new method INSP_Deficiency_OM - CallReference #596

// Modified Method(s) : 
// GRP_UserInGroup
//  `do not return an error if there are no members found - the problem will be
//  `by loss of functionality - and not by impacting other areas - partial fix to CallReference #593 

// Duplicate_Inspection
//  `fixed IF statement when : need to check if now there is a BMS Inspection record if we have NBES 
//  `also added the calc of HI when creating a BMS insp record
//  `for CallReference #595
// INSP_SaveRecords
//  `Make sure there is a BMS Inspection record if there are NBEs for this inspection. 
//  `Also recalculate HI - CallReference #595

//**********`Modified by: Costas Manousakis-(Designer)-(1/18/19)
// [PON_ELEM_INSP];"Output_LB"
//  `renamed old Output form to Output_LB to use a list box;
//  // modified code in some buttons to use lsitbox sets ; added button to omit subset  
//  //added button for a tool to fix NBE links\


//**********`Modified by: Costas Manousakis-(Designer)-(1/22/19)

// Created Method(s) : 
//Method: INSP_IsElementLoadRated
//Description
// check if current ElementsSafety record is load rated. 
// the related [ElmtRatingLoads] record must already be loaded 
// fix CallReference #598 
// Parameters
// $0 : $ElementRated_b
// $1 : $RtgFields_ptr : pointer array of rating field pointers from INSP_LoadElmRtgDefs

// Modified Method(s) : 

// INSP_RailFCPg1_FM
//  `Use method INSP_IsElementLoadRated to check printing of rating loads or not. CallReference #598
//  // moved creating $temparea outside of element loop - use select all / clear

//**********`Modified by: Costas Manousakis-(Designer)-(1/23/19)
// Modified Method(s) : 
// G_RoutinetoBMS
//  `added pushchange for Item91 when checking spec memb frequency

// Created Method(s) : 
//Method: SIA_ConditionRating_OM
//Description
// object method for the Condition rating fields on SIA form i58.59.60.61,62

// Modified Object Methods : 
// [Bridge MHD NBIS];"RAIL_SIA_Input".Field123
// [Bridge MHD NBIS];"RAIL_SIA_Input".Field124
// [Bridge MHD NBIS];"RAIL_SIA_Input".Field125
// [Bridge MHD NBIS];"RAIL_SIA_Input".Field126
// [Bridge MHD NBIS];"RAIL_SIA_Input".Field127
// [Bridge MHD NBIS];"SI & A Input".Field123
// [Bridge MHD NBIS];"SI & A Input".Field124
// [Bridge MHD NBIS];"SI & A Input".Field125
// [Bridge MHD NBIS];"SI & A Input".Field126
// [Bridge MHD NBIS];"SI & A Input".Field127
//  `use method SIA_ConditionRating_OM

// Created Method(s) : 
//Method: INSP_FitPictToFormObj
//Description
// Fit a picture variable to a Form object. CallReference #600
// Parameters
// $1 : $ObjectName_txt
// $2 : $PicturePointer_ptr

// Modified Form Methods : 
// [Inspections];"CmtsPrint"
//  `use INSP_FitPictToFormObj - CallReference #600
// [Inspections];"Culvert Pr Pg 2"
//  `use method INSP_FitPictToFormObj - created due to CallReference #600
// [Inspections];"NTECmtsPrint"
//  `use INSP_FitPictToFormObj - CallReference #600
// [LSS_Inspection];"LSS_Comments"
//  `use INSP_FitPictToFormObj - CallReference #600
// [LSS_Inspection];"LSS_PhotoLog"
//  `use INSP_FitPictToFormObj - CallReference #600

//**********`Modified by: Costas Manousakis-(Designer)-(1/24/19)
// Modified Method(s) : 
// [Inspections];"Closed Bridge"
//  `fixed _o_enable/_o_disable commands for the DBIE@ entries - CallReference #601

//**********`Modified by: Costas Manousakis-(Designer)-(1/28/19)
// Modified Forms : 
// [Inspections];"CustomInput"
//  `fixed size/spacing of objects on form.

//**********`Modified by: Costas Manousakis-(Designer)-(1/29/19)

// Modified Method(s) : 
// SIA_OnDisplayDetail
//  `In Ratings tab (4) account for single postings - CallReference #602
// PON_FixParentLinks
//  `don't make changes if found IDs match stored values

//**********`Modified by: Costas Manousakis-(Designer)-(1/30/19)
// Modified Method(s) : 
// ut_ExportFieldTitles
//  `added alert at the end and show of the destination folder

// LSS_CountandPrintDamagePages
//  `fix handling of letter labels for the printed elements
// LSS_FillElementMemberLines
//  `fix printing of Deficiency to include the priority - CallReference #603


//```
//```    **** End of Release 7.2.0.b 01-Feb-2019
//```


//End Mods_2019_01_bug