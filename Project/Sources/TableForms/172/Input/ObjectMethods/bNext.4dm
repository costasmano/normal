
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/20/14, 15:58:03
//----------------------------------------------------
//Method: Object Method: [LSS_SignPanel].Input.bNext
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_03  // 
	//Modified by: administrator (11/20/14 15:58:05)
	
End if 
Case of 
	: ((Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Enter:K2:33))
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Next Sign Panel (PgDn)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		FM_SaveSignPanel
		
		USE NAMED SELECTION:C332("LSS_SignPanel")
		LSS_SelectedRow_L:=LSS_SelectedRow_L+1
		
		GOTO SELECTED RECORD:C245([LSS_SignPanel:172]; LSS_SelectedRow_L)
		
		
		FM_SignPanel(On Load:K2:1)
End case 
//End Object Method: [LSS_SignPanel].Input.bNext