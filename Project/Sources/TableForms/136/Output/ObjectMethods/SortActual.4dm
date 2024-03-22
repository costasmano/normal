Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortActual=0) | (vSortActual=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ActualRemainingFund;>)
			vSortActual:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ActualRemainingFund;<)
			vSortActual:=2
		End if 
		DCM_SortOutputList("SORT"; ->vSortActual)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 