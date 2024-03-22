//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/30/07, 22:38:38
	// ----------------------------------------------------
	// Method: ut_setEnterable
	// Description
	// 
	// 
	// Parameters
	// $1 : $ObjectNam_txt
	// $2 : $Enterable_b
	// ----------------------------------------------------
	Mods_2007_CM08
End if 
C_TEXT:C284($1; $ObjectNam_txt)
C_BOOLEAN:C305($2; $Enterable_b)
$ObjectNam_txt:=$1
$Enterable_b:=$2
OBJECT SET ENTERABLE:C238(*; $ObjectNam_txt; $Enterable_b)
If ($Enterable_b)
	OBJECT SET RGB COLORS:C628(*; $ObjectNam_txt; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; $ObjectNam_txt; <>Color_Editable)
Else 
	OBJECT SET RGB COLORS:C628(*; $ObjectNam_txt; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; $ObjectNam_txt; <>Color_Not_editable)
End if 

