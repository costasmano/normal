Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortEDate=0) | (vSortEDate=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ExtendedCompleteDate;>)
			vSortEDate:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ExtendedCompleteDate;<)
			vSortEDate:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortEDate)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 