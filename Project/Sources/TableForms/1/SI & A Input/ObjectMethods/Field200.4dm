//Method: [Bridge MHD NBIS].SI & A Input.Field200
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/18/18 14:59:31)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If ([Bridge MHD NBIS:1]Posting3Axle:10>0)
		If ([Bridge MHD NBIS:1]PostingSingle:231#0)
			[Bridge MHD NBIS:1]PostingSingle:231:=0
			PushChange(1; ->[Bridge MHD NBIS:1]PostingSingle:231)
		End if 
	End if 
End if 