If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/02/06, 11:40:02
	// ----------------------------------------------------
	// Method: Object Method: ReAssignButton
	// Description
	// button to retrieve all inspection for the district
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM06
End if 
If (Current user:C182="Designer")
	ALERT:C41("Setting Aprrove level to 1 - DBIE approval!")
	vApproveLvl:=1
End if 
