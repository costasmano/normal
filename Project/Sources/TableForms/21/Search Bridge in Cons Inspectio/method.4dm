If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/05, 15:50:26
	// ----------------------------------------------------
	// Method: Form Method: Search Bridge in Cons Inspectio
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM09
End if 
//LO Procedure [Dialogs];"Search Bridge in Cons Inspection"

If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(vBIN)  // Command Replaced was o_C_STRING length was 3
	C_TEXT:C284(vBDEPT)  // Command Replaced was o_C_STRING length was 6
	C_BOOLEAN:C305(vAddTo)
	vBIN:=""
	vBDEPT:=""
	vAddTo:=False:C215
	CBAddTo:=0
End if 