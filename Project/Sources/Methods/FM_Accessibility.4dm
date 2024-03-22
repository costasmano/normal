//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 11/18/14, 16:50:20
// ----------------------------------------------------
// Method: FM_Accessibility
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)  //[LSS_AccessibilityElement]
		
		If (Is new record:C668([LSS_AccessibilityElement:160]))
			C_LONGINT:C283($Key_L)
			
			Begin SQL
				select max([LSS_AccessibilityElement].[LSS_AccessibilityElementId_L])
				from [LSS_AccessibilityElement]
				into :$Key_L
			End SQL
			
			[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1:=$Key_L+1
			
		End if 
		
	: (Form event code:C388=On Validate:K2:3) | ($FormEvent_L=On Validate:K2:3)
		C_TEXT:C284($ErrorMethodCalled_txt)
		$ErrorMethodCalled_txt:=Method called on error:C704
		ON ERR CALL:C155("LSS_ErrorMethod")
		If (Modified record:C314([LSS_AccessibilityElement:160]))
			If (Is new record:C668([LSS_AccessibilityElement:160]))
				LogNewRecord(->[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1; ->[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1; ->[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1; 0; "LSS_AccessibilityElement")
			End if 
			PushChange(1; ->[LSS_AccessibilityElement:160]LSS_Description_txt:2)
			FlushGrpChgs(1; ->[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1; ->[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1; ->[LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1; 0)
			SAVE RECORD:C53([LSS_AccessibilityElement:160])
		End if 
		UNLOAD RECORD:C212([LSS_AccessibilityElement:160])
		
		ON ERR CALL:C155($ErrorMethodCalled_txt)
End case 
