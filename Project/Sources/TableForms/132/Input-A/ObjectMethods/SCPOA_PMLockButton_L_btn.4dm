If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/08/11, 11:42:34
	// ----------------------------------------------------
	// Method: Object Method: SCPOA_PMLockButton_L
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_06
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=1
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=0)
				SCPOA_SetEnterable_Name("SCPOA_PM@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "SCPOA_PM@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(*; "SCPOA_PMLockButton_L"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			: (Self:C308->=1)
				If (ut_LoadRecordInteractive(->[ScourPOA:132]))
					InitChangeStack(1)
					OBJECT SET ENABLED:C1123(SCPOA_Validate_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					SCPOA_SetEnterable_Name("SCPOA_PM@"; True:C214)
					OBJECT SET ENABLED:C1123(*; "SCPOA_PM@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				Else 
					SCPOA_SetEnterable_Name("SCPOA_PM@"; False:C215)
					OBJECT SET ENABLED:C1123(*; "SCPOA_PM@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "SCPOA_PMLockButton_L"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					Self:C308->:=0
				End if 
				
		End case 
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(SCPOA_OldGenMsg_txt; vGenericHlpMsgVar1_S)
		SCPOA_OldGenMsg_txt:=vGenericHlpMsgVar1_S
		If (Self:C308->=0)
			vGenericHlpMsgVar1_S:="Click to Unlock the PM Review Info"
		Else 
			vGenericHlpMsgVar1_S:="Click to Lock the PM Review Info"
		End if 
		
	: (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284(SCPOA_OldGenMsg_txt; vGenericHlpMsgVar1_S)
		If (SCPOA_OldGenMsg_txt#"")
			vGenericHlpMsgVar1_S:=SCPOA_OldGenMsg_txt
		End if 
End case 