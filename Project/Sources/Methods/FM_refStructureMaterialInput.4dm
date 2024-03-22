//%attributes = {"invisible":true}



// ----------------------------------------------------
// User name (OS): Bridge Section
// Date and time: 04/07/15, 16:33:27
// ----------------------------------------------------
// Method: FM_refStructureMaterialInput
// Description
// 
//
// Parameters
// ----------------------------------------------------

//------------------------------------------


If (False:C215)
	
End if 
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		START TRANSACTION:C239
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)  //current table
		If (Is new record:C668([LSS_refStructureMaterial:170]))
			C_LONGINT:C283($ID_L)
			
			Inc_Sequence("LSS_Structure"; ->$ID_L)
			[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1:=String:C10($ID_L; <>KeyMask_s)
			OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bDelete"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
	: (Form event code:C388=On Validate:K2:3) | ($FormEvent_L=On Validate:K2:3)
		
End case 
//End FM_refStructureMaterialInput

