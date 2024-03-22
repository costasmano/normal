//%attributes = {"invisible":true}
//Method: Mods_2019_05
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/03/19, 14:06:50
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(5/6/19)
// Created FORM(s) : 
//[PON_ELEM_INSP];"LB_PON_ELEM_INSP"
//  //to be used as a subform in inspections

// Modified Forms : 
// [Inspections];"Critical Member"
//  `use subform [PON_ELEM_INSP];"LB_PON_ELEM_INSP"
// [Inspections];"Culvert Combined"
//  `use subform [PON_ELEM_INSP];"LB_PON_ELEM_INSP"
// [Inspections];"Routine Combined"
//  `use subform [PON_ELEM_INSP];"LB_PON_ELEM_INSP"

//Modified by: Chuck Miller (5/16/19 16:55:54
//Made changes to handle movement between records manually instead of setting on list box subform
//Note we will have to do all of this on other new sub forms created
//  //images and element safety
//[Cond Units];"Cond Units In"
//ut_LoadRecordNoWait 
//FM_CondUnitsIn 
//COND_UNIT_AFTER
//[Cond Units];"Cond_Units_SUB"


//End Mods_2019_05