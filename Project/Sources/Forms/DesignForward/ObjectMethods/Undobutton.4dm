//Method: DesignForward.ResetButton1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-01-13T00:00:00, 19:30:20
	// ----------------------------------------------------
	//Created : 
End if 
//
//
C_POINTER:C301($AddForward_ptr; $forward_ptr)
$AddForward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "v_1_230_txt")
$forward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Forward")
CONFIRM:C162("Undo changes made to vsForward back to original ["+vsForward+"] ?")
If (Ok=1)
	$forward_ptr->:=vsForward
End if 

//End DesignForward.ResetButton1