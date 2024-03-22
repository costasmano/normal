//%attributes = {"invisible":true}
//Method: Pers_GetNames
//Description
//Return the names in a string from a list of Personnel IDs in an array
//Method InitPers must have been executed before- arrays aPeople_ID and aPeople are needed
// Parameters
// $0 : $Names_txt
// $1 : $array_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/15/16, 16:29:40
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_TEXT:C284(Pers_GetNames; $0)
	C_POINTER:C301(Pers_GetNames; $1)
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($Names_txt; $s)
$Names_txt:=""
C_POINTER:C301($1)
C_LONGINT:C283($loop_L; $k; $n)

For ($loop_L; 1; Size of array:C274($1->))
	$k:=Find in array:C230(aPeople_ID; $1->{$loop_L})
	
	If ($k>0)
		$s:=aPeople{$k}
		$n:=Position:C15(" "; $s)
		$s:=Delete string:C232($s; 2; $n-2)
		$s:=Insert string:C231($s; "."; 2)
	Else 
		$s:="Invalid ID "+String:C10($1->{$loop_L})
	End if 
	
	If ($Names_txt="")
		$Names_txt:=$s
	Else 
		$Names_txt:=$Names_txt+", "+$s
	End if 
End for 

$0:=$Names_txt
//End Pers_GetNames