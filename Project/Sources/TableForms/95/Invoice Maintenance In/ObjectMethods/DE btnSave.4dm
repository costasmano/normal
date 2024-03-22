If (False:C215)
	// Date and time: 08/31/07, 09:43:38
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/25/08 10:12:33)
	Mods_2008_CM_5404
End if 

If (Form event code:C388=On Clicked:K2:4)
	If ((CM_InvoicePrcDateChg_b) & (([Invoice_Maintenance:95]TotalAmount:11>0) | (vInvoiceTotalPaid>0)))
		C_TEXT:C284($msg_txt)
		$msg_txt:="Sending Email notification to "+[Contract_Maintenance:97]ConsultantName:3+" Re: processing of this Invoice"
		$msg_txt:=$msg_txt+" for a Total Paid  amount of "+String:C10(vInvoiceTotalPaid; "$###,###,###,###.00")
		CONFIRM:C162($msg_txt; "Proceed"; "Send No Email")
		If (OK=1)
			If (CM_MailInvoiceNotice)
			Else 
				ALERT:C41("Error Sending Notification Email!")
			End if 
		End if 
	Else 
	End if 
	
	If (False:C215)
		If (Is new record:C668([Invoice_Maintenance:95]))
			LogNewRecord(->[Contract_Maintenance:97]ContractNo:1; ->[Invoice_Maintenance:95]ContractNo:3; ->[Invoice_Maintenance:95]InvoiceID:1; 1; "InvoiceMaint")
		End if 
	End if 
End if 