
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/03/15, 11:32:52
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].Input.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (11/3/15 11:32:53)
	
End if 
NTI_MovingRecords_B:=False:C215
If (Modified record:C314([NTI_TunnelInfo:181]))
	CONFIRM:C162("Exit NTI_TunnelInfo record without saving?"; "Stay in form"; "Exit without saving")
	
	If (OK=1)
		//FM_SaveInventoryInput 
		//ACCEPT
	Else 
		CANCEL TRANSACTION:C241
		CANCEL:C270
	End if 
Else 
	CANCEL TRANSACTION:C241
	CANCEL:C270
	
End if 


//End Object Method: [NTI_TunnelInfo].Input.bCancel

