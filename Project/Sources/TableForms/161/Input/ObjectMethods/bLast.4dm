
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/25/14, 10:56:03
//----------------------------------------------------
//Method: Object Method: [LSS_DMeter].Input.bLast
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Last D-Meter Reading (Cmd-PgDn)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		OBJECT SET HELP TIP:C1181(Self:C308->; $Tip_txt)
		OBJECT SET SHORTCUT:C1185(Self:C308->; Shortcut with Page down:K75:26; Command key mask:K16:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		LSS_SelectedRow_L:=Records in selection:C76([LSS_DMeter:161])
		FM_SaveDMeter
		SAVE RECORD:C53([LSS_DMeter:161])
		GOTO SELECTED RECORD:C245([LSS_DMeter:161]; LSS_SelectedRow_L)
		FM_DMeterInput(On Load:K2:1)
		
End case 
//End Object Method: [LSS_DMeter].Input.bLast