//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/07/07, 20:28:18
	// ----------------------------------------------------
	// Method: INSP_SetUI_Rev4
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_DATE:C307(<>InspFormRevDate_4)

OBJECT SET VISIBLE:C603(*; "@_Rev4"; ([Inspections:27]Insp Date:78><>InspFormRevDate_4))
If (([Inspections:27]Insp Type:6="FCR") & ([Inspections:27]Insp Date:78><>InspFormRevDate_4))
	OBJECT SET VISIBLE:C603(*; "@62_Rev4"; False:C215)
End if 