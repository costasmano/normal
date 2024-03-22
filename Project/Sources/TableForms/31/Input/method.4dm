If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/29/05, 08:56:26
	// ----------------------------------------------------
	// Method: Form Method: Input
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM08
	// Modified by: CJMILLER)-(12/26/12 14:32:43)
	Mods_2012_12
	//  `Added ElementNumbers_txt field, button and code to validate the element numbers
	//Change from FlushChanges to FlushGRPChanges
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(vInspectionTypeNew_b)
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		vInspectionTypeNew_b:=Is new record:C668([Inspection Type:31])
		OBJECT SET ENABLED:C1123(bzOK; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET VISIBLE:C603(*; "ValidateElemNum"; False:C215)
		If (Not:C34(insp_ValidateElementNumbers))
			OBJECT SET VISIBLE:C603(*; "ValidateElemNum"; True:C214)
			
			OBJECT SET ENABLED:C1123(bzOK; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (vInspectionTypeNew_b)
			LogNewRecord(->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; 0; "")
		End if 
		FlushGrpChgs(1; ->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; 0)
		
End case 
