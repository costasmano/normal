//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 03/11/10, 12:34:22
// ----------------------------------------------------
// Method: SQL_utReturnStrings
// Description
// 
//
// Parameters
// ----------------------------------------------------
//$1 table number
//$2 field number
//$3 pointer to field descriptor
//$4 pointer to table descriptor
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:41:50)
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 16:59:39)
End if 

C_LONGINT:C283($1; $2; $TableNumber_l; $FieldNumber_l)
$TableNumber_l:=$1
$FieldNumber_l:=$2
C_POINTER:C301($3; $FieldDescriptor_ptr)
$FieldDescriptor_ptr:=$3
C_TEXT:C284($FieldorTableName_txt)

$FieldorTableName_txt:="["+Field name:C257($TableNumber_l; $FieldNumber_l)+"]"

$FieldDescriptor_ptr->:=$FieldorTableName_txt

If (Count parameters:C259=4)
	C_POINTER:C301($4; $TableDescriptor_ptr)
	$TableDescriptor_ptr:=$4
	$FieldorTableName_txt:="["+Table name:C256($TableNumber_l)+"]"
	$TableDescriptor_ptr->:=$FieldorTableName_txt
End if 