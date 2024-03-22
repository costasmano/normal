//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/14/06, 19:50:15
	// ----------------------------------------------------
	// Method: INV_SetHelpMsg_Insp
	// Description
	// set the help messages in the insp input form
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
End if 
C_TEXT:C284(vGEN_FirstRec_txt; vGEN_Close_txt; vGEN_DeleteRec_txt; vGEN_AddSubRec_txt)
vGEN_FirstRec_txt:="Inventory Photo Insp"
vGEN_Close_txt:="this Inventory Photo Insp"
vGEN_DeleteRec_txt:="this Inventory Photo Insp"
vGEN_AddSubRec_txt:="a new Photo"