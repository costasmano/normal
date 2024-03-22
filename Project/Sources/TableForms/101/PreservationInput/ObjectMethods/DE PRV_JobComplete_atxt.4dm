//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_JobComplete_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/15/13, 17:06:14
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=0
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($item_L)
		$item_L:=Self:C308->
		Case of 
			: (Self:C308->{$item_L}="Y")
				[Contract_Assignment_Maintenance:101]Completed_L:54:=1
			: (Self:C308->{$item_L}="N")
				[Contract_Assignment_Maintenance:101]Completed_L:54:=0
				
		End case 
		Self:C308->:=0
End case 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_JobComplete_atxt