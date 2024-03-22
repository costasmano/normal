If (False:C215)
	//Script: bAreaCheck
	//Created By:Albert Leung
	//Date:  6/12/97
	
	//Purpose: Toggle Area Engineer Validation Field
End if 

[Bridge MHD NBIS:1]AreaEngVal:13:=Not:C34([Bridge MHD NBIS:1]AreaEngVal:13)
PushChange(1; ->[Bridge MHD NBIS:1]AreaEngVal:13)