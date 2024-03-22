//Method: DesignForward
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/05/22, 13:20:25
	// ----------------------------------------------------
	//Created : 
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These form used only for when designer or admin logs in moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_POINTER:C301($AddForward_ptr; $forward_ptr)
		$AddForward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "v_1_230_txt")
		$forward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Forward")
		$AddForward_ptr->:=""
		$forward_ptr->:=vsForward
End case 
//End DesignForward