If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/09/09, 13:51:23
	// ----------------------------------------------------
	// Method: Form Method: Input
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Type:C295(ptr_Changes)#Array 2D:K8:24)
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
		End if 
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		C_BOOLEAN:C305(ElementCatNewRec_b)
		ElementCatNewRec_b:=Is new record:C668([Element Cat:32])
		If ([Element Cat:32]Code:1="")
			OBJECT SET ENTERABLE:C238(*; "Field@"; False:C215)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If ([Element Cat:32]Code:1="")
			ALERT:C41("Cannot have blank Code field")
			REJECT:C38
		Else 
			If (ElementCatNewRec_b)
				LogNewRecord(->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; 0; "")
			End if 
			FlushGrpChgs(1; ->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; 0)
		End if 
		
End case 