//%attributes = {"invisible":true}
//Method: Mods_2022_09
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 14, 2022, 10:54:57
	
	// ----------------------------------------------------
	
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2022-09-28)

// NTI_ListNTI_ElementDefs
//  `consider screen ht for window height

//Method: PON_ListElementDefs
//Description
// List the Element defs from table [PON_ELEM_DEFS]
//Method: PON_SaveDefsRecord
//Description
// save a record in [PON_ELEM_DEFS] - called from Validate button on input form
// [PON_ELEM_DEFS];"Input"
//  `for a new record make elem_key enterable - changed Elem_key to not transparent (cannot set that by code yet)
//Method: [PON_ELEM_DEFS];"Input".bValidate
// call PON_SaveDefsRecord
//Method: [PON_ELEM_DEFS];"Output_LB".bAdd
//Description
// new object method
//Method: [PON_ELEM_DEFS];"Output_LB".List Box
//Description
// new object method

//End Mods_2022_09   