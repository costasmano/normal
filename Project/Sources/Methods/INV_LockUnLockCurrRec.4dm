//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 08:49:41
	// ----------------------------------------------------
	// Method: INV_LockUnLockCurrRec
	// Description
	// Lock or unlock the current form record
	// 
	// Parameters
	// $1 : LonckOnorOff : boolean
	// $2 : Table : pointer
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: costasmanousakis-(Designer)-(4/8/09 09:09:21)
	Mods_2009_04
	//Added a cancel transaction when Locked
End if 
C_BOOLEAN:C305($1)
C_POINTER:C301($2)
If ($1)
	READ ONLY:C145($2->)
	UNLOAD RECORD:C212($2->)
	LOAD RECORD:C52($2->)
	READ WRITE:C146($2->)
	OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@"; <>Color_Not_Editable)
	OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	
	
Else 
	OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
	OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@"; <>Color_Editable)
	OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	
End if 
