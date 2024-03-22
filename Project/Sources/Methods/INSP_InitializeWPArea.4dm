//%attributes = {"invisible":true}
//Method: INSP_InitializeWPArea
//Description
// Return a new wRtie Pro area for current inspection
// Parameters
// $0 : $WPArea object
// $1 : $Parameters obj
//  //  $param.templateType (text "normal" | "Culvert")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 21:14:34
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(INSP_InitializeWPArea; $0)
	C_OBJECT:C1216(INSP_InitializeWPArea; $1)
	
End if 
//

C_OBJECT:C1216($0; $WPArea_; $Range)
C_TEXT:C284($platform; $Template; $TemplateType)
$TemplateType:=""
If (Count parameters:C259>0)
	C_OBJECT:C1216($1)
	$TemplateType:=$1.templateType
End if 
// set up WP doc according to inspection type and platform

$platform:=Choose:C955(Is macOS:C1572; "MAC"; "WIN")
Case of 
	: ($TemplateType="Normal")
		$Template:="NormalPageSetup-"
		
	: ($TemplateType="Culvert")
		$Template:="CulvertPageSetup-"
		
	: ([Inspections:27]Insp Type:6="CUL") | ([Inspections:27]Insp Type:6="RRC")
		$Template:="CulvertPageSetup-"
		
	Else 
		$Template:="NormalPageSetup-"
		
End case 

$Template:=$Template+$platform+".4wp"
C_BLOB:C604($TemplateBlob_x)
DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"WPTemplates"+Folder separator:K24:12+$Template; $TemplateBlob_x)

$WPArea_:=WP New:C1317($TemplateBlob_x)
//clear out any text in the template
$Range:=WP Text range:C1341($WPArea_; wk start text:K81:165; wk end text:K81:164)
WP SET TEXT:C1574($Range; ""; wk replace:K81:177; wk include in range:K81:180)

$0:=$WPArea_

//End INSP_InitializeWPArea