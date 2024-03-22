//%attributes = {"invisible":true}
//Launch_CtrlClientProc
//Method designed to start in it's own process the
//ControlClientProcess  method.
//Can be as the startup method of user BMSExternal Server

If (False:C215)
	//Process name MUST NOT start with $ !!!!
	Mods_2004_CM03
	// Modified by: Costas Manousakis-(Designer)-(7/21/20 16:47:53)
	Mods_2020_07_bug
	//  `changed stack size to 0 (use default) Call Reference #732, #731
	// Modified by: Costas Manousakis-(Designer)-(8/11/20 17:19:16)
	Mods_2020_08_bug
	//  `modified to launch in a local process the Control panel for BMS External server instead of starting ControlClientProcess method
	// Modified by: Costas Manousakis-(Designer)-(8/20/20 10:39:31)
	Mods_2020_08_bug
	//  `changed location of new window to upper left (2)
	// Modified by: Costas Manousakis-(Designer)-(8/28/20 10:18:57)
	Mods_2020_08_bug
	//  `on load will launch the controlclient process after a delay of 5 minutes
	
	C_TEXT:C284(Launch_CtrlClientProc; $1)
End if 

If (Not:C34(<>fQuit))
	
	If (Count parameters:C259=0)
		C_LONGINT:C283($lpid)
		$lpid:=LSpawnProcess("Launch_CtrlClientProc"; 0; "$BMSExternalDash"; True:C214; False:C215; "run")
	Else 
		C_TEXT:C284($1)
		//on load will launch the controlclient process after a delay of 5 minutes
		//data for the count down dlg
		C_DATE:C307(vdate)
		C_TIME:C306(vTimeM)
		vTimeM:=Current time:C178
		vdate:=Current date:C33
		AddToDateTime(->vdate; ->vTimeM; 0; 0; 0; ?00:05:00?)
		C_TEXT:C284(vsDialogTxt)
		vsDialogTxt:="If you don't do anything, the Control Client process will be launched at the end of this timer."
		C_LONGINT:C283($FW; $FL)
		
		FORM GET PROPERTIES:C674("CountDownTimer"; $FW; $FL)
		NewWindow($FW; $FL; 0; Plain window:K34:13; "Count Down to launch")
		DIALOG:C40("CountDownTimer")
		If (OK=1)
			//start client contorl process 
			If (Not:C34(<>fQuit))
				C_LONGINT:C283($pid)
				$pid:=New process:C317("ControlClientProcess"; 0; "Control Client Process"; *)
			End if 
		End if 
		CLOSE WINDOW:C154
		
		If (Not:C34(<>fQuit))
			FORM GET PROPERTIES:C674("BMSExternalClientControl"; $FW; $FL)
			NewWindow($FW; $FL; 2; -(Palette form window:K39:9); "Control Panel"; "ut_CloseCancel")  //by passing the ut_closecancel it shows the red dot to close window
			DIALOG:C40("BMSExternalClientControl")
			CLOSE WINDOW:C154
		End if 
	End if 
Else 
	ALERT:C41("Application is quiting!")
End if 