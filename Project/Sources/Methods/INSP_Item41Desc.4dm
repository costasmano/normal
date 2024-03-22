//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/23/07, 10:23:05
	// ----------------------------------------------------
	// Method: INSP_Item41Desc
	// Description
	// Set and size Item 41 description on Inspection print forms
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/30/07 11:46:57)
	Mods_2007_CM_5401
End if 
C_TEXT:C284(vItem41)  // Command Replaced was o_C_STRING length was 32

vItem41:=Uppercase:C13([Inspections:27]Item 41:77+":"+Get_Description(-><>aPosting; -><>aPostCode; ->[Inspections:27]Item 41:77))
If (Position:C15(" "; vItem41)>0)
	vItem41:=Substring:C12(vItem41; 1; Position:C15(" "; vItem41))
	vItem41:=Strip(vItem41)
End if 
G_FitPrintObject(->vItem41; 11; 8; 6)