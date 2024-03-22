Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283(SortInspInit)  //Command Replaced was o_C_INTEGER
		SortInspInit:=2
		SET CURSOR:C469(4)
		If ((Self:C308->=0) | (Self:C308->=1))
			Self:C308->:=1
		End if 
		C_BOOLEAN:C305($vbShift)
		$vbShift:=Shift down:C543
		MULTILEVEL(->[Inspection Type:31]Description:2; Self:C308; $vbShift)
		MULTILEVEL(->[Inspections:27]InitialInsp:9; ->SortInspInit; True:C214)
		SET CURSOR:C469(0)
		SortTmLdr:=0  //this is not part of the multilevel sort yet.
		REDRAW WINDOW:C456
		vbSortedHeader:=True:C214
		
	: ((Form event code:C388=On Header:K2:17) & Not:C34(vbSortedHeader))
		Case of 
			: (SortInspType=1)
				ORDER BY:C49([Inspections:27]; [Inspection Type:31]Description:2; >; [Inspections:27]InitialInsp:9; <)
			: (SortInspType=2)
				ORDER BY:C49([Inspections:27]; [Inspection Type:31]Description:2; <; [Inspections:27]InitialInsp:9; <)
		End case 
		REDRAW WINDOW:C456
		
End case 