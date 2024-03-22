If (False:C215)
	Mods_2005_CM06
	
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	[Inspections:27]Insp Date:78:=[Inspections:27]Item 93b:67
	PushChange(1; Self:C308)
	PushChange(1; ->[Inspections:27]Insp Date:78)
	[Combined Inspections:90]InspDate:4:=Self:C308->
	SAVE RECORD:C53([Combined Inspections:90])
	PushChange(4; ->[Combined Inspections:90]InspDate:4)
End if 