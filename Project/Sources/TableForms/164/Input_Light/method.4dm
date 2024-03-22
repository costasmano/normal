
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/15/15, 15:35:11
//----------------------------------------------------
//Method: Form Method: [LSS_Inspection]Input_Light
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/15/15 15:35:12)
	Mods_2015_08_bug
	//Modified by: designer CM  (8/14/15)
	//  `  `Made comments and recommendation fields AutoSpellcheck
	// Modified by: Costas Manousakis-(Designer)-(2/16/16 10:38:37)
	Mods_2016_02_bug
	//  `made rectangles behind UT and Dmeter sketches to Grow/grow on resize
	// Modified by: Costas Manousakis-(Designer)-(2/19/16 11:07:46)
	Mods_2016_02_bug
	//  `added field [LSS_Inspection]LSS_AdditionalComments_txt on page one ; re-arranged other text fields to fit
	// Modified by: Costas Manousakis-(Designer)-(4/20/16 14:15:53)
	Mods_2016_04_bug
	//  `added buttons on D-Meter page to edit Dmeter sketch notes and do a preview of the dmeter page.
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 17:05:40)
	Mods_2016_05_bug
	//  `added UT Sketch Comments
	// Modified by: Costas Manousakis-(Designer)-(10/12/18 11:38:00)
	Mods_2018_10
	//  `changed headers of ut results colummns
	Mods_2019_06  //Add code to make sure windows open and take into account 13" mac books
	//Modified by: Chuck Miller (6/4/19 13:52:21)
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
	C_LONGINT:C283($l; $t; $r; $b; $Width_L; $Height_L)
	LSS_SetInspInputFormHeight("Input_Light")
	
End if 
FM_InspectionInput
//End Form Method: [LSS_Inspection]Input_Light

