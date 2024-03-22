//Method: Form Method: [LSS_Inspection];"InspectionReview"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 15:55:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(11/29/18 14:32:34)
	Mods_2018_11
	//  `made all columns in listbox not enterable
	//  `make sure the print and review buttons are hidden when the selection is changed in 
	//  `obj methods of buttons in top of form
	// Modified by: Costas Manousakis-(Designer)-(2022-01-03T00:00:00 16:41:43)
	Mods_2022_01
	//  `added code for on Activate and Deactivate
End if 
//

Case of 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
		InDoubleClick_B:=False:C215
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End Form Method: [LSS_Inspection]InspectionReview