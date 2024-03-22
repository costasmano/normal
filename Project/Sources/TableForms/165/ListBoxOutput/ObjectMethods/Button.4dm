//Method: Object Method: [LSS_Inventory].ListBoxOutput.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/16/16, 14:34:53
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		m_ListInspReview
End case 

//End Object Method: [LSS_Inventory].ListBoxOutput.Button