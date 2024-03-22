If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; Self:C308)
	If ([Bridge MHD NBIS:1]Item92CA:167=False:C215)
		If ([Bridge MHD NBIS:1]Item92CB:168>0)
			[Bridge MHD NBIS:1]Item92CB:168:=0
			PushChange(1; ->[Bridge MHD NBIS:1]Item92CB:168)
			CalcItem91
			PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
		End if 
	End if 
End if 