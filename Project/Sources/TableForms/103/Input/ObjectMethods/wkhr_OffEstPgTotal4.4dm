If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/6/08 15:48:17)
	Mods_2008_CM_5403("WKHRS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(WKHR_ShowOffEstTotals_B)
		WKHR_ShowOffEstTotals_B:=True:C214
	: (Form event code:C388=On Clicked:K2:4)
		If (WKHR_ShowOffEstTotals_B)
			WKHR_ShowOffEstTotals_B:=False:C215
			OBJECT SET TITLE:C194(*; "wkhr_OffEstPgTotal4"; "Hide Off.Est")
			WKHR_CalcOffEstTotals
		Else 
			WKHR_ShowOffEstTotals_B:=True:C214
			OBJECT SET TITLE:C194(*; "wkhr_OffEstPgTotal4"; "Office Est.")
			//WKHR_CalcTotals 
			If (WKHR_ShowRevTotals_B)
				WKHR_CalcTotals
			Else 
				WKHR_CalcReviewTotals
			End if 
			
		End if 
		
End case 