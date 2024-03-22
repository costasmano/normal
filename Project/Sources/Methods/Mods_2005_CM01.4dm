//%attributes = {"invisible":true}
//07-Jan-2005 *********

//Modified Method
//G_InspGetRatings 
//  `Removed setting of [Inspections]WaivedDate,EDJMNTDate from
//  `the date of the Rating Report. These dates should come from the
//  `SIA table.

//Modified form
//[Dialogs];"DependencyCheck"
//  `Re-arranged EjdMT and Waived dates to come from SIA tab. Applied 
//  `stylesheets to all objects.

//Modified Form method
//[Dialogs];"DependencyCheck"
//  `Re-arranged EjdMT and Waived date arrays and variables
//  `to correspond with which page they appear.

//Modified method
//CheckDependencies 
//  `Check values of EJDNT and Waived dates against values from SIA
//  `table instead of Ratings table.

//11-Jan-2005 *********

//Modified Object Methods:
//[Bridge MHD NBIS];"ID Input".BDEPT
//  `Added code to confirm a change in BDEPT; 
//  `and redraw aTownName_ when BDEPT changes.
//[Bridge MHD NBIS];"ID Input".aTownName_
//  `Changed code to use Case Of.

//Created Method:
//G_Insp_RelateInsp 
//  `Method to retrieve records related to the current inspection.
//  `Looks for tables passed as arguments.

//Modified Methods....
//Modified Form Methods...
//Modified Object Methods....
//  `Use method G_Insp_RelateInsp

//Modified form Method
//[Inspections];"Damage Pg1"
//  `Fix Logic checking for Inspection Revision 1