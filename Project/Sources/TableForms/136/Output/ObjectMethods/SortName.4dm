Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortName=0) | (vSortName=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ConsultantName;>)
			vSortName:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]ConsultantName;<)
			vSortName:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortName)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 