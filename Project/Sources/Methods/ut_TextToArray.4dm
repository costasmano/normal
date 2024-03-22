//%attributes = {"invisible":true}
// Method: ut_TextToArray
// Description
// Translate a text variable delimited by a character to an array.
// 
// Parameters
// $1 : Text_txt
// $2 ; $array_ptr
// $3 : $Delim_txt (Optional - default = ",")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/08, 10:27:31
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
	// Modified by: Costas Manousakis-(Designer)-(9/8/14 10:04:25)
	Mods_2014_09
	//  `account for blank in $3
End if 
C_TEXT:C284($1; $Text_txt; $Delim_txt)
C_POINTER:C301($2; $array_ptr)
$Text_txt:=$1
$array_ptr:=$2

$Delim_txt:=","
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	If ($3#"")
		$Delim_txt:=$3
	End if 
End if 

C_LONGINT:C283($DelimPos_L; $StartPart_L)
C_TEXT:C284($Work_txt)
$Work_txt:=$Text_txt
While ($Work_txt#"")
	$DelimPos_L:=Position:C15($Delim_txt; $Work_txt)
	Case of 
		: ($DelimPos_L=1)
			$Work_txt:=Substring:C12($Work_txt; (1+Length:C16($Delim_txt)))
		: ($DelimPos_L>1)
			INSERT IN ARRAY:C227($array_ptr->; (Size of array:C274($array_ptr->)+1))
			$array_ptr->{Size of array:C274($array_ptr->)}:=Substring:C12($Work_txt; 1; ($DelimPos_L-1))
			$Work_txt:=Substring:C12($Work_txt; ($DelimPos_L+Length:C16($Delim_txt)))
		Else 
			INSERT IN ARRAY:C227($array_ptr->; (Size of array:C274($array_ptr->)+1))
			$array_ptr->{Size of array:C274($array_ptr->)}:=Substring:C12($Work_txt; 1)
			$Work_txt:=""
	End case 
	
End while 