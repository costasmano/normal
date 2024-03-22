//Method: [Dialogs].TransferSet.UserList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: Jun 15, 2022, 10:16:44
	// ----------------------------------------------------
	//Created : 
	
End if 
//
C_POINTER:C301($user_ptr)
$user_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
		
	: ($FormEvent_L=On Clicked:K2:4) | ($FormEvent_L=On Data Change:K2:15)
		C_LONGINT:C283($item)
		$item:=$user_ptr->
		If ($item>0)
			vTxUsername:=$user_ptr->{$item}
		End if 
End case 


//End [Dialogs].TransferSet.UserList