//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_Fundings_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/12, 15:52:01
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/23/13 16:25:43)
	Mods_2013_09
	//  `
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=0
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		//POPUPMENUC (Self;Self;->[Contract_Assignment_Maintenance]Funding_s)
		PRV_PopupMenuC(->PRV_Fundings_atxt; ->PRV_Fundings_atxt; ->[Contract_Assignment_Maintenance:101]Funding_s:53; "Enter Funding")
		[Contract_Assignment_Maintenance:101]FHWAOverSight_b:55:=([Contract_Assignment_Maintenance:101]Funding_s:53="FA")
		
End case 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_Fundings_atxt