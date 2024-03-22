//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/09/07, 09:29:07
	// ----------------------------------------------------
	// Method: INSP_SetInspRtgVars
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
vItem58_R:=G_FormatItmRtg([Inspections:27]Item58_r:210)
vItem59_R:=G_FormatItmRtg([Inspections:27]Item59_r:211)
vItem60_R:=G_FormatItmRtg([Inspections:27]Item60_r:212)
vItem62_R:=G_FormatItmRtg([Inspections:27]Item62_r:213)
If ([Inspections:27]Insp Type:6="FCR")
	OBJECT SET VISIBLE:C603(*; "@InspRtg62"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "@InspRtg62"; True:C214)
End if 