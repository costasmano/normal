
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/14/15, 16:45:49
//----------------------------------------------------
//Method: Object Method: [LSS_VerticalClearance].Input.bPrevious
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/14/15 16:46:04)
	
End if 
Case of 
	: ((Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Enter:K2:33))
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Previous Vertical Clearance (PgUp)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		FM_SaveVerticalClearance
		
		
		LSS_SelectedRow_L:=LSS_SelectedRow_L-1
		
		GOTO SELECTED RECORD:C245([LSS_VerticalClearance:177]; LSS_SelectedRow_L)
		
		
		FM_VerticalClearance(On Load:K2:1)
End case 
//End Object Method: [LSS_VerticalClearance].Input.bPrevious