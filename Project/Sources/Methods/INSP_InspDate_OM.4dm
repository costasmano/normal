//%attributes = {"invisible":true}
// Method: INSP_InspDate_OM
// Description
// Object method for the Insp date field in inspection forms
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/09/07, 08:55:23
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 10:55:35)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(3/24/15 17:29:46)
	Mods_2015_03
	//  `Added call to PON_NBE_INIT to adjust display of Pontis/NBE objects as needed - adjusted logic to catch special members BMS inspections
	//  `exclude Rail, tunnel and Pedestrian inspections
End if 

PushChange(1; ->[Inspections:27]Insp Date:78)
If (INSP_IsInspRoutine_b)
	[Inspections:27]Item 90:142:=[Inspections:27]Insp Date:78
	PushChange(1; ->[Inspections:27]Item 90:142)
End if 
If ([Combined Inspections:90]BMSInspID:3>0)
	If ([BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
		[BMS Inspections:44]Insp Date:4:=[Inspections:27]Insp Date:78
		SAVE RECORD:C53([BMS Inspections:44])
		PushChange(3; ->[BMS Inspections:44]Insp Date:4)
	End if 
End if 
[Combined Inspections:90]InspDate:4:=[Inspections:27]Insp Date:78
SAVE RECORD:C53([Combined Inspections:90])
PushChange(4; ->[Combined Inspections:90]InspDate:4)
G_Insp_ApplyRev1_Inp
INSP_SetUI_Rev4
PON_NBE_INIT
