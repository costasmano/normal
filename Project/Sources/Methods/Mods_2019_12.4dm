//%attributes = {"invisible":true}
//Method: Mods_2019_12
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/10/19, 13:16:22
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(12/2/19)
// INSP_DamagePg1_FM
//  `Hide Weight posting block for Rail Damage reports using FORM_HideEnclosedObjs
// INSP_FCPrPg1_FM
//  `Hide Weight posting block for Rail reports using FORM_HideEnclosedObjs

// [Bridge MHD NBIS];"RAIL_SIA_Input"
//  `Added ES44AC label and fields in "CommutRtg_@" group on page 7

// [Bridge MHD NBIS];"RailTransitSIA"
//  `Added ES44AC label and fields in "CommutRtg_@" group

// [RAILBridgeInfo];"RailInput"
//  `Added ES44AC label and fields in "CommutRtg_@" group

// [BridgeMHDNBISArchive];"RailTransitSIA"
//  `Added ES44AC label and fields in "CommutRtg_@" group

// [Inspections];"Damage Pg1"
//  `created invisible rectangle named "WTPostingArea" on page 0, to hide or not all objects belonging to the weight posting block for Rail damage reports

// [Inspections];"DamagePg1_v2"
//  `created invisible rectangle named "WTPostingArea" on page 0, to hide or not all objects belonging to the weight posting block for Rail damage reports

// [Inspections];"FCPrPg1_v2"
//  `created invisible rectangle named "WTPostingArea" on page 0, to hide or not all objects belonging to the weight posting block for Rail damage reports

// [Inspections];"RailFCRInsp"
//  `made weight posting section invisible

// [Inspections];"TransitFCRInsp"
//  `made weightposting section invisible

//**********`Modified by: Costas Manousakis-(Designer)-(12/3/19)
//Method: FORM_HideEnclosedObjs
//Description
// hide - make invisible objects within a rect defined by passed obj name
// either in page of object (for input forms) or all pages (print forms)
// can check if either the top left "TopLeft", or completely in "IN", or crossing ("Cross") of each object
// is within the master obj rectangle
// Parameters
// $1 : $BoundBoxName_txt
// $2 : $Pageopt_L (Constants Form all pages or Form current page
// $3 : $Option (Optional "TopLeft" (default) "IN" "Cross" )


// [Inspections];"Critical Member"
//  `named rectangle "WTPostingArea" around weight posting group on page 2
//  `use FORM_HideEnclosedObjs to hide weight posting area
// [Inspections];"Damage Form"
//  `named rectangle "WTPostingArea" around weight posting group on page 2
//  `use FORM_HideEnclosedObjs to hide weight posting area

// [Inspections];"RailCulvertCombined-RRC"
//  `Named rect on page 2 "WTPostingArea"
//  `use FORM_HideEnclosedObjs to hide weight posting area

// [Inspections];"RailRoutine Culvert"
//  `added invis rectangle "WTPositnArea"; use FORM_HideEnclosedObjs to hide all objects inside it

//**********`Modified by: Costas Manousakis-(Designer)-(12/4/19)
//Method: FORM_FitWindowToCurrPage
//Description
// Make the current window fit to the objects on the current page
// Parameters
// $1 : $Pagenumber

// SFA_GetAvailRatingRpts
//  `adjust the calculation of targetPath
// SFA_GetBridgeFolder
//  `use special case for standalone desktop app
// SIA_BridgeInpNavCTRL
//  `for ratingreports adjust window size to fit the listbox
// SIA_ResetWidths
//  `Added optional param $2 : setup - indicates if we are called during the setup phase or not
//  `if during setup - make listbox object as large as required by column widths

// [Bridge MHD NBIS];"Bridge Input".RatingReports
//  `fix logic check to set visible the move button  

//**********`Modified by: Costas Manousakis-(Designer)-(12/4/19)
//Method: RatRep_InitialSetup
//Description
// utility to log vehicle type records and set the sequence
//  - run only once at first implementation
// ----------------------------------------------------


//**********`Modified by: Costas Manousakis-(Designer)-(12/6/19)
// SFA_VerifyMountPoint
//  `added a progress bar while trying to mount the volume


//```
//```    **** End of Release 7.2.1 6-Dec-2019
//```


//add code to modify how bin groups are created and maintained for a project
//Compiler_PRJArrays 
//PRJ_LoadForBINHierarchyDialog 
//PRJ_SetUpIncludedBins 
//ut_CloseAsk
//"PRJ_BIN_Hierarchy"// new form
//Form Method: PRJ_BIN_Hierarchy
//  //Method: PRJ_BIN_Hierarchy.PRJ_BIN_Hierarchy
//  //Method: PRJ_BIN_Hierarchy.New_Button
//  //Method: PRJ_BIN_Hierarchy.Move_Button.
//  //Method: PRJ_BIN_Hierarchy.RemoveBlank_Button
//  //Method: PRJ_BIN_Hierarchy.Remove_Button
//  //Method: PRJ_BIN_Hierarchy.Add_Button
//  //Method: PRJ_BIN_Hierarchy.Switch_Button
//   //Method: PRJ_BIN_Hierarchy.RevertToSaved_Button


//[PRJ_ProjectDetails];"ProjectDetails.i"
//  // Object Method: Button1
//Object Method: [Bridge MHD NBIS];"BDEPT Input".Save 

//**********`Modified by: CJM-(Designer)-(12/31/19)
// Form [Bridge MHD NBIS];"Bridge Input" 
//  `Added button and obj method [Bridge MHD NBIS];"Bridge Input".OpenRatingFolder to OpenRatingFolder on page 4 (Rating reports)
//SIA_BridgeInpNavCTRL 
//  `Added button and obj method to OpenRatingFolder on page 4 (Rating reports) 
//  `visible to PersGroup "MoveRatingReports" and Design users

//End Mods_2019_12