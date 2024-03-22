//Method: [LSS_Inspection].UltraSonicSubForm
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
	// Modified by: Costas Manousakis-(Designer)-(8/24/20 14:26:17)
	Mods_2020_08_bug
	//  `added case  statement - hide the results lb and the plusbutton for results button
	//  `made all buttons on form 3D buttons and bevel; removed focus on listboxes;
	//  `removed all events from form except on load, clicked and double click
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "PlusButton_UTResults"; False:C215)
		OBJECT SET VISIBLE:C603(*; "PlusButton_UT"; LSS_AllowInspectionEdit_B)
		OBJECT SET VISIBLE:C603(*; "UTResults_LB"; False:C215)
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End [LSS_Inspection].UltraSonicSubForm