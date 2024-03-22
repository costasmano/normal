//%attributes = {"invisible":true}
//Method: CurrentFormName
//Description
// return the name of the current form - executed within the context of a form method or a form object - relies on 
// Current method path
// Parameters
// $0: $formName_txt
// $1 : $methodpath_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-22 14:20:52
	// ----------------------------------------------------
	//Created : 
	
	Mods_2021_10_bug
	
	C_TEXT:C284(CurrentFormName; $0)
	C_TEXT:C284(CurrentFormName; $1)
	
End if 
//

C_TEXT:C284($0; $formName_txt)
C_TEXT:C284($1; $methodpath_txt)
$methodpath_txt:=$1
$formName_txt:=""

ARRAY TEXT:C222($methodparts_atxt; 0)

Case of 
	: ($methodpath_txt="[tableForm]@")
		$methodpath_txt:=Replace string:C233($methodpath_txt; "[tableForm]/"; "")
		ut_TextToArray($methodpath_txt; ->$methodparts_atxt; "/")
		$formName_txt:=$methodparts_atxt{2}
		
	: ($methodpath_txt="[projectForm]@")
		$methodpath_txt:=Replace string:C233($methodpath_txt; "[projectForm]/"; "")
		ut_TextToArray($methodpath_txt; ->$methodparts_atxt; "/")
		$formName_txt:=$methodparts_atxt{1}
		
End case 

$0:=$formName_txt
//End CurrentFormName