
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/25/14, 10:48:16
//----------------------------------------------------
//Method: Object Method: [LSS_DMeter].Input.bFirst
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 16:10:27)
	// Modified by: Costas Manousakis-(Designer)-(6/22/17 16:52:23)
	Mods_2017_06_bug
	//  `fixed missing case statement for load and clicked events
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="First D-Meter Reading (Cmd-PgUp)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		
		OBJECT SET HELP TIP:C1181(Self:C308->; $Tip_txt)
		OBJECT SET SHORTCUT:C1185(Self:C308->; Shortcut with Page up:K75:25; Command key mask:K16:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		LSS_SelectedRow_L:=1
		FM_SaveDMeter
		
		GOTO SELECTED RECORD:C245([LSS_DMeter:161]; LSS_SelectedRow_L)
		
		FM_DMeterInput(On Load:K2:1)
End case 

//End Object Method: [LSS_DMeter].Input.bFirst

