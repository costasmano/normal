
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/31/15, 15:48:23
//----------------------------------------------------
//Method: Object Method: [LSS_ElementInspection].Input.bLast
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 15:48:24)
	
End if 
Case of 
	: ((Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Enter:K2:33))
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Last Element (Cmd-PgDn)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		FM_SaveElementInspection
		LSS_SelectedRow_L:=Size of array:C274(v_163_007_atxt)
		LSS_LoadElementInspectionRecord
		FM_ElementInspection(On Load:K2:1)
		
End case 
//End Object Method: [LSS_ElementInspection].Input.bLast