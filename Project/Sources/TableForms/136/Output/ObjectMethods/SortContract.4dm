Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortContract=0) | (vSortContract=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ContractNo;>)
			vSortContract:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ContractNo;<)
			vSortContract:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortContract)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 