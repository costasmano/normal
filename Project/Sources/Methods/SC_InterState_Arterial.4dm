//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:57:14
	// ----------------------------------------------------
	// Method: SC_InterState_Arterial
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_BOOLEAN:C305($0; $Inter_Arter_b)
$0:=(Position:C15([Bridge MHD NBIS:1]Item26:120; ".01.02.11.12.14.")>0)