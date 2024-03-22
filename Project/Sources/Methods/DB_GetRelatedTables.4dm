//%attributes = {"invisible":true}
//Method: DB_GetRelatedTables
//Description
// ****  Not Completed yet ****
// get related table info. will return an object with arrays of table names, table numbers and table pointers
// Parameters
// $1 : $Param_o  : object containing array of pointers to tables to be used as parents under attribute "parents"
// "allTablenames"
// "allTablenumbers"  
// "allTablepointers"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-01-20T00:00:00, 14:34:40
	// ----------------------------------------------------
	//Created : 
	Mods_2022_01
End if 
//

ARRAY TEXT:C222($tablename; 0)
ARRAY TEXT:C222($tablerelated; 0)
ARRAY TEXT:C222($type; 0)
ARRAY LONGINT:C221($tableID; 0)
ARRAY LONGINT:C221($relatedID; 0)
ARRAY TEXT:C222($alltablename; 0)
ARRAY TEXT:C222($alltablerelated; 0)
ARRAY TEXT:C222($type; 0)
ARRAY LONGINT:C221($alltableID; 0)
ARRAY LONGINT:C221($allrelatedID; 0)

APPEND TO ARRAY:C911($alltablename; Table name:C256(->[Inspections:27]))
APPEND TO ARRAY:C911($alltableID; Table:C252(->[Inspections:27]))
APPEND TO ARRAY:C911($alltablename; Table name:C256(->[BMS Inspections:44]))
APPEND TO ARRAY:C911($alltableID; Table:C252(->[BMS Inspections:44]))
APPEND TO ARRAY:C911($alltablename; Table name:C256(->[TIN_Inspections:184]))
APPEND TO ARRAY:C911($alltableID; Table:C252(->[TIN_Inspections:184]))


C_LONGINT:C283($numchild_start; $numchild_end)
C_LONGINT:C283($loop_L)
C_TEXT:C284($tablename_t)
C_LONGINT:C283($chkloop_L)

Repeat 
	
	$numchild_start:=Size of array:C274($alltablename)
	
	For ($loop_L; 1; $numchild_start)
		$tablename_t:=$alltablename{$loop_L}
		Begin SQL
			select TABLE_NAME, RELATED_TABLE_NAME,CONSTRAINT_TYPE, TABLE_ID, RELATED_TABLE_ID
			from _USER_CONSTRAINTS
			where CONSTRAINT_TYPE='4DR'
			and RELATED_TABLE_NAME=:$tablename_t
			into :$tablename , :$tablerelated, :$type, :$tableID , :$relatedID ;
			
		End SQL
		
		For ($chkloop_L; 1; Size of array:C274($tablename))
			If (Find in array:C230($alltablename; $tablename{$chkloop_L})>0)
			Else 
				APPEND TO ARRAY:C911($alltablename; $tablename{$chkloop_L})
				APPEND TO ARRAY:C911($alltableID; $tableID{$chkloop_L})
			End if 
		End for 
		
	End for 
	$numchild_end:=Size of array:C274($alltablename)
	
Until ($numchild_start=$numchild_end)

//End DB_GetRelatedTables