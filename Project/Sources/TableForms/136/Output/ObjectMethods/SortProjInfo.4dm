Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortProjInfo=0) | (vSortProjInfo=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ContractNo;>)
			vSortProjInfo:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ContractNo;<)
			vSortProjInfo:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortProjInfo)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 