//%attributes = {"invisible":true}
//GP: Blank out string
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//Modified Apr-2002 : Make sure table fields are blanked to their defined length

C_POINTER:C301($1; $s)
C_LONGINT:C283($vlen; $tablenum; $fieldnum; $fieldtype)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($varName)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($fieldindex)

$s:=$1
RESOLVE POINTER:C394($s; $varName; $tablenum; $fieldnum)
If ($fieldnum>0)
	//for fields get the field length  
	GET FIELD PROPERTIES:C258($s; $fieldtype; $vlen; $fieldindex)
Else 
	//String var  
	$vlen:=Length:C16($s->)
End if 
$s->:=" "*$vlen