//Method: UserandGroupFiles.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/13/21, 15:14:05
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
End if 
//

C_LONGINT:C283($Col_l; $Row_L)

LISTBOX GET CELL POSITION:C971(*; "UGListBox"; $Col_l; $Row_L)

If ($Row_L>0) & ($Row_L<=Size of array:C274(v_1_214_ad))
	
	CONFIRM:C162("Delete User and Group File Named "+v_1_225_atxt{$Row_L}+" Created on "+String:C10(v_1_214_ad{$Row_L}; Internal date short:K1:7)+" at "+String:C10(v_1_193_atm{$Row_L}; HH MM AM PM:K7:5))
	If (OK=1)
		ut_DeleteUGOnServer(v_1_225_txt+v_1_225_atxt{$Row_L})
	End if 
End if 

//End UserandGroupFiles.Button