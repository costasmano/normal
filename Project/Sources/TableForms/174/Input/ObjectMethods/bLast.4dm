
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/14/15, 17:19:28
//----------------------------------------------------
//Method: Object Method: [LSS_TowerDistance].Input.bLast
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/14/15 17:19:29)
	
End if 
Case of 
	: ((Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Enter:K2:33))
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Last Tower Distance (Cmd-PgDn)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		FM_SaveTowerDistance
		USE NAMED SELECTION:C332("LSS_TowerDistance")
		LSS_SelectedRow_L:=Records in selection:C76([LSS_TowerDistance:174])
		
		GOTO SELECTED RECORD:C245([LSS_TowerDistance:174]; LSS_SelectedRow_L)
		
		
		FM_TowerDistance(On Load:K2:1)
End case 
//End Object Method: [LSS_TowerDistance].Input.bLast