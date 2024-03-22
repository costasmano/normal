Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305(WKHR_ShowRevTotals_B)
		If (WKHR_ShowRevTotals_B)
			WKHR_ShowRevTotals_B:=False:C215
			OBJECT SET TITLE:C194(*; "ShowReviewtotals"; "Show Proposal Totals")
			WKHR_CalcReviewTotals
		Else 
			WKHR_ShowRevTotals_B:=True:C214
			OBJECT SET TITLE:C194(*; "ShowReviewtotals"; "Show Reviewer Totals")
			WKHR_CalcTotals
		End if 
		
End case 
