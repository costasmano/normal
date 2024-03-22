If (False:C215)
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(4/18/2007 08:34:38)
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(2021-10-25T00:00:00 14:43:04)
	Mods_2021_10
	//  `resized vTextMssg - changed it to multi-style and re-arranged/re-sized objects for better fit 
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (Position:C15("Inventory Photo"; vTextMsg)>0)
			OBJECT SET VISIBLE:C603(*; "bPrintReviewCmts"; False:C215)
			OBJECT MOVE:C664(*; "@btn"; 25; 0)
		Else 
			OBJECT SET VISIBLE:C603(*; "bPrintReviewCmts"; True:C214)
		End if 
		
End case 
