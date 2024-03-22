//%attributes = {"invisible":true}
If (False:C215)
	//G_SetThermometer
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
End if 

C_POINTER:C301($1; $pThermometer)
C_TEXT:C284($2; $vsValue)  // Command Replaced was o_C_STRING length was 2

$pThermometer:=$1
$vsValue:=$2
If ($vsValue#"N")
	$pThermometer->:=Num:C11($vsValue)
Else 
	$pThermometer->:=0
End if 
If ($pThermometer-><5)
	OBJECT SET RGB COLORS:C628($pThermometer->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR($pThermometer->; INSP_ThermoRed_L)
Else 
	OBJECT SET RGB COLORS:C628($pThermometer->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR($pThermometer->; INSP_ThermoBlack_L)
End if 