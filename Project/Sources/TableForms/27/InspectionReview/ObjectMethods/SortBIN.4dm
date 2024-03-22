Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((Self:C308->=0) | (Self:C308->=1))
			Self:C308->:=1
		End if 
		C_BOOLEAN:C305($vbShift)
		$vbShift:=Shift down:C543
		MULTILEVEL(->[Inspections:27]BIN:1; Self:C308; $vbShift)
		SET CURSOR:C469(0)
		SortTmLdr:=0  //this is not part of the multilevel sort yet.
		REDRAW WINDOW:C456
		vbSortedHeader:=True:C214
		
	: ((Form event code:C388=On Header:K2:17) & Not:C34(vbSortedHeader))
		Case of 
			: (SortBIN=1)
				ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1)
			: (SortBIN=2)
				ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; <)
		End case 
		REDRAW WINDOW:C456
End case 