If (False:C215)
	//procedure: [Inspections];"Dive LowCl"
	//by: Damian B. DeMarco
	//created: 
	//5/02
	//modified:
	//Initialize Dive insp eng to J Donahue, 
	//Remove relate many for
	//[Field trip] table - set auto one to many relation in structure def,
	//Remove INPUT FORM call for elements - set in properties of sub-form
	
	//purpose: initialize variables for [Inspections];"Dive LowCl"
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	//parameters:
	
	Mods_2004_CM12
	Mods_2005_CM05
	Mods_2005_CM12
	Mods_2005_CM13
	// Modified by: costasmanousakis-(Designer)-(4/18/2006 15:21:59)
	Mods_2006_CMy2
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 17:16:19)
	Mods_2012_05
	//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function
	// Modified by: Costas Manousakis-(Designer)-(1/16/15 14:22:11)
	Mods_2015_01
	//  `added fiield [Inspections]InspFldWorkComplDate
	// Modified by: Costas Manousakis-(Designer)-(5/29/18 17:08:51)
	Mods_2018_05
	//  `disabled entry of Inspection complete checkbox
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafetyDive_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-20T00:00:00 14:00:46)
	Mods_2021_12_bug
	//  `enabled on Clicked event for Undermining
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
INSP_UWInputForm_FM