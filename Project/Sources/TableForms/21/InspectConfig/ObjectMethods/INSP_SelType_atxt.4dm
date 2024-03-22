// Method: Object Method: [Dialogs].InspectConfig.INSP_SelType_atxt
// Description
// 
// 
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/02/12, 15:56:16
	// ----------------------------------------------------
	// First Release
	Mods_2012_11
	// Modified by: Costas Manousakis-(Designer)-(12/26/12 11:41:12)
	Mods_2012_12
	//  `More mods for the use of Page 2 both in On Load and On Clicked events
	// Modified by: Costas Manousakis-(Designer)-(5/30/14 13:50:37)
	Mods_2014_05
	//  `Modified to account for the "labels" added in the INSP_SelType_atxt array.
End if 
C_LONGINT:C283($FormEvent_L)

$FormEvent_L:=Form event code:C388
Case of 
		
	: ($FormEvent_L=On Clicked:K2:4)
		C_LONGINT:C283($itemClick_L)
		$itemClick_L:=INSP_SelType_atxt
		C_TEXT:C284($TypeSel_txt)
		
		If ($itemClick_L>0)
			$TypeSel_txt:=INSP_SelTypeCode_atxt{$itemClick_L}
			INSP_SelectedNewInspType_txt:=$TypeSel_txt
			
			If ($TypeSel_txt#"--@")
				OBJECT SET ENABLED:C1123(*; "bSelectType"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				OBJECT SET ENABLED:C1123(*; "bSelectType"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				INSP_SelType_atxt:=0
			End if 
			
		End if 
		
End case 