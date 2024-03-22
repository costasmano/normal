Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortADate=0) | (vSortADate=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]AwardContractDate;>)
			vSortADate:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]AwardContractDate;<)
			vSortADate:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortADate)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 