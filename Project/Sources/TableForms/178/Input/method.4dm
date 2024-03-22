If (False:C215)
	//Form Method: [PON_ELEM_DEFS];"Input" 
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/29/16, 17:20:46
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(1/29/16 17:20:57)
	Mods_2016_01_bug
	//  ` changed style  of everything to Label12 made notes to grow vertically and fields below it to move vertically
	// Modified by: Costas Manousakis-(Designer)-(2022-09-28 16:16:06)
	Mods_2022_09
	//  `for a new record make elem_key enterable - changed Elem_key to not transparent (cannot set that by code yet)
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
	: ($FormEvent_L=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (Is new record:C668(Current form table:C627->))
			//for new record allow entry to the Key field
			[PON_ELEM_DEFS:178]ELEM_CREATEDATETIME:15:=ISODateTime(Current date:C33; Current time:C178)
			OBJECT SET RGB COLORS:C628(*; "ELEM_KEY"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); "white")
			OBJECT SET ENTERABLE:C238([PON_ELEM_DEFS:178]ELEM_KEY:1; True:C214)
			OBJECT SET MINIMUM VALUE:C1242([PON_ELEM_DEFS:178]ELEM_KEY:1; 1)  // make sure a value is entered here.
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		
End case 
//End Form Method: [PON_ELEM_DEFS]Input