CONFIRM:C162("Delete this Work Estimate?")
If (OK=1)
	LogDeletion(->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; 0)
	DELETE RECORD:C58([Work_Estimate:103])
	CANCEL:C270
End if 