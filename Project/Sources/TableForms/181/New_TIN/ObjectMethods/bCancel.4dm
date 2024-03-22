
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 13:11:31
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].New_TIN.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/22/15 13:11:34)
	
End if 

CONFIRM:C162("Exit Inventory without saving new record?"; "Cancel"; "Exit")
If (OK=1)
Else 
	CANCEL TRANSACTION:C241
	CANCEL:C270
End if 
//End Object Method: [NTI_TunnelInfo].New_TIN.bCancel

