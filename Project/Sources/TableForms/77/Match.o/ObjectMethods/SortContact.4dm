Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortContact=0) | (vSortContact=2))
			ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ContactLName:4; >)
			vSortContact:=1
		Else 
			ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ContactLName:4; <)
			vSortContact:=2
		End if 
		
		vSortConslt:=0
		//vSortContact:=0
		vSortFunction:=0
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 