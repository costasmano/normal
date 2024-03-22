If (False:C215)
	//[Bridge MHD NBIS];"Bridge Input".bSIA
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Bring up the SI & A input form
	
	// Modified by: costasmanousakis-(Designer)-(11/19/05 16:40:39)
	Mods_2005_CM19
	DIALOG:C40([Bridge MHD NBIS:1]; "SI & A Input")
	// Modified by: Costas Manousakis-(Designer)-(5/1/13 12:48:41)
	Mods_2013_05
	//  `Added READ WRITE([Bridge MHD NBIS])  and ut_Read_Write_Tables (READ / WRITE) for the chield tables
End if 
READ WRITE:C146([Bridge MHD NBIS:1])
ut_Read_Write_Tables("READ"; ->[Inspections:27]; ->[BMS Inspections:44]; ->[Combined Inspections:90]; ->[NBIS Secondary:3]; ->[Conslt Rating:63]; ->[Cons Inspection:64]; ->[Bridge Design:75]; ->[InventoryPhotoInsp:112])

SIA_MountModule("SI & A Input")

ut_Read_Write_Tables("WRITE"; ->[Inspections:27]; ->[BMS Inspections:44]; ->[Combined Inspections:90]; ->[NBIS Secondary:3]; ->[Conslt Rating:63]; ->[Cons Inspection:64]; ->[Bridge Design:75]; ->[InventoryPhotoInsp:112])
