//%attributes = {"invisible":true}
//Method: Mods_2014_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	// ----------------------------------------------------
	//Created : 
	Mods_2014_10
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(10/09/14)
// Created Method(s) : 
//ut_Launch_IE
//  `Launch Internet Explorer with a URL
//  ` Parameters
//  ` $1 : $url_txt

// Created Method(s) : 
//ut_DOM_To_Arrays
//  ` Parse an XML Tree to arrays.  Row name is the name of the elements to be parsed;
//  ` pass a pointer to an array that will be filled with the values of the elements;
//  ` pass a pointer to a text array containing the names of attributes to be retrieved
//  ` pass a pointer to an array of pointers that will retrieve the values of the attributes
//  ` Values of elements and attributes will be retrieved based on the type of arrays that need to be filled
//  ` Parameters
//  ` $1 : $Tree_txt
//  ` $2 : $RowNames_txt
//  ` $3 : $RowValArray_ptr`
//  ` $4 : $AttrNameArray_ptr
//  ` $5 : $AttrValArrays_ptr

//**********`Modified by: Costas Manousakis-(Designer)-(10/16/14)
// Modified Method(s) : 
//COMPILER_Utilities
//  `added  ut_Launch_IE and ut_DOM_To_Arrays

//**********`Modified by: Costas Manousakis-(Designer)-(10/22/14)
// Modified Table(s) : 
//[Town Address]
//  `changed fields [Town Address]AddressedTo  [Town Address]Street to 255 chars

// Modified Forms : 
//[Town Address];"Town Address In "
//  `Added ability to have multiple lines for Addressed to and Street address.
//  `can show up to 3 lines each. however not clear if there are more - also cannot enter a 
//  `line feed in alpha fields. multiple lines can be entered by pasting.

//**********`Modified by: Costas Manousakis-(Designer)-(10/28/14)
// Modified Method(s) : 
//maximo_UpdateMaximo

//**********`Modified by: Costas Manousakis-(Designer)-(10/28/14)
// Modified Method(s) : 
//INSP_FillPreElementInfo
//  `  `Add the deficiency and Urgency to the rating value text
//  `Added combining of the "Current Inspection" Def and Urgency to the current Rating text
//COMPILER_InspElmtVars
//  `Increased size of Prev Rating for Eval forms to include deficiency and prio; 
//  ` added new vars for Curr Rating+def+prio for Eval Forms

//**********`Modified by: Costas Manousakis-(Designer)-(10/28/14)
// Modified Forms : 
//[Inspections];"Evaluation Form Page5"
//[Inspections];"Evaluation Form Page4"
//[Inspections];"Evaluation Form Page3"
//[Inspections];"Evaluation Form Page2"
//[Inspections];"Evaluation Form Page1"
//  `Modified for new version of QA report - change in  layout , alignment , content

//**********`Modified by: Costas Manousakis-(Designer)-(10/30/14)
// Modified Method(s) : 
//DEV_UPDATE_STRUCTURE_LOG
//  `when changes found show doc on disk

//**********`Modified by: Costas Manousakis-(Designer)-(10/31/14)
// Modified Object Methods : 
//Object Method: [Contract Assignments].Assignments In.vLockButton_L 
//  `made accessibility to this button based on user groups instead of individual user

// Modified Forms : 

//```
//```   **** End of Release 6.3.3.a 10/31/14
//```

//End Mods_2014_10