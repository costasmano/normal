//Method: DesignForward.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/05/22, 17:10:19
	// ----------------------------------------------------
	//Created : 
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These form used only for when designer or admin logs in moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2022-01-21T00:00:00 10:34:48)
	Mods_2022_01
	//  `allow for vsForward to be blank
End if 
//
C_POINTER:C301($AddForward_ptr; $forward_ptr)
$forward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Forward")
$AddForward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "v_1_230_txt")

If ($forward_ptr->="")
	CONFIRM:C162("vsForward will be blank. Proceed?"; "Proceed"; "Cancel")
	If (OK=1)
		vsForward:=$forward_ptr->
		CANCEL:C270
	End if 
Else 
	If (Length:C16($AddForward_ptr->)>0)
		CONFIRM:C162("Do you want to return and reset vsForward"; "Yes"; "No")
		If (OK=0)
			vsForward:=$forward_ptr->
			CANCEL:C270
		End if 
	Else 
		vsForward:=$forward_ptr->
		CANCEL:C270
	End if 
End if 





//End DesignForward.Button