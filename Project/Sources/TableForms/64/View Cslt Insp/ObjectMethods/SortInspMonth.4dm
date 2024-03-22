If (False:C215)
	//Object Method: [Cons Inspection].View Cslt Insp.SortInspMonth 
	// Modified by: Costas Manousakis-(Designer)-(7/6/12 16:42:55)
	Mods_2012_07
	//  `When sorting by insp month include the bdept and bin in the sort.
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((vSortInspMonth=0) | (vSortInspMonth=2))
			ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspMonth:34; >; [Bridge MHD NBIS:1]BDEPT:1; >; [Cons Inspection:64]BIN:1; >)
			vSortInspMonth:=1
		Else 
			ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspMonth:34; <; [Bridge MHD NBIS:1]BDEPT:1; <; [Cons Inspection:64]BIN:1; <)
			vSortInspMonth:=2
		End if 
		
		vSortContract:=0
		vSortDistrict:=0
		vSortCity:=0
		vSortItem8:=0
		vSortInspType:=0
		// vSortInspMonth:=0
		vSortNTP:=0
		vSortInspReceived:=0
		vSortAssign:=0
		vSortConsultant:=0
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 