PushChange(1; Self:C308)

If ([Conslt Rating:63]NBISLetter:26=!00-00-00!)
	[Conslt Rating:63]AssignStatus:43:="Active"
	POPUPMENUC(->cboAssignmentStatus; ->cboAssignmentStatus; ->[Conslt Rating:63]AssignStatus:43)
End if 




