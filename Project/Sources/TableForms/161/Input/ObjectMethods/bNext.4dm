
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/25/14, 10:55:50
//----------------------------------------------------
//Method: Object Method: [LSS_DMeter].Input.bNext
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Next D-Meter Reading (PgDn)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		OBJECT SET HELP TIP:C1181(Self:C308->; $Tip_txt)
		OBJECT SET SHORTCUT:C1185(Self:C308->; Shortcut with Page down:K75:26; 0)
		
	: (Form event code:C388=On Clicked:K2:4)
		LSS_SelectedRow_L:=LSS_SelectedRow_L+1
		FM_SaveDMeter
		GOTO SELECTED RECORD:C245([LSS_DMeter:161]; LSS_SelectedRow_L)
		FM_DMeterInput(On Load:K2:1)
		
End case 
//End Object Method: [LSS_DMeter].Input.bNext

