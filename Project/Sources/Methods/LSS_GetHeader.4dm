//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/02/14, 17:16:42
//----------------------------------------------------
//Method: LSS_GetHeader
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 17:16:45)
	
End if 
C_TEXT:C284($1; $LabelCode)
$LabelCode:=$1
C_TEXT:C284($0)

$0:=""

Case of 
	: ($LabelCode="1")
		$0:="1.0 Foundation"
	: ($LabelCode="10")
		$0:="2.0 Structure"
	: ($LabelCode="28")
		$0:="3.0 Sign Panels & Illumination"
	: ($LabelCode="44")
		$0:="3.0 Structure Attachments"
	: ($LabelCode="38")
		$0:="4.0 Traffic Safety Features"
	: ($LabelCode="49")
		$0:="3.0 Luminaire"
		
End case 


//End LSS_GetHeader

