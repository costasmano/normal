//%attributes = {"invisible":true}
//Method: Mods_2017_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/03/17, 15:01:53
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(11/2/17)
// INSP_ViewAllComments
//  `For design users do not lock the document or the File menu.
// G_InspParagProt
//  `use wr cmd insert page break instead of CR when splitting element comments



//**********`Modified by: Costas Manousakis-(Designer)-(11/13/17)
// Created Method(s) : 
//Method: MENU_BuildMenuFromArrays
//Description
// Build a menu from arrays. menu can be used as a dynamic pop up menu
// Parameters
// $0 : $MenuRef_txt
// $1 : $MenuLines_ptr : pointer to text array of menu lines
// $2 : $MenuAttributes_ptr : pointer to text array of attributes for each menu line
// $3 : $BranchSeparator_txt : string used to separate submenus

// Modified Method(s) : 
// SFA_GetAvailRatingRpts
//  `added a progress bar; use MENU_BuildMenuFromArrays to use a dynamic pop up menu


//Modified by: Chuck Miller (11/14/17 16:39:12)
//Add code to allow for moving/copying rating reports to directory structure
//SIA_BridgeInpNavCTRL
//[Bridge MHD NBIS];"Bridge Input" - new button page 4
//  //Method: [Bridge MHD NBIS].Bridge Input.MoveRatingReport1
//OM_ControlOpenandMoveRatingPDF
//"RatingReportDisplayandMove" - new form
//Compiler_MoveRating
//OM_SetColoronForm


//**********`Modified by: Costas Manousakis-(Designer)-(11/20/17)
// M_GetNBIS
//  `made to handle most searches in the Records menu of BridgeList.
//  //Uses the parameter in the menu item 
//  //Added options for ONNHS and OFFNHS - added On NHS and Off NHS in the Records menu

// Modified Menu
//Records menu in BridgeListMenu (#2)
//Made most Record searches to call M_GetNBIS with a parameter
//Added items On NHS and Off NHS
//Added (Item 26) to On System and Off System menu items

//**********`Modified by: Costas Manousakis-(Designer)-(11/27/17)
// [Dialogs];"DependencyCheck"
//  `added on Page Change event to the form events;
//  `Replaced title on page 2 with styled text variable using the UUID var for the ratingsreports
//  `added code on page change event to set the title when using Yr Rebuilt as a cutoff date for reports - does not work on load 

//End Mods_2017_11