//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/23/07, 10:23:05
	// ----------------------------------------------------
	// Method: INSP_Item21Desc
	// Description
	// Set and size Item 21 description on Inspection print forms
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/30/07 11:48:28)
	Mods_2007_CM_5401
End if 

C_TEXT:C284(vItem21)  // Command Replaced was o_C_STRING length was 27

If (Form event code:C388=On Printing Detail:K2:18)
	vItem21:=sFriendlyName(Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Inspections:27]Item21:166))
	G_FitPrintObject(->vItem21; 9; 6; 0)
End if 