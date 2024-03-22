If (False:C215)
	//Form Method: [Contract Invoice];"ContractInvoice In" 
	Mods_2005_CM13
	// Modified by: costasmanousakis-(Designer)-(11/6/2007 09:15:08)
	Mods_2007_CM12_5302
	If (False:C215)
		// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
		Mods_2008_CM_5404  // ("ACCESS")
	End if 
	// Modified by: Costas Manousakis-(Designer)-(6/4/13 09:57:00)
	Mods_2013_06
	//  `set double-click on line and double-click on empty line to no action in  included assignment form 
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 14:43:19)
	Mods_2016_02_bug
	//  `added splitter - enabled resizing of comments and asignement list
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(CM_InvoicePrcDateChg_b)
		CM_InvoicePrcDateChg_b:=False:C215
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		If (Is new record:C668([Contract Invoice:84]))
			[Contract Invoice:84]ContractNo:3:=[Contracts:79]ContractNo:1
			Inc_Sequence("ConInvoice"; ->[Contract Invoice:84]InvoiceID:1)
		End if 
		ORDER BY:C49([Contract Invoice AssignNo:85]AssignNo:2; >)
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		If (InspRtgContrAccess_b)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (False:C215)
			FlushGrpChgs(1; ->[Contracts:79]ContractNo:1; ->[Contract Invoice:84]ContractNo:3; ->[Contract Invoice:84]InvoiceID:1; 1)
		End if 
End case 