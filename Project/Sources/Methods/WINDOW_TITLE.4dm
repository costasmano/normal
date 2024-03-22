//%attributes = {"invisible":true}
//GP WINDOW_TITLE($ptr_file)
//© October 1995, Thomas D. Nee, All Rights Reserved.
//$1: $ptr_file: Pointer to file.

C_POINTER:C301($ptr_file)
C_TEXT:C284($text)
$ptr_file:=$1
$text:=Table name:C256($ptr_file)+":  "+String:C10(Records in selection:C76($ptr_file->))
$text:=$text+" of "+String:C10(Records in table:C83($ptr_file->))
SET WINDOW TITLE:C213($text)