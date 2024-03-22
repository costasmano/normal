Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortCDate=0) | (vSortCDate=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]InitialCompleteDate;>)
			vSortCDate:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]InitialCompleteDate;<)
			vSortCDate:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortCDate)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 