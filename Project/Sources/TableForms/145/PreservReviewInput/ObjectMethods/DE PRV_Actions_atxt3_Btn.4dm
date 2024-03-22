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
		//C_LONGINT($Item_L)
		//$Item_L:=Self->
		//If ($Item_L>0)
		//[Preservation_Reviews]Action_s:=Self->{$Item_L}
		//PRV_ReviewInput_FM (On Data Change )
		//End if 
		PRV_PopupMenuC(Self:C308; Self:C308; ->[Preservation_Reviews:145]Action_s:8; "Enter Action"; (Self:C308->{Size of array:C274(Self:C308->)}))
		PRV_ReviewInput_FM(On Data Change:K2:15)
End case 

//End Object Method: [Preservation_Reviews].PreservReviewInput.PRV_Actions_atxt