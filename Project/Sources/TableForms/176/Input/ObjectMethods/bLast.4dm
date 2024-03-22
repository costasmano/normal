
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 14:33:06
//----------------------------------------------------
//Method: Object Method: [LSS_UtResult].Input.bLast
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 14:33:07)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Last UT Result (Cmd-PgDn)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		OBJECT SET HELP TIP:C1181(Self:C308->; $Tip_txt)
		OBJECT SET SHORTCUT:C1185(Self:C308->; Shortcut with Page down:K75:26; Command key mask:K16:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		LSS_SelectedRow_L:=Records in selection:C76([LSS_UtResult:176])
		
		FM_SaveUTResults
		
		GOTO SELECTED RECORD:C245([LSS_UtResult:176]; LSS_SelectedRow_L)
		
		FM_UTResults(On Load:K2:1)
		
End case 
//End Object Method: [LSS_UtResult].Input.bLast