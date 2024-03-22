If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/05, 14:59:24
	// ----------------------------------------------------
	// Method: Form Method: Input
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/7/08 16:53:46)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		If (Is new record:C668(Current form table:C627->))
			Inc_Sequence("MaintInvoiceAssign"; ->[Invoice_AssignNo_Maintenance:94]ID:6)
			[Invoice_AssignNo_Maintenance:94]InvoiceID:1:=[Invoice_Maintenance:95]InvoiceID:1
		End if 
		If ([Invoice_AssignNo_Maintenance:94]AssignNo:2=0)
			OBJECT SET ENTERABLE:C238(*; "DE_@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE_@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE_@"; <>Color_Not_Editable)
		Else 
			OBJECT SET ENTERABLE:C238(*; "DE_@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE_@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE_@"; <>Color_Editable)
		End if 
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(CM_AssgnDesc; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		//ALERT("Validating...")
End case 
