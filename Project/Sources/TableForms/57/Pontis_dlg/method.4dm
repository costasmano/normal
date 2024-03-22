If (False:C215)
	// ----------------------------------------------------
	// Form Method: Pontis_dlg
	// User name (OS): cjmiller
	// Date and time: 12/13/05, 10:21:48
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM04
	Mods_2011_06  // CJ Miller`06/20/11, 11:12:31      ` Type all local variables for v11
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET FONT:C164([Preferences:57]Pontis_Password_s:15; "%Password")
		C_LONGINT:C283($Width_l; $Height_l; $Win)
		
		If (<>PL_LPlatfrm=3)  //windows
			FORM GOTO PAGE:C247(2)
			$Width_l:=680
			$Height_l:=360
		Else 
			FORM GOTO PAGE:C247(1)
			$Width_l:=680
			$Height_l:=360
		End if 
		$Win:=Frontmost window:C447
		ut_ResizeWindow($Win; $Width_l; $Height_l)
		
End case 
//End Form Method: Pontis_dlg