Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortApprox=0) | (vSortApprox=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ApproxRemainingFund;>)
			vSortApprox:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ApproxRemainingFund;<)
			vSortApprox:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortApprox)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 