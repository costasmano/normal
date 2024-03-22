//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 07/12/16, 12:46:21
//----------------------------------------------------
//Method: clone_ReturnUUIDPrimaryKey
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_06  // 
	//Modified by: Chuck Miller (7/12/16 12:46:23)
	compiler_clone
End if 
C_LONGINT:C283($0; $1; $TableNumber_L)
$TableNumber_L:=$1
$Primary_key_field_id_L:=-9
C_TEXT:C284($ConstraintID_txt)

C_LONGINT:C283($Primary_key_field_id_L)
Begin SQL
	
	SELECT CONSTRAINT_ID
	FROM _USER_CONSTRAINTS
	WHERE TABLE_ID = :$TableNumber_L AND CONSTRAINT_TYPE = 'P'
	INTO :$ConstraintID_txt;
	
	SELECT COLUMN_ID
	FROM _USER_CONS_COLUMNS
	WHERE CONSTRAINT_ID = :$ConstraintID_txt
	INTO :$Primary_key_field_id_L;
End SQL

$0:=$Primary_key_field_id_L
//End clone_ReturnUUIDPrimaryKey

