If (False:C215)
	//procedure: [Inspections];"Underwater Special Member"
	//by: Albert Leung
	//created: 6/2002
	//modified:  
	//purpose: initialize variables for [Inspections];"Underwater Special Member"
	//Copyright © 1995-2002,  Albert S. Leung, All Rights Reserved.
	//parameters:
	
	Mods_2004_CM12
	Mods_2005_CM05
	Mods_2005_CM12
	Mods_2005_CM13
	// Modified by: costasmanousakis-(Designer)-(4/18/2006 15:21:59)
	Mods_2006_CMy2
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: costasmanousakis-(Designer)-(4/9/09 21:30:46)
	Mods_2009_04
	//  `Removed call to INSP_Check4DWriteChgs
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 17:16:48)
	Mods_2012_05
	//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function
	// Modified by: Costas Manousakis-(Designer)-(1/16/15 14:26:09)
	Mods_2015_01
	//  `added fiield [Inspections]InspFldWorkComplDate  `  `
	// Modified by: Costas Manousakis-(Designer)-(5/29/18 17:10:04)
	Mods_2018_05
	//  `disabled entry of Inspection complete checkbox
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafetyUW_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
//INSP_Check4DWriteChgs 
INSP_UWInputForm_FM