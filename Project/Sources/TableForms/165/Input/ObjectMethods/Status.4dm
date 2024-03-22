If (False:C215)
	//[LSS_Inventory];"Input".Status
	// Modified by: manousakisc-(Designer)-(9/6/2023 14:15:05)
	Mods_2023_09
	//  `Object has only 'On clicked' enabled - Ask user to confirm when changing the status.
	
End if 

C_POINTER:C301($me_ptr)
$me_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
C_LONGINT:C283($indx_L)
$indx_L:=$me_ptr->
If ([LSS_Inventory:165]LSS_Status_s:35#$me_ptr->{$indx_L})
	CONFIRM:C162("Changing status from "+[LSS_Inventory:165]LSS_Status_s:35+" to "+$me_ptr->{$indx_L}+" ! Proceed?"; "Cancel"; "Proceed")
	If (OK=0)
		[LSS_Inventory:165]LSS_Status_s:35:=$me_ptr->{$indx_L}
	Else 
		POPUPMENUC($me_ptr; $me_ptr; ->[LSS_Inventory:165]LSS_Status_s:35; On Load:K2:1)
	End if 
End if 
//POPUPMENUC ($me_ptr;$me_ptr;->[LSS_Inventory]LSS_Status_s)
LSS_StatusControls
