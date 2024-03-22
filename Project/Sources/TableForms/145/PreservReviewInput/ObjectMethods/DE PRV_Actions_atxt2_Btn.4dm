//Method: Object Method: [Preservation_Reviews].PreservReviewInput.PRV_Actions_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/12, 14:09:20
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=0
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Item_L)
		$Item_L:=Self:C308->
		If ($Item_L>0)
			[Preservation_Reviews:145]Action_s:8:=Self:C308->{$Item_L}
			PRV_ReviewInput_FM(On Data Change:K2:15)
		End if 
		
End case 

//End Object Method: [Preservation_Reviews].PreservReviewInput.PRV_Actions_atxt