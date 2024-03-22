//%attributes = {"invisible":true}
If (False:C215)
	C_LONGINT:C283($FormWindow; $i; $j; $VWID)
	For ($i; 13; 1)
		ALERT:C41("Window Type : "+String:C10($i))
		$FormWindow:=Open form window:C675([Dialogs:21]; "InspectConfig"; $i)
		DIALOG:C40([Dialogs:21]; "InspectConfig")
		CLOSE WINDOW:C154
		If (ok=1)
			ALERT:C41("was OK")
		Else 
			ALERT:C41("was Not OK")
		End if 
	End for 
	ARRAY LONGINT:C221($aswindows; 0)
	WINDOW LIST:C442($aswindows; *)
	$j:=Size of array:C274($aswindows)
	C_TEXT:C284($vsText)  // Command Replaced was o_C_STRING length was 255
	C_TEXT:C284($vsPrcName)  // Command Replaced was o_C_STRING length was 40
	C_REAL:C285($viPrcState; $vPrcTime)
	For ($i; 1; $j)
		$VWID:=$aswindows{$i}
		$vsText:="for "+String:C10($i)+" Kind:"+String:C10(Window kind:C445($VWID))+" Proc:"+String:C10(Window process:C446($VWID))
		$vsText:=$vsText+" Title :<"+Get window title:C450($VWID)+">"
		PROCESS PROPERTIES:C336(Window process:C446($VWID); $vsPrcName; $viPrcState; $vPrcTime)
		$vsText:=$vsText+" PName:<"+$vsPrcName+">  Pstate:"+String:C10($viPrcState)
		//ALERT($vsText)
		//SHOW WINDOW($VWID)
	End for 
End if 
