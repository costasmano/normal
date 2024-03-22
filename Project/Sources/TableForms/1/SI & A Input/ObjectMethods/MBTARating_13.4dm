If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Data Change:K2:15)
	
	PushChange(2; Self:C308)
	C_DATE:C307($LastDate_d)
	$LastDate_d:=[Bridge MHD NBIS:1]DateModified:194
	[Bridge MHD NBIS:1]DateModified:194:=!00-00-00!
	[Bridge MHD NBIS:1]DateModified:194:=$LastDate_d
End if 