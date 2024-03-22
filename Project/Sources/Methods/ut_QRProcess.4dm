//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/13/11, 10:51:40
//----------------------------------------------------
//Method: ut_QRProcess
//Description
//
// Parameters
// $1 : $Blob_blb
//  ` Contains the NameOfTheSet_txt to be used, the QueryOption_B; and the TableNumber_L
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //Fix quick report problem where changing to related many table will not print data from original one table
	//Modified by: Charles Miller (12/13/11 12:12:57)
End if 
C_BLOB:C604($1; $Blob_blb)
C_LONGINT:C283($TableNumber_l; $Offset_l)
$Blob_blb:=$1
C_TEXT:C284($Setname_txt)
C_BOOLEAN:C305($QueryOpt_b)

BLOB TO VARIABLE:C533($Blob_blb; $Setname_txt; $Offset_l)
BLOB TO VARIABLE:C533($Blob_blb; $QueryOpt_b; $Offset_l)
BLOB TO VARIABLE:C533($Blob_blb; $TableNumber_l; $Offset_l)

C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252($TableNumber_l)

USE SET:C118($Setname_txt)
CLEAR SET:C117($Setname_txt)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
QR REPORT:C197($Table_ptr->; Char:C90(1); True:C214; True:C214; $QueryOpt_b)

//End ut_QRProcess