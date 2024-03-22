If (False:C215)
	
	Mods_2005_CM06
	Mods_2005_CM12
End if 

PushChange(1; Self:C308)
[Inspections:27]Item 90:142:=Self:C308->
[Inspections:27]Insp Date:78:=Self:C308->
[BMS Inspections:44]Insp Date:4:=Self:C308->
SAVE RECORD:C53([BMS Inspections:44])
[Combined Inspections:90]InspDate:4:=Self:C308->
SAVE RECORD:C53([Combined Inspections:90])
PushChange(1; ->[Inspections:27]Item 90:142)
PushChange(1; ->[Inspections:27]Insp Date:78)
PushChange(3; ->[BMS Inspections:44]Insp Date:4)
PushChange(4; ->[Combined Inspections:90]InspDate:4)
G_Insp_ApplyRev1_Inp