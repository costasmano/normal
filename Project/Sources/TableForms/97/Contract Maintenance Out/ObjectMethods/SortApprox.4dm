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
		
		vSortContract:=0
		vSortType:=0
		vSortStatus:=0
		vSortName:=0
		vSortADate:=0
		vSortCDate:=0
		vSortEDate:=0
		vSortTotal:=0
		// vSortApprox:=0
		vSortActual:=0
		CM_SortOutputList
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 