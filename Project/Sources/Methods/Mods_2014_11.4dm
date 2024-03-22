//%attributes = {"invisible":true}
//Method: Mods_2014_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/03/14, 11:59:57
	// ----------------------------------------------------
	//Created : 
	Mods_2014_11
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(11/3/14)
// Modified Forms : 
//[ScourPOA];"Summary-A"
//[ScourPOA];"Print3-A"
//  `minor adjustments in labels

// Modified Forms : 
//[Inspections];"Evaluation Form Page2"
//[Inspections];"Evaluation Form Page3"
//[Inspections];"Evaluation Form Page4"
//  `minor adjustments in Item 58,59,60 labels

//**********`Modified by: Costas Manousakis-(Designer)-(11/12/14)

// Modified Forms : 
//[Inspections];"Evaluation Form Page1"
//[Inspections];"Evaluation Form Page2"
//[Inspections];"Evaluation Form Page3"
//[Inspections];"Evaluation Form Page4"
//[Inspections];"Evaluation Form Page5"
//  `Changed title of the form

// Modified Method(s) : 
//maximo_UpdateMaximo
//  `fixed CRs in the last message of the results.
//  `Also set the $UpdateLastDate_b:=Not(SQLError_b)

//BRG_RWAccess
//  `if the userr belongs to the readOnly group then they dont;t have access


//```
//```   **** End of Release 6.3.3.b 11/14/2014
//```

//End Mods_2014_11