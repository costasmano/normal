//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/23/11, 11:03:00
//----------------------------------------------------
//Method: ut_SQL_CreateShema
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Mods_2011_11 `
	//Modified by: Charles Miller (11/23/11 11:03:01)
	
End if 

C_LONGINT:C283($TableLoop_l)

C_TEXT:C284($TableName_txt; $Alter_txt)
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)

For ($TableLoop_l; 1; Get last table number:C254)
	If (Is table number valid:C999($TableLoop_l))
		$TableName_txt:="["+Table name:C256($TableLoop_l)+"]"
		$Alter_txt:="ALTER TABLE "+$TableName_txt+" SET SCHEMA user_accessible_tables;"+Char:C90(Carriage return:K15:38)
		
		TEXT TO BLOB:C554($Alter_txt; $Blob_blb; UTF8 text without length:K22:17; *)
	End if 
End for 

C_TIME:C306($DOC_TM)
$DOC_TM:=Create document:C266("")

CLOSE DOCUMENT:C267($DOC_TM)

BLOB TO DOCUMENT:C526(DOCUMENT; $Blob_blb)

//End ut_SQL_CreateShema

