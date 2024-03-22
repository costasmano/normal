Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortAssign=0) | (vSortAssign=2))
			ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]AssignStatus:24; >)
			vSortAssign:=1
		Else 
			ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]AssignStatus:24; <)
			vSortAssign:=2
		End if 
		
		vSortContract:=0
		vSortDistrict:=0
		vSortCity:=0
		vSortItem8:=0
		vSortInspType:=0
		vSortInspMonth:=0
		vSortNTP:=0
		vSortInspReceived:=0
		// vSortAssign:=0
		vSortConsultant:=0
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 