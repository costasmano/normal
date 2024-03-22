
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/31/15, 15:48:34
//----------------------------------------------------
//Method: Object Method: [LSS_ElementInspection].Input.bNext
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 15:48:35)
	
End if 
Case of 
	: ((Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Enter:K2:33))
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Next Element (PgDn)"
		
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		FM_SaveElementInspection
		
		LSS_SelectedRow_L:=LSS_SelectedRow_L+1
		LSS_LoadElementInspectionRecord
		FM_ElementInspection(On Load:K2:1)
		
End case 
//End Object Method: [LSS_ElementInspection].Input.bNext