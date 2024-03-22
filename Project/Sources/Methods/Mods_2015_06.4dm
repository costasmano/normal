//%attributes = {"invisible":true}
//Method: Mods_2015_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/02/15, 15:40:13
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(6/2/15)
// Modified Method(s) : 
//Temp_touchall
//  `added Check for valid field number and valid table number

// Modified Forms : 
//[Inspections];"Critical Member"
//  `Added NBE Elements on page 7 and code in the form method
//  `Adjusted names of "Pontis" related objects on page 5 so they are grouped together
//  `made tab control Automatic appearance with Top lables

//**********`Modified by: Costas Manousakis-(Designer)-(6/3/15)
// Modified Forms : 
//[Inspections];"Culvert Combined"
//  `Added NBE Elements on page 5 and code in the form method
//  `enabled On Unload in form events
//  `Adjusted names of "Pontis" related objects on page 5 so they are grouped together
//  `made tab control Automatic appearance with Top lables

// Modified Method(s) : 
//INSP_PreviewBtn_OM
//  `added case for NBE elements 

// Modified Object Methods : 
//[Inspections]Culvert Combined Form.vbPGPreview
//  `use method INSP_PreviewBrM to prieview Pontis or BrM on page 5
//[Inspections].Routine Combined.vbPGPreview
//  `added printing NBEs depending on iinspection date; using method INSP_PreviewBrM


//**********`Modified by: Costas Manousakis-(Designer)-(6/5/15)
// Modified Forms : 
//[Inspections];"RailFCRInsp"
//[Inspections];"RailFCRInsppg2"
//  `changed style sheet of vRemarksxx to Arial10Bold from Arial11Bold

//**********`Modified by: Costas Manousakis-(Designer)-(6/18/15)
// Modified Method(s) : 
//PushAllChanges
//  `added a case to check for alpha/text fields to account for a change in upper/lower case
//  `uses Position (x;y;*)

//**********`Modified by: Costas Manousakis-(Designer)-(6/22/15)
// Modified Method(s) : 
//ADDUSER_Utils
//  `increased the warming of radom to 500 times


//```
//```   **** End of Release 6.4.0 06/30/2015
//```

//End Mods_2015_06
