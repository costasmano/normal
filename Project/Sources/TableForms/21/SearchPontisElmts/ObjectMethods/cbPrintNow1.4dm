If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Clicked:K2:4)
	Case of 
		: (cbPrintNow=0)
			vPrintNow:=False:C215
		: (cbPrintNow=1)
			vPrintNow:=True:C214
	End case 
End if 