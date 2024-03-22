//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/12, 22:57:00
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//

If (Read only state:C362(Current form table:C627->))
	
	If (ut_LoadRecordInteractive(Current form table:C627))
		OBJECT SET TITLE:C194(*; "PRV_Lock_BTN"; "Lock")
		OBJECT SET VISIBLE:C603(*; "PRV_Lock_BTN"; False:C215)
		OBJECT SET ENABLED:C1123(*; "PRV_AssignbValidate"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		//PRV_Enable_Form
	End if 
	
Else 
	
End if 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.bCancel