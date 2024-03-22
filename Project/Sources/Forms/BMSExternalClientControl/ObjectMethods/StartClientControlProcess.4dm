//Method: "BMSExternalClientControl".StartClientControlProcess
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 11:43:47
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Not:C34(<>fQuit))
			C_LONGINT:C283($pid)
			$pid:=New process:C317("ControlClientProcess"; 0; "Control Client Process"; *)
			ALERT:C41("Started or found process "+String:C10($pid))
		Else 
			ALERT:C41("Application is quiting!!!")
		End if 
End case 

//End "BMSExternalClientControl".StartClientControlProcess