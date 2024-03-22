Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortTotal=0) | (vSortTotal=2))
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]TotalEncumbered;>)
			vSortTotal:=1
		Else 
			//ORDER BY([Contract_Maintenance];[Contract_Maintenance]TotalEncumbered;<)
			vSortTotal:=2
		End if 
		
		DCM_SortOutputList("SORT"; ->vSortTotal)
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 