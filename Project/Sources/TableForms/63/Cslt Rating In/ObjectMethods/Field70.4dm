If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/19/2007 09:21:29)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/1/2007 09:57:43)
	Mods_2007_CM12_5301
End if 

PushChange(1; Self:C308)
[Conslt Rating:63]AssignStatus:43:="Completed"
PushChange(1; ->[Conslt Rating:63]AssignStatus:43)
POPUPMENUC(->cboAssignmentStatus; ->cboAssignmentStatus; ->[Conslt Rating:63]AssignStatus:43)
[Conslt Rating:63]PriorityColorFlag:3:="Green"
PushChange(1; ->[Conslt Rating:63]PriorityColorFlag:3)