//%attributes = {"invisible":true}
//G_ReplyBtnCfg 
//Configure reply buttons on inspection input forms.
//Called from onLoad event of Form methods
//ALERT("Checking reply")
If (Not:C34(vbInspectionLocked))
	If (Length:C16([Inspections:27]InspRevCmts:170)>0)
		OBJECT SET ENABLED:C1123(*; "DE ReplyDBIE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(*; "DE ReplyDBIE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End if 
	If (Length:C16([Inspections:27]InspApprCmts:169)>0)
		OBJECT SET ENABLED:C1123(*; "DE Reply Area@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(*; "DE Reply Area@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End if 
End if 
If ((vApproveLvl=2) & ([Inspections:27]InspApproved:167=BMS Rejected) & Not:C34([Inspections:27]InspComplete:168))
	OBJECT SET ENABLED:C1123(*; "DE Reply Area@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET TITLE:C194(*; "DE Reply Area@"; "Add Comments")
End if 
If ((vApproveLvl=1) & ([Inspections:27]InspReviewed:12=BMS Rejected) & Not:C34([Inspections:27]InspComplete:168))
	OBJECT SET ENABLED:C1123(*; "DE ReplyDBIE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET TITLE:C194(*; "DE ReplyDBIE@"; "Add Comments")
End if 