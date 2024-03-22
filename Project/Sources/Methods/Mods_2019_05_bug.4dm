//%attributes = {"invisible":true}
//Method: Mods_2019_05_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/07/19, 11:38:37
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(5/1/19)
// Modified Method(s) : 
// SIA_ResetWidths
//  `added code to adjust the width of listbox object to match the column widths

//**********`Modified by: Costas Manousakis-(Designer)-(5/2/19)
// Modified Forms : 
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"Damage Form"
//[Inspections];"Damage Pg1"
//[Inspections];"DamagePg1_v2"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"HighwayFCRInsp1"
//[Inspections];"MHD_Special_Member98"
//[Inspections];"RailCulvertCombined-RRC"
//[Inspections];"Railfc_rr_p1"
//[Inspections];"RailFCRInsp"
//[Inspections];"RailRoutine Arch Pr Pg 2"
//[Inspections];"RailRoutine Culvert"
//[Inspections];"RailRoutineInput"
//[Inspections];"Routine Combined"
//[Inspections];"Routine Pr Pg 2"
//[Inspections];"RoutineNewNBE"
//[Inspections];"RoutinePrPg2_New"
//[Inspections];"RoutinePrPg2_v2"
//[Inspections];"TransitFCRInsp"
//  //Replaced label "Request for Rating .." with "Recommend for Rating.." - CallReference #634
//  //also removed text "To Be Filled by DBIE" where it existed

// Modified Method(s) : 
// G_Insp_LockFormOnOff
//  `removed restriction to the rating request fields for external inspectors - CallReference #634


//**********`Modified by: Costas Manousakis-(Designer)-(5/28/19)
// Modified Forms : 
// "PONHELP"
// "NTIHELP"
//  `changed web area to use integreated webkit - needed for OS 12.

// Modified Method(s) : 
// PON_PONHELP_FM
//  `because web area was changed to use integrated webkit, had to define var $Filespec_txt depending on platform (windows works with 3 "/", Mac OS with 2
// NTI_PONHELP_FM
//  `because web area was changed to use integrated webkit, had to define var $Filespec_txt depending on platform (windows works with 3 "/", Mac OS with 2

//End Mods_2019_05_bug