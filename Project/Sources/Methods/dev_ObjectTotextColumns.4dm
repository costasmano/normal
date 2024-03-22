//%attributes = {"invisible":true}
//Method: dev_ObjectTotextColumns
//Description
// Convert an object that contains arrays into a text arranged by
// columns with property name as the header in a tab delimited format. text can be used to be pasted into excel,
// or saved to file.
// Parameters
// $0 : $data_txt : converted object
// $1 : $myObject_o
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/04/19, 16:27:42
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01
	
	C_TEXT:C284(dev_ObjectTotextColumns; $0)
	C_OBJECT:C1216(dev_ObjectTotextColumns; $1)
	
End if 
//

C_TEXT:C284($0; $data_txt)
C_OBJECT:C1216($1; $combination_o)

$combination_o:=$1
$data_txt:=""

ARRAY TEXT:C222($props_atxt; 0)
ARRAY TEXT:C222($propValues_atxt; 0)
ARRAY TEXT:C222($Lines_atxt; 0)
OB GET PROPERTY NAMES:C1232($combination_o; $props_atxt)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($props_atxt))
	OB GET ARRAY:C1229($combination_o; $props_atxt{$loop_L}; $propValues_atxt)
	
	If ($loop_L=1)
		ARRAY TEXT:C222($Lines_atxt; Size of array:C274($propValues_atxt)+1)
		
	Else 
		
	End if 
	$Lines_atxt{1}:=$Lines_atxt{1}+$props_atxt{$loop_L}+"\t"
	C_LONGINT:C283($valuesloop_L)
	For ($valuesloop_L; 1; Size of array:C274($propValues_atxt))
		$Lines_atxt{$valuesloop_L+1}:=$Lines_atxt{$valuesloop_L+1}+$propValues_atxt{$valuesloop_L}+"\t"
	End for 
	
End for 
C_TEXT:C284($data_txt)
For ($loop_L; 1; Size of array:C274($Lines_atxt))
	$data_txt:=$data_txt+$Lines_atxt{$loop_L}+"\n"
End for 

$0:=$data_txt
//End dev_ObjectTotextColumns