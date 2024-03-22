If (False:C215)
	//Object Method: NBISLetter 
	// Modified by: costasmanousakis-(Designer)-(9/19/2007 09:21:29)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/1/2007 09:57:43)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/23/10 16:08:08)
	Mods_2010_09
	//  `use the CRTG_RecentAction_OM method
End if 

CRTG_RecentAction_OM(Self:C308)
If ([Conslt Rating:63]NBISLetter:26>!00-00-00!)
	[Conslt Rating:63]AssignStatus:43:="Completed"
	[Conslt Rating:63]PriorityColorFlag:3:="Green"
	PushChange(1; ->[Conslt Rating:63]PriorityColorFlag:3)
Else 
	
End if 
GOTO OBJECT:C206([Conslt Rating:63]RecentAction:71)
//POST KEY(Tab Key )
PushChange(1; ->[Conslt Rating:63]AssignStatus:43)
POPUPMENUC(->cboAssignmentStatus; ->cboAssignmentStatus; ->[Conslt Rating:63]AssignStatus:43)