//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/07, 15:37:10
	// ----------------------------------------------------
	// Method: INSP_GetStrTypeBtn
	// Description
	// Update Inspection with struct/deck code from SIA
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
//variables in here have already been defined in the form method
If ([Inspections:27]Item 43:140#[Bridge MHD NBIS:1]Item43:75)
	[Inspections:27]Item 43:140:=[Bridge MHD NBIS:1]Item43:75
	PushChange(1; ->[Inspections:27]Item 43:140)
	INSP_Item43Desc
End if 
If ([Inspections:27]Item 107:141#[Bridge MHD NBIS:1]Item107:79)
	[Inspections:27]Item 107:141:=[Bridge MHD NBIS:1]Item107:79
	PushChange(1; ->[Inspections:27]Item 107:141)
	INSP_Item107Desc
End if 