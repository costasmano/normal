Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortADVDate=0) | (vSortADVDate=2))
			ORDER BY:C49([Bridge Design:75]; [Bridge Design:75]ADVDate:4; >)
			vSortADVDate:=1
		Else 
			ORDER BY:C49([Bridge Design:75]; [Bridge Design:75]ADVDate:4; <)
			vSortADVDate:=2
		End if 
		
		vSortPROJIS:=0
		vSortContract:=0
		vSortCity:=0
		vSortItem8:=0
		vSortPrjType:=0
		//vSortADVDate:=0
		vSortDesigner:=0
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 