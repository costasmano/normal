//%attributes = {"invisible":true}
//Method: ut_ParseVersionString
//Description
//  ` Parse a text sring containing a version into a text array passed as a pointer
// Parameters
// $1 ; $String_txt
// $2 : $PartsArray_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/25/14, 17:00:27
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($String_txt)
C_POINTER:C301($PartsArray_ptr)
$String_txt:=$1
$PartsArray_ptr:=$2

C_TEXT:C284($pat_txt)
$pat_txt:="(([a-zA-Z0-9]*)[\\. -]+)"
C_BOOLEAN:C305($Vfound_b)
ARRAY LONGINT:C221($pos_; 0)
ARRAY LONGINT:C221($len_; 0)

$Vfound_b:=Match regex:C1019($pat_txt; $String_txt; 1; $pos_; $len_)
While ($Vfound_b)
	APPEND TO ARRAY:C911($PartsArray_ptr->; Substring:C12($String_txt; $pos_{2}; $len_{2}))
	$String_txt:=Substring:C12($String_txt; $len_{1}+1)
	$Vfound_b:=Match regex:C1019($pat_txt; $String_txt; 1; $pos_; $len_)
End while 

If ($String_txt#"")
	APPEND TO ARRAY:C911($PartsArray_ptr->; $String_txt)
End if 

//End ut_ParseVersionString