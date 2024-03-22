//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/08/15, 17:33:49
//----------------------------------------------------
//Method: FM_refInspectionTypeInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/8/15 17:33:53)
	
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
		If (Is new record:C668([LSS_refInspectionType:167]))
			OBJECT SET ENTERABLE:C238(*; "LSS_InspectionTypeId_s"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "LSS_InspectionTypeId_s"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_InspectionTypeId_s"; <>Color_editable)
			OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bDelete"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENTERABLE:C238(*; "LSS_InspectionTypeId_s"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "LSS_InspectionTypeId_s"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_InspectionTypeId_s"; <>Color_Not_Editable)
		End if 
	: (Form event code:C388=On Validate:K2:3) | ($FormEvent_L=On Validate:K2:3)
		
End case 


//End FM_refInspectionTypeInput

