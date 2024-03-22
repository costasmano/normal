//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/19/07, 08:58:25
	// ----------------------------------------------------
	// Method: INSP_SpcFreqColorSet
	// Description
	// set the color of a variable
	// 
	// Parameters
	// $1: $varPointer
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
C_POINTER:C301($1; $varPointer)
$varPointer:=$1
Case of 
	: (Position:C15($varPointer->; ";0;1;2;3;4;5;6;7;8;9;")>10)
	: (Position:C15($varPointer->; ";0;1;2;3;4;5;6;7;8;9;")>8)
		OBJECT SET RGB COLORS:C628($varPointer->; Col_paletteToRGB(Abs:C99(-(Orange:K11:3+(256*White:K11:1)))%256); Col_paletteToRGB(Abs:C99(-(Orange:K11:3+(256*White:K11:1)))\256))  // **Replaced o OBJECT SET COLOR($varPointer->; -(Orange+(256*White)))
		OBJECT SET FONT STYLE:C166($varPointer->; (Bold:K14:2))
	: (Position:C15($varPointer->; ";0;1;2;3;4;5;6;7;8;9;")>1)
		OBJECT SET RGB COLORS:C628($varPointer->; Col_paletteToRGB(Abs:C99(-(Red:K11:4+(256*White:K11:1)))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4+(256*White:K11:1)))\256))  // **Replaced o OBJECT SET COLOR($varPointer->; -(Red+(256*White)))
		OBJECT SET FONT STYLE:C166($varPointer->; (Bold:K14:2))
End case 