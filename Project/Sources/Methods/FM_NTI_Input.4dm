//%attributes = {"invisible":true}
//Method: FM_NTI_Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/14/17, 16:57:16
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 

Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		
		LSS_SetPrevNextButtons(LBRow_L; Records in selection:C76([NTI_ELEM_DEFS:182]))
		C_LONGINT:C283($l; $t; $r; $b; $Width_L; $Height_L)
		FORM GET PROPERTIES:C674([NTI_ELEM_DEFS:182]; "Input"; $Width_L; $Height_L)
		GET WINDOW RECT:C443($l; $t; $r; $b)
		SET WINDOW RECT:C444($l; $t; $l+$Width_L+5; $t+$Height_L+20)
		
		START TRANSACTION:C239
		OBJECT SET ENTERABLE:C238(*; "CREATEUSER"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "CREATEDATETIME"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "MODDATETIME"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "MODUSER"; False:C215)
		
		OBJECT SET RGB COLORS:C628(*; "CREATEUSER"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; "CREATEUSER"; <>COLOR_NOT_EDITABLE)
		OBJECT SET RGB COLORS:C628(*; "CREATEDATETIME"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; "CREATEDATETIME"; <>COLOR_NOT_EDITABLE)
		OBJECT SET RGB COLORS:C628(*; "MODDATETIME"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; "MODDATETIME"; <>COLOR_NOT_EDITABLE)
		OBJECT SET RGB COLORS:C628(*; "MODUSER"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; "MODUSER"; <>COLOR_NOT_EDITABLE)
		
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)
		If (Is new record:C668([NTI_ELEM_DEFS:182]))
			[NTI_ELEM_DEFS:182]CREATEDATETIME:2:=ISODateTime(Current date:C33; Current time:C178)
			[NTI_ELEM_DEFS:182]CREATEUSER:3:=Current user:C182
			OBJECT SET ENTERABLE:C238(*; "ELEM_KEY"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "ELEM_KEY"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; "ELEM_KEY"; <>COLOR_NOT_EDITABLE)
			OBJECT SET RGB COLORS:C628(*; "ELEM_KEY"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; "ELEM_KEY"; <>COLOR_NOT_EDITABLE)
		Else 
			OBJECT SET RGB COLORS:C628(*; "ELEM_KEY"; Col_paletteToRGB(Abs:C99(<>COLOR_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; "ELEM_KEY"; <>COLOR_EDITABLE)
			OBJECT SET ENTERABLE:C238(*; "ELEM_KEY"; False:C215)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
		
End case 

//End FM_NTI_Input