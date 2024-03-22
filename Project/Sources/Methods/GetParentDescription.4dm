//%attributes = {"invisible":true}
//Created by Albert Leung
//Created 9/19/2002
//Purpose: Get the description of the parent element
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/22/2007 11:38:19)
	Mods_2007_CM12_5302
End if 

C_TEXT:C284($vsDescr)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($ElmNo_i; $ElmParNo_i; $k)  //Command Replaced was o_C_INTEGER
If (Count parameters:C259=1)
	C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER
	$ElmNo_i:=$1
Else 
	$ElmNo_i:=[ElementsSafety:29]ElementNo:1
End if 
$K:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElmNo_i)
$ElmParNo_i:=<>ELMTDICT_Parent_ai{$k}

//Does this element have a parent?
$vsDescr:=""
If ($ElmParNo_i#0)
	$K:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElmParNo_i)
	$vsDescr:=<>ELMTDICT_Txt_as{$K}
End if 
$0:=$vsDescr