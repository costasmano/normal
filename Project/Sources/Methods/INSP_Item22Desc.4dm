//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/23/07, 10:29:05
	// ----------------------------------------------------
	// Method: INSP_Item22Desc
	// Description
	// Set and size Item 22 description on Inspection print forms
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/30/07 11:49:21)
	Mods_2007_CM_5401
End if 

C_TEXT:C284(vItem22)  // Command Replaced was o_C_STRING length was 27

vItem22:=sFriendlyName(Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Inspections:27]Item22:197))
G_FitPrintObject(->vItem22; 9; 6; 0)