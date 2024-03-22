If (False:C215)
	//[Inspections];"Routine Combined"
	
	Mods_2004_CM12
	Mods_2005_CM06
	Mods_2005_CM08
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 08:39:37)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:40:07)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(12/19/07 10:09:29)
	Mods_2007_CM_5401
	//Use the ◊aInspCod arrays if they are populated. 
	// Modified by: costasmanousakis-(Designer)-(4/09/09 11:59:38)
	Mods_2009_04
	//  `Removed the call to G_InitInspVars
	// Modified by: costasmanousakis-(Designer)-(2/25/10 16:55:54)
	Mods_2010_02
	//  `Call method INSP_PontisCTRL ("INIT") INSP_PontisCTRL ("CLOSEDETAIL")  on load and on close detail
	Mods_2011_07  // CJ Miller`07/14/11, 10:30:19      ` Modify how buttons get set so common code for all places
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 17:16:48)
	Mods_2012_05
	//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function
	// Modified by: Costas Manousakis-(Designer)-(12/8/12 21:07:31)
	Mods_2012_12
	//  `Moved and resized objects in the comments page for better visual when menu is shown in 4D Write areas.
	// Modified by: Costas Manousakis-(Designer)-(1/4/13 16:04:15)
	Mods_2013_01
	//  `Fixed case statement = ": (vTabRoutingPages{Current form page}="Element@")"  - added @
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 16:32:02)
	Mods_2013_01
	//  `Minor changes in the UI Look
	Mods_2013_02  //r001 `  Allow for different headings on weight postings
	//Modified by: Charles Miller (2/19/13 16:59:21)
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 12:04:15)
	Mods_2013_05  //r003 ` Change [Element Cat]Description from 15 to 20 characters
	//Modified by: Charles Miller (5/7/13 14:34:05)
	// Modified by: Costas Manousakis-(Designer)-(1/15/15 17:06:03)
	Mods_2015_01
	//  `INSP_FieldWorkComplEntry
	// Modified by: Costas Manousakis-(Designer)-(6/3/15 13:31:15)
	Mods_2015_06
	//  `changed tab control to Appearance Automatic/Top ; changed tab "Items 58-61" to "I 58-61", made tab obj wider by 30
	//  `enabled "On Unload"
	//  `Added NBE Elements on page 5 and code in the form method
	//  `Adjusted names of "Pontis" related objects on page 5 so they are grouped together
	
	// Modified by: Costas Manousakis-(Designer)-(11/9/15 17:40:30)
	Mods_2015_11_bug
	//  `modified object methods in fileds 
	//  `[Inspections]NEClrFldFT [Inspections]NEClrFldIN [Inspections]SWClrFldFT [Inspections]SWClrFldIN
	//  `to use method INSP_FieldClr_OM
	// Modified by: Costas Manousakis-(Designer)-(1/16/18 14:01:16)
	Mods_2018_01
	//  `increased allowed entry in Total Hrs
	// Modified by: Costas Manousakis-(Designer)-(5/6/19 12:59:38)
	Mods_2019_05
	//  `use subform [PON_ELEM_INSP];"LB_PON_ELEM_INSP" - moved to back on page to allow Calc HI button to work
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafety_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(3/4/21 19:18:30)
	Mods_2021_03
	//  `added project manager dropdown
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
End if 

FM_RoutineCombinedInput