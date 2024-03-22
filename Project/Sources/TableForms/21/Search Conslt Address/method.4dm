If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/05, 15:53:22
	// ----------------------------------------------------
	// Method: Form Method: Search Conslt Address
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM09
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 15:30:15)
	Mods_2019_03
	//  `added result text obj. ; made all objects except the search var not focusable
	//  `fixed reference to vConsltName
	//  `enabled BlankMenu to allow copy/paste
End if 
If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(vConsltName)  // Command Replaced was o_C_STRING length was 30
	C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
	C_BOOLEAN:C305(vAddTo)
	vConsltName:=" "
	HIGHLIGHT TEXT:C210(vConsltName; 1; 2)
	vLastName:=" "
	vAddTo:=False:C215
	CBAddTo:=0
	OBJECT SET TITLE:C194(*; "SearchResults"; "")
End if 