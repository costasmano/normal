If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/31/06, 14:55:35
	// ----------------------------------------------------
	// Method: Form Method: MyConfirm
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM06
	
	// Date and time: 08/30/07, 10:55:54
	Mods_2007_CM12_5301
	
	// Modified by: costasmanousakis-(Designer)-(4/23/08 13:35:54)
	Mods_2008_CM_5403  //Added timer possibility
	// Modified by: costasmanousakis-(Designer)-(12/18/09 15:53:33)
	Mods_2009_12
	//Adjusted the code so that the 'cancel' button moves if the OK is resized
	Mods_2011_06  // CJ Miller`06/20/11, 10:42:51      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(4/12/21 15:40:03)
	Mods_2021_04
	//  `made object vtMessage as multi-style text
	// Modified by: Costas Manousakis-(Designer)-(2021-10-25T00:00:00 19:12:53)
	Mods_2021_10
	//  `made text transparent/no border, also no border on picture button - clear var on pic button
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($BtnOK_bestW_L; $BtnCanc_bestW_L)
		C_LONGINT:C283($BtnWdiff; $BtnL_L; $btnT_L; $btnR_L; $btnB_L; $btnOKW_L; $btnCancW_L; $Btnmargin_L; $BtnOKMove_L; $winL_L)
		$Btnmargin_L:=35
		$BtnOKMove_L:=0
		C_TEXT:C284(vButtonOK_txt; vButtonCancel_txt)
		If (vButtonOK_txt#"")
			OBJECT SET TITLE:C194(*; "ButtonOK"; vButtonOK_txt)
			OBJECT GET BEST SIZE:C717(vButtonOK_txt; $BtnOK_bestW_L; $winL_L)
			OBJECT GET COORDINATES:C663(*; "ButtonOK"; $BtnL_L; $btnT_L; $btnR_L; $btnB_L)
			$btnOKW_L:=$btnR_L-$BtnL_L
			If (($btnOKW_L-$Btnmargin_L)<$BtnOK_bestW_L)
				$BtnWdiff:=$BtnOK_bestW_L-($btnOKW_L-$Btnmargin_L)
				OBJECT MOVE:C664(*; "ButtonOK"; (-($BtnWdiff)); 0; ($BtnWdiff); 0)
				$BtnOKMove_L:=$BtnWdiff
			End if 
		End if 
		$BtnWdiff:=0
		If (vButtonCancel_txt#"")
			OBJECT SET TITLE:C194(*; "ButtonCancel"; vButtonCancel_txt)
			OBJECT GET BEST SIZE:C717(vButtonCancel_txt; $BtnCanc_bestW_L; $winL_L)
			OBJECT GET COORDINATES:C663(*; "ButtonCancel"; $BtnL_L; $btnT_L; $btnR_L; $btnB_L)
			$btnCancW_L:=$btnR_L-$BtnL_L
			If (($btnCancW_L-$Btnmargin_L)<$BtnCanc_bestW_L)
				$BtnWdiff:=$BtnCanc_bestW_L-($btnCancW_L-$Btnmargin_L)
			End if 
		End if 
		OBJECT MOVE:C664(*; "ButtonCancel"; (-($BtnWdiff+$BtnOKMove_L)); 0; ($BtnWdiff); 0)
		
		C_LONGINT:C283(viMinDelay)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283(vlMessageTimerLimit)
		C_LONGINT:C283(vlMessageTimerCount)
		If (viMinDelay=0)  //if delay has not been set before form is loaded
			viMinDelay:=0
		End if 
		If (viMinDelay>0)
			SET TIMER:C645(60*60*viMinDelay)  //timer on x minutes
			If (vlMessageTimerLimit=0)
				vlMessageTimerLimit:=20
			End if 
			vlMessageTimerCount:=0
		End if 
		
	: (Form event code:C388=On Timer:K2:25)
		vlMessageTimerCount:=vlMessageTimerCount+1
		vtMessage:=vtMessage+" . "
		REDRAW WINDOW:C456
		BEEP:C151
		BEEP:C151
		BEEP:C151
		If (vlMessageTimerCount>vlMessageTimerLimit)
			CANCEL:C270
		End if 
		
End case 