//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Administrator
	// Date and time: 08/29/05, 10:59:23
	// ----------------------------------------------------
	// Method: Mods_2005_CM16
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

// Modified Forms : 
//[Personnel];"Inspectors In"
//[Personnel];"Inspectors Out"
//  `Made appearance Mac Theme, changed buttons to Picture buttons; added buttons to 
//  `picture library; adjusted look of some objects.

// Modified Form Methods : 
//[Personnel];"Inspectors In"
//  `Added code for handling startup and validation. Was removed from .Person ID object.
//  `Adjusted so that on Cancel a new record is not saved.

// Modified Forms Object Methods : 
//[Personnel];"Inspectors In".Delete
//  `Enhanced message information
//[Personnel];"Inspectors Out". (All buttons except order by and done)
//  `Added a default sort order; Added button to trap CMD-period.

// Modified Methods : 
//G_Insp_LockFormOnOff
//  `Added code to enable adding to review comments by Area or DBIE 
//  `AFTER they have rejected an inspection.
//G_Insp_ReplyRevCmts
//  `Added code to change window descr depending whether adding to comments or not.

// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Made form resizable with min width and height.

// Modified by: costasmanousakis-(Designer)-(8/30/2005 15:39:49)
// Modified Methods : 
//NewWindow
//  `Added more options to the 3rd parameter. Can code 8-32 to put window on a 5x5 grid.

// Modified by: costasmanousakis-(Designer)-(9/2/2005 15:30:13)
// Modified Methods : 
//prt_substdrep 
//  `Added setting of the output filename when printing.

// Modified by: costasmanousakis-(Designer)-(9/6/2005 09:57:21)
// Modified Forms : 
//[Status Report];"O_StatusReport"
//  `Made form Appearance Mac theme, Changed all buttons to picture buttons 
//  `with OSX pictures

// Created Methods : 
//QR_CountyName
//  `Retrieve the County name for a Bridge.
//QR_TLineBrNo_2
//  `Retrieve the 1st non-blank townline BDEPT number

// Modified by: costasmanousakis-(Designer)-(9/8/2005 10:32:09)
// Modified Methods : 
//FlushGrpDeletions
//  `Fixed [ActivityLog]Forward to be set to process var vsForward 
//  `instead of the global ◊Forward.

// Modified by: costasmanousakis-(Designer)-(9/9-12/05 )
//Group modifications **********
// Modified Methods : 
//M_SearchDefElement
//CreateRandomSetForDefElement
//G_DeficientElmtQuery
//SRC_ResetForm
//M_DeficientElementRpt
//Print_DefElement_Cmts
// Modified Form : 
//[Dialogs];"Search Def Element"
//[ElementsSafety];"Rpt DefElem"
// Created Form :
//[ElementsSafety];"Rpt DefElem Comments3"
// Modified Form Methods : 
//[Dialogs];"Search Def Element"
//  `Modified the operation of all these methods to allow better user interface and reporting.
//  `Added ability to search on Condition rating.
//  `Modified search method for faster searching.
//  `Added more option of searching based on approval level. - Restrict to completed inspections.
//  `Search inspections up to the last routine inspection; not just the latest. Will look through 
//  `  `CMI, FCR, DAM inspections.
//  `Allow effective use of the Find button so that multiple searches on the 
//  `  `current Bridge List can be done with accumulating of results;  Printing of all various
//  `  `elements found.
//  `Modified Report outputs to show results for all inspections found sorted by date.
//  `Cleaned up code in all methods (project, form, object).
//End of Group modifications **********

// Modified Methods : 
//SHORT_MESSAGE
//  `Increased assumed width of character

// Modified by: costasmanousakis-(Designer)-(9/13/05 12:58:18)
// Modified Methods : 
//GetConsltAddress
//Added code to put Street Address1 and StreetAdress2 on separate lines.