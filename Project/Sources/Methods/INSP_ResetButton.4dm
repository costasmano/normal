//%attributes = {"invisible":true}
// ----------------------------------------------------
// INSP_ResetButton
// User name (OS): charlesmiller
// Date and time: 07/12/11, 12:45:59
// ----------------------------------------------------
// Description
// This method will set button on / off as well as set color to red / black depending on 
// whether the field/var pointed to by the 3rd parameter is blank or not (blank=red) 
// Parameters
// ----------------------------------------------------
//$1 boolean
//$2 object name
//$3 pointer to field for testing
If (False:C215)
	Mods_2011_06  // CJ Miller`07/12/11, 12:46:01      ` Type all local variables for v11
End if 
C_BOOLEAN:C305($1; $NoData_b)
$NoData_b:=$1
C_TEXT:C284($2; $3; $Objectname_txt)

$Objectname_txt:=$2+"@"
OBJECT SET RGB COLORS:C628(*; $Objectname_txt; Col_paletteToRGB(Abs:C99(-(Black:K11:16))%256); Col_paletteToRGB(Abs:C99(-(Black:K11:16))\256))  // **Replaced o OBJECT SET COLOR(*; $Objectname_txt; -(Black))
If (Count parameters:C259=3)
	If ($NoData_b)
		OBJECT SET ENABLED:C1123(*; $Objectname_txt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(*; $Objectname_txt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		If ($3="")
			//Alert user to enter text
			OBJECT SET RGB COLORS:C628(*; $Objectname_txt; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(*; $Objectname_txt; -(Red))
		End if 
	End if 
End if 

If (Count parameters:C259=4)
	C_TEXT:C284($4; $Value_txt)
	$Value_txt:=$4
	OBJECT SET RGB COLORS:C628(*; $Objectname_txt; Col_paletteToRGB(Abs:C99(-(Black:K11:16))%256); Col_paletteToRGB(Abs:C99(-(Black:K11:16))\256))  // **Replaced o OBJECT SET COLOR(*; $Objectname_txt; -(Black))
	If ($NoData_b)
		If ($3=$Value_txt)
			OBJECT SET ENABLED:C1123(*; $Objectname_txt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(*; $Objectname_txt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	Else 
		OBJECT SET ENABLED:C1123(*; $Objectname_txt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		If ($3="")
			OBJECT SET RGB COLORS:C628(*; $Objectname_txt; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(*; $Objectname_txt; -(Red))
		Else 
			OBJECT SET RGB COLORS:C628(*; $Objectname_txt; Col_paletteToRGB(Abs:C99(-(Black:K11:16))%256); Col_paletteToRGB(Abs:C99(-(Black:K11:16))\256))  // **Replaced o OBJECT SET COLOR(*; $Objectname_txt; -(Black))
		End if 
		
	End if 
	
End if 
//End INSP_ResetButton