Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortStatus=0) | (vSortStatus=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ContractStatus;>)
			vSortStatus:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ContractStatus;<)
			vSortStatus:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortStatus)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 