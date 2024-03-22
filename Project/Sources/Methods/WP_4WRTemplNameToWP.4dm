//%attributes = {"invisible":true}
// Method: WP_4WRTemplNameToWP
// Description
// Convert a 4D Write template name to a Write Pro name
// Parameters
// $0 : $WPName_txt
// $1 : $WRName_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/22/21, 16:23:01
	// ----------------------------------------------------
	// First Release
	Mods_2021_WP
	
	C_TEXT:C284(WP_4WRTemplNameToWP; $0; $1)
End if 

C_TEXT:C284($0; $1; $sTemplateName)

$sTemplateName:=$1

Case of 
	: ($sTemplateName="WRTemp@")
		$sTemplateName:="WP"+Substring:C12($sTemplateName; 3)
	: ($sTemplateName="WRT")
		$sTemplateName:="WRP"+Substring:C12($sTemplateName; 4)
End case 

$0:=$sTemplateName