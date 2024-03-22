//%attributes = {"invisible":true}
//Method: SVG_TranslatePath
//Description
// translate an svg path
// Parameters
// $1 : $pathtxt_ptr
// $2 : $transX_r
// $3 : $TransY_r
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/27/15, 11:56:12
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
	
	C_POINTER:C301(SVG_TranslatePath; $1)
	C_REAL:C285(SVG_TranslatePath; $2; $3)
End if 
//
C_POINTER:C301($1)
C_REAL:C285($2; $3)

C_TEXT:C284($Path_txt; $newPath_txt)
$Path_txt:=$1->
ARRAY TEXT:C222($Points_atxt; 0)

ut_TextToArray($Path_txt; ->$Points_atxt; " ")

C_LONGINT:C283($loop_L)
C_TEXT:C284($pointType_txt)
For ($loop_L; 1; Size of array:C274($Points_atxt))
	$pointType_txt:=Substring:C12($Points_atxt{$loop_L}; 1; 1)
	ARRAY TEXT:C222($xyvals_atxt; 0)
	If ($pointType_txt="M") | ($pointType_txt="L")
		ut_TextToArray(Substring:C12($Points_atxt{$loop_L}; 2); ->$xyvals_atxt; ",")
		$newPath_txt:=$newPath_txt+" "+$pointType_txt+String:C10(Num:C11($xyvals_atxt{1})+$2)+","+String:C10(Num:C11($xyvals_atxt{2})+$3)
	Else 
		$newPath_txt:=$newPath_txt+" "+$Points_atxt{$loop_L}
	End if 
	
End for 

$1->:=$newPath_txt

//End SVG_TranslatePath