If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/06/07, 09:14:20
	// ----------------------------------------------------
	// Method: Object Method: MailNotice
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((Current user:C182="Designer") | (User in group:C338(Current user:C182; "Conslt Rating")))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If ([Contract Invoice:84]TotalAmount:11>0)
			C_TEXT:C284($msg_txt)
			$msg_txt:="Sending Email notification to "+[Contracts:79]ConsltName:3+" Re: processing of this Invoice"
			$msg_txt:=$msg_txt+" for a Total Paid amount of "+String:C10([Contract Invoice:84]TotalAmount:11; "$###,###,###,###.00")
			CONFIRM:C162($msg_txt; "Proceed"; "Send No Email")
			If (OK=1)
				If (CM_MailInvoiceNotice_2)
				Else 
					ALERT:C41("Error Sending Notification Email!")
				End if 
				
			End if 
		End if 
End case 
