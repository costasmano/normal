//%attributes = {"invisible":true}
// Method: Mods_2017_06_bug
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/07/17, 16:56:40
	// ----------------------------------------------------
	// First Release
	Mods_2017_06_bug
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(6/8/17)
// Created Method(s) : 
//Method: ELMSRCH_ElementFilter
//Description
// Filter the current selection of [ElementsSafety] to keep only the latest
// element for each BIN.
// To be Used when searching by Elements in method CreateRandomSetForDefElement

// Modified Method(s) : 
// CreateRandomSetForDefElement
//  `Account for other routine type, Spec memb, Fract crit, and damage inspections besides the
//  // highway ones.
//  // use method ELMSRCH_ElementFilter

