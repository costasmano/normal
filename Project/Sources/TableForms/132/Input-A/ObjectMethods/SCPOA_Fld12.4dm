If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/09 09:10:46)
	Mods_2009_12
	//Changes/Additions for new version of POA
	// Modified by: costasmanousakis-(Designer)-(10/13/10 10:25:22)
	Mods_2010_10
	//  `Use method SCPOA_CompleteAction
End if 
If (Form event code:C388=On Clicked:K2:4)
	
	PushChange(1; Self:C308)
	If (Self:C308->=True:C214)
	Else 
		[ScourPOA:132]DateCompleted:8:=!00-00-00!
		PushChange(1; ->[ScourPOA:132]DateCompleted:8)
	End if 
	SCPOA_CompleteAction
End if 