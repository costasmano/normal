//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): MillerC
// Date and time: 06/13/07, 12:06:40
// ----------------------------------------------------
// Method: Mods_2007_CJMv3
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Make sure that when report records exists data appears even when dates are incorrect
//PRJ_LoadPage_1
//Add actual advertised date
//Compiler_PRJ
//[PRJ_ProjectDetails];"ProjectDetails.i"


//Add hide button to page 0 detail display area for report, type etc.
//[PRJ_ProjectDetails];"ProjectDetails.i"
// Object Method: PRJ_Button_l the 4 type areas and the new button are all named this
//PRJ_SetPage0Detail
//PRJ_LoadPage_1
//PRJ_ControlPageMovement