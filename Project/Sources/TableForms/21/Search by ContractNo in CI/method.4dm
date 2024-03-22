If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/05, 15:52:29
	// ----------------------------------------------------
	// Method: Form Method: Search by ContractNo in CI
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM09
	
End if 
If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
	C_TEXT:C284(vsAssignNo)  // Command Replaced was o_C_STRING length was 2
	C_BOOLEAN:C305(vAddTo)
	vContractNo:=""
	vsAssignNo:=""
	vAddTo:=False:C215
	CBAddTo:=0
End if 