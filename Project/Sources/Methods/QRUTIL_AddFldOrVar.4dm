//%attributes = {"invisible":true}
//Method: QRUTIL_AddFldOrVar 
//Description
//  ` Add to the end of a quick report the passed pointer to a variable and set the header as the name of the variable or field
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/23/13, 20:19:04
	// ----------------------------------------------------
	//Created : 
	Mods_2013_01
End if 
//
C_LONGINT:C283($1; $2; $LastCol)
C_POINTER:C301($3)
C_TEXT:C284($title_txt; $Obj_txt; $format_txt)
C_LONGINT:C283($Hide_L; $repeat_L; $T_L; $F_L; $size_L)
$LastCol:=QR Count columns:C764($1)+1
QR INSERT COLUMN:C748($1; $LastCol; $3)
QR GET INFO COLUMN:C766($1; $LastCol; $title_txt; $Obj_txt; $Hide_L; $size_L; $repeat_L; $format_txt)
RESOLVE POINTER:C394($3; $title_txt; $T_L; $F_L)

If ($F_L>0)
	$title_txt:=Field name:C257($T_L; $F_L)
End if 

QR SET INFO COLUMN:C765($1; $LastCol; $title_txt; $Obj_txt; $Hide_L; $size_L; $repeat_L; $format_txt)

//End QR_AddVariable