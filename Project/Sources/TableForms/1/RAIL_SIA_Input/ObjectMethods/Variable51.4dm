//Script for CheckBox Item 106
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Clicked:K2:4)
	Case of 
		: (CBItem106=1)
			[Bridge MHD NBIS:1]Item106:84:=0
			PushChange(1; ->[Bridge MHD NBIS:1]Item106:84)
	End case 
End if 