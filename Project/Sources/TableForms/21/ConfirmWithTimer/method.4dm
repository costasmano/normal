// ----------------------------------------------------
// Form Method: ConfirmWithTimer
// User name (OS): charlesmiller
// Date and time: 06/28/11, 12:07:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  // CJ Miller`06/28/11, 12:07:07      `Make on server starup use confirm with a timer
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(CONFIRMTIMERDELAY_L)
		If (CONFIRMTIMERDELAY_L<=0)
			CONFIRMTIMERDELAY_L:=20
		End if 
		SET TIMER:C645(CONFIRMTIMERDELAY_L*60)  // set timer for 20 seconds
	: (Form event code:C388=On Timer:K2:25)
		//OK nothing happened cancel form
		CANCEL:C270
		
End case 
//End Form Method: ConfirmWithTimer