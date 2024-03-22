//Method: [LSS_Inspection];"UltraSonicSubForm_new"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/04/19, 15:16:51
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02
	// Modified by: Costas Manousakis-(Designer)-(2021-10-19T00:00:00 17:00:33)
	Mods_2021_10
	//  `enabled on load event on form - made plus button a 3D button for better effect when clicked
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "PlusButton_UT"; LSS_AllowInspectionEdit_B)
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 
//End [LSS_Inspection];"UltraSonicSubForm_new"