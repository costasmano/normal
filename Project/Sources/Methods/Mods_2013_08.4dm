//%attributes = {"invisible":true}
//Method: Mods_2013_08
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/08/13, 14:17:58
	// ----------------------------------------------------
	//Created : 
	Mods_2013_08
End if 
//

// Modified Form : 
//[ScourPOA]Print4-A
//  `Fixed spelling of Dropline Readings (item 4a)

//**********`Modified by: Costas Manousakis-(Designer)-(8/9/13)
//INSP_ElmSftySpellCheck
//  `Added case if button is pressed holding the Shift key for designer to extract the plain text 


//**********`Modified by: Costas Manousakis-(Designer)-(8/12/13)
// Modified Method(s) : 
//INV_DeleteInsp
//  `Added  parameter to  skip canceling out of the current form


//**********`Modified by: Costas Manousakis-(Designer)-(8/16/13)
//M_LoadBINfile
//  `Open file in Read mode

//**********`Modified by: Costas Manousakis-(Designer)-(8/19/13)
// Created Method(s) : 
//Compiler_Bridge
//  `added arrays from the BDEPT Input form method (New BIN)

// Modified Form Methods : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Added  code to include creation of Townline Records on the Validate event
//  `Changed display of initial values from pulldowns : use element 0 of the puuldown to display the prompt to 
//  `select a value instead of a variable over the pulldown. Deleted variables over the item8 dropdowns.
//  `Re arranged tab controls, form size properties, objects

// Modified Object Methods : 
//[Bridge MHD NBIS];"BDEPT Input".bGetRef 
//  ` USE SQL Call to get the variables. 
//  `Added townLine info; 
//[Bridge MHD NBIS].BDEPT Input.RefBINSelector_atxt 
//  `added Townline

//SIA_Item8Owner_OM 
//  `use element 0 to display the  "Select...." prompt

//SIA_Item8Category_OM
//  `use element 0 to display the  "Select...." prompt

//**********`Modified by: Costas Manousakis-(Designer)-(8/23/13)
// Created Method(s) : 
//TOL_ListToArray
//  `Description
//  ` Load a list from the [Table of Lists] into an array

// Modified Form Methods : 
//[Bridge Design];"Bridge Design In"
//  `Load pulldowns from table of lists

// Modified Forms : 
//[Bridge Design];"Bridge Design In"
//  `For ProjectInfo button use the projbtn.png in Resources

//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `Changed buttons for projectInfo to use Resource file "projbtn.png"

// Modified Method(s) : 
//utl_ImportTOLRecords 
//  `if list is a new list - add the records and increase the local key sequence ; 
//  `added transaction and option to cancel the import of a list  if some entries in the import file do not match

//**********`Modified by: Costas Manousakis-(Designer)-(8/28/13)

// Modified Object Method(s) : 
//[Standard Photos]Standard Photos.vbPrintImages 
//  `Added Redraw Window at end to fix Windows redraw problem at end of printing

//Add confirm to allow designer to either duplicate or blank out pictures
//INSP_DuplicateInventoryPhotos

//ut_DocumentIndexedandUnique
//ut_ResetIndexes
//ut_CreateSQLLimits

//Compiler_InventoryPhotoInsp

//
//TOL_ListToArray

//End Mods_2013_08