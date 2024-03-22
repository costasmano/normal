If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 08/28/14, 12:05:28
	// ----------------------------------------------------
	// Method: Object Method: [LSS_SignPanel].Input.LSS_SignPanel_as
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(5/16/16 11:31:12)
	Mods_2016_05_bug
	//  `do not show panel type if it is blank ; when choosing Other go to Panel type field
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		LSS_SignPanel_as:=Find in array:C230(LSS_SignPanel_as; [LSS_SignPanel:172]LSS_PanelType_s:7)
		OBJECT SET VISIBLE:C603(*; "LSS_PanelType_s"; False:C215)
		If ((LSS_SignPanel_as<1) & ([LSS_SignPanel:172]LSS_PanelType_s:7#""))
			OBJECT SET VISIBLE:C603(*; "LSS_PanelType_s"; True:C214)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		If (LSS_SignPanel_as>0)
			If (LSS_SignPanel_as{LSS_SignPanel_as}="Other")
				OBJECT SET VISIBLE:C603(*; "LSS_PanelType_s"; True:C214)
				GOTO OBJECT:C206(*; "LSS_PanelType_s")
			Else 
				OBJECT SET VISIBLE:C603(*; "LSS_PanelType_s"; False:C215)
				[LSS_SignPanel:172]LSS_PanelType_s:7:=LSS_SignPanel_as{LSS_SignPanel_as}
			End if 
		End if 
End case 