If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/22/07, 10:58:02
	// ----------------------------------------------------
	// Method: Form Method: Invoice Maintenance In
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 09:42:03)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/25/08 10:13:22)
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(7/31/08 15:57:32)
	Mods_2008_CM_5404
	//  `Increase ht of dollar variables, increased vert margin to 20
	// Modified by: costasmanousakis-(Designer)-(10/7/08 16:51:24)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(2)
		If (Is new record:C668([Invoice_Maintenance:95]))
			[Invoice_Maintenance:95]ContractNo:3:=[Contract_Maintenance:97]ContractNo:1
			Inc_Sequence("InvoiceMaint"; ->[Invoice_Maintenance:95]InvoiceID:1)
			[Invoice_Maintenance:95]InvoiceNo:2:=(CM_InvNo_aL{Size of array:C274(CM_InvNo_aL)})+1
			[Invoice_Maintenance:95]DateReceived:4:=Current date:C33(*)
		End if 
		RELATE MANY:C262([Invoice_Maintenance:95])
		//QUERY([Invoice_AssignNo_Maintenance];[Invoice_AssignNo_Maintenance]InvoiceID=[Invoice_Maintenance]InvoiceID)
		ORDER BY:C49([Invoice_AssignNo_Maintenance:94]; [Invoice_AssignNo_Maintenance:94]AssignNo:2)
		CM_AssignmentSums
		CM_UpdateInvoiceTotals
		C_BOOLEAN:C305(CM_InvoicePrcDateChg_b)
		CM_InvoicePrcDateChg_b:=False:C215
		If ([Invoice_Maintenance:95]DateProcessFoward:9#!00-00-00!)
			OBJECT SET VISIBLE:C603(*; "MailNotice"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "MailNotice"; False:C215)
		End if 
		If ([Invoice_Maintenance:95]Retainage:16<0)
			//Only retainage
			OBJECT SET VISIBLE:C603(*; "DE AddRatingBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE Subform@"; False:C215)
			DERetainage:=1
		End if 
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(MailNotice; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		RELATE MANY:C262([Invoice_Maintenance:95])
		//QUERY([Invoice_AssignNo_Maintenance];[Invoice_AssignNo_Maintenance]InvoiceID=[Invoice_Maintenance]InvoiceID)
		ORDER BY:C49([Invoice_AssignNo_Maintenance:94]; [Invoice_AssignNo_Maintenance:94]AssignNo:2)
		CM_UpdateInvoiceTotals
		
	: (Form event code:C388=On Validate:K2:3)
		If (False:C215)
			If (Is new record:C668([Invoice_Maintenance:95]))
				//LogNewRecord(->
			End if 
			FlushGrpChgs(2; ->[Contract_Maintenance:97]ContractNo:1; ->[Invoice_Maintenance:95]ContractNo:3; ->[Invoice_Maintenance:95]InvoiceID:1; 1)
		End if 
	: (Form event code:C388=On Unload:K2:2)
		OBJECT SET ENTERABLE:C238(*; "@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End case 