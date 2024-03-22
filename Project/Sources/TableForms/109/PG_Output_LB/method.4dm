//Method: [PERS_Groups].PG_Output_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck
	//User (4D) : Designer
	//Date and time: 06/25/20, 14:31:42
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	// Modified by: Costas Manousakis-(Designer)-(2/26/21 17:07:30)
	Mods_2021_02
	//  `adjusted listbox size, enabled on open/close detail on the LB object
	// Modified by: Costas Manousakis-(Designer)-(2022-12-27 20:02:19)
	Mods_2022_12_bug
	//  `deleted hidden button cmd-d (duplicate record) - code moved to add button.
	//  `changed help message on add button
	// Modified by: Costas Manousakis-(Designer)-(2023-04-11 15:51:06)
	Mods_2023_04
	//  `added SET WINDOW TITLE to all buttons that change the selection (add,delete, show all, show subset,query)
	//  `removed variables from buttons. 
	//  `modified code in add button to reset the search picker because the on datachange event was invoked after clicking the add button
	
End if 
//

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
	: (Form event code:C388=On Load:K2:1)
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		//REDRAW(◊asWindows)
End case 
//End [PERS_Groups].PG_Output_LB