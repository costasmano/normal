//%attributes = {"invisible":true}
//Method: ut_NewTextToArray
//Description
// Convert a Text to an array
// Parameters
// $1 : $text
// $2 : $Array_ptr
// $3 : $Delimiter (default ",")
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 10/30/12, 12:28:43
	//----------------------------------------------------
	Mods_2012_10  //r003 ` 
	//Modified by: Charles Miller (10/30/12 12:28:44)
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 12:23:09)
	Mods_2012_12
	//  `Use $Offset_L:=$MaxOffset_L+1 and $Offset_L>$MaxOffset_L  to account for cases when the delimited parts are single characters
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 18:46:17)
	Mods_2022_09_bug
	//  `fixed bug in converting last element to a number
End if 
C_TEXT:C284($1; $Text_txt; $Delim_txt)
C_POINTER:C301($2; $array_ptr)
$Text_txt:=$1
$array_ptr:=$2
C_BOOLEAN:C305($IsNumberArray_B)
$IsNumberArray_B:=(Type:C295($array_ptr->)=16)
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$Delim_txt:=$3
Else 
	$Delim_txt:=","
End if 
C_LONGINT:C283($DelimPos_L; $StartPart_L; $Offset_L; $MaxOffset_L)
$MaxOffset_L:=Length:C16($Text_txt)
$Offset_L:=1

Repeat 
	$StartPart_L:=Position:C15($Delim_txt; $Text_txt; $Offset_L)
	If ($StartPart_L>0)
		If ($IsNumberArray_B)
			APPEND TO ARRAY:C911($array_ptr->; Num:C11(Substring:C12($Text_txt; $Offset_L; $StartPart_L-$Offset_L)))
		Else 
			APPEND TO ARRAY:C911($array_ptr->; Substring:C12($Text_txt; $Offset_L; $StartPart_L-$Offset_L))
		End if 
		$Offset_L:=$StartPart_L+Length:C16($Delim_txt)
	Else 
		If ($IsNumberArray_B)
			APPEND TO ARRAY:C911($array_ptr->; Num:C11(Substring:C12($Text_txt; $Offset_L)))
		Else 
			APPEND TO ARRAY:C911($array_ptr->; Substring:C12($Text_txt; $Offset_L))
		End if 
		//$Offset_L:=$MaxOffset_L
		$Offset_L:=$MaxOffset_L+1
	End if 
	//Until ($Offset_L>=$MaxOffset_L)
Until ($Offset_L>$MaxOffset_L)

//End ut_NewTextToArray