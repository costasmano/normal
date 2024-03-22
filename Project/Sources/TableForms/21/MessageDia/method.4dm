C_LONGINT:C283(viMinDelay)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vlMessageTimerLimit)
C_LONGINT:C283(vlMessageTimerCount)
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(3/23/2007 16:01:46)
	Mods_2007_CM07
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (viMinDelay=0)  //if delay has not been set before form is loaded
			viMinDelay:=3
		End if 
		SET TIMER:C645(60*60*viMinDelay)  //timer on x minutes
		If (vlMessageTimerLimit=0)
			vlMessageTimerLimit:=20
		End if 
		vlMessageTimerCount:=0
	: (Form event code:C388=On Timer:K2:25)
		vlMessageTimerCount:=vlMessageTimerCount+1
		vtMessage:=vtMessage+"."
		REDRAW WINDOW:C456
		BEEP:C151
		BEEP:C151
		BEEP:C151
		
		If (vlMessageTimerCount>vlMessageTimerLimit)
			CANCEL:C270
		End if 
End case 
