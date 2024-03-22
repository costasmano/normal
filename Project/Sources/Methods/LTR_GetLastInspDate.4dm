//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/23/07, 15:37:20
	// ----------------------------------------------------
	// Method: LTR_GetLastInspDate
	// Description
	// Get the last insp date to be used in letters
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_DATE:C307(vLTR_LastInspDate_d)
READ ONLY:C145([Inspections:27])
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"DV@")
ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
FIRST RECORD:C50([Inspections:27])
vLTR_LastInspDate_d:=[Inspections:27]Insp Date:78
UNLOAD RECORD:C212([Inspections:27])
READ WRITE:C146([Inspections:27])