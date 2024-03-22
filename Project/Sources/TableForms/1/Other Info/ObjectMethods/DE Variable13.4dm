If (False:C215)
	//Script: bInspCheck
	//Created By:Albert Leung
	//Date:  6/16/97
	
	//Purpose: Toggle The Bridge Inspection Validation field
End if 

[Bridge MHD NBIS:1]BrgInspEngVal:14:=Not:C34([Bridge MHD NBIS:1]BrgInspEngVal:14)
PushChange(1; ->[Bridge MHD NBIS:1]BrgInspEngVal:14)