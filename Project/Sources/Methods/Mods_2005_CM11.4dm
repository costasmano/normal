//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/09/05, 07:17:36
	// ----------------------------------------------------
	// Method: Mods_2005_CM11
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

//Modified Table Relation
//[BMS Inspections] - [Cond Units]
//  `Enabled Auto One to Many so that the 'Delete Related Many' option would be enabled.

//Modified Method
//G_DeleteInspection 
//  `Added code to delete [Combined inspection] and [BMS Inspections] record if any.

//Modified FormS
//[Cond Units];"Cond Units Inc"
//  `Fixed color/visibility of rectangle behind data.
//[Cond Units];"Cond Units In"
//  `Adjusted Fills/Styles of some label objects, set Hor, Vert Form margins to 0.

//Modified Object method
//[Inspections];"AboveWater Template".ZZ9
//  `Moved Set Enterable statements after Cancel command instead of right at the end of the method

//Modified Method
//G_Insp_SaveContinue 
//  `Added code to restore selection of [Cond Units] and apply sort and queries to [ElementsSafety]
//  `and [Standard photos] only if there are records.

//Modified Object method
//[Bridge MHD NBIS];"CombinedInspections".bOpenInsp
//  `Added Call to CloseAllTables before restoring [Combined Inspections] selection

//Modified Form
//[Bridge MHD NBIS];"CombinedInspections"
//  `Assigned Keys to New Inspection, Open Inspection, Duplicate Inspection buttons.

//Modified Object Method
//[Combined Inspections];"Input".vSetEnterable
//  `Add code to include the new Delet button

//New Pictures
//  `Added new Pictures in Pic Library for OSX buttons

//Modified Form
//[Combined Inspections];"Input"
//  `Added Button  CombDelButton , Added ID field for display - Changed buttons to OSX picture buttons.

//Modified Object Method
//[Inspections];"AboveWater Template".bPrint
//  `Added missing code to print a Pontis only inspection.