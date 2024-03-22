//Method: Object Method: SelectListBox.NewLB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/22/13, 14:01:40
	// ----------------------------------------------------
	//Created : 
	Mods_2013_09
End if 
//
If (Form event code:C388=On Header Click:K2:40)
	ALERT:C41("click hdr")
End if 
If (Form event code:C388=On Double Clicked:K2:5)
	C_LONGINT:C283($size_of_L; $line_L)
	$size_of_L:=Size of array:C274(NewLB)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274(NewLB))
		
		If (NewLB{$loop_L})
			$line_L:=$loop_L
			$loop_L:=$size_of_L+1
		End if 
	End for 
	ALERT:C41("double click line "+String:C10($line_L))
	
End if 

//End Object Method: SelectListBox.NewLB