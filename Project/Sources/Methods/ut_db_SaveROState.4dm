//%attributes = {"invisible":true}
//Method: ut_db_SaveROState
//Description
// Return the read only state of all tables. Can be used to re-set it if it has been modified
// Parameters
// $0: $ROStates_x : blob containing a boolean array with read only state of all tables
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/28/16, 13:47:18
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	C_BLOB:C604(ut_db_SaveROState; $0)
End if 
//
C_BLOB:C604($0)
C_LONGINT:C283($Tables_L; $i)
$Tables_L:=Get last table number:C254
ARRAY BOOLEAN:C223($Ro_State_ab; $Tables_L)

For ($i; 1; $Tables_L)
	If (Is table number valid:C999($i))
		$Ro_State_ab{$i}:=Read only state:C362(Table:C252($i)->)
	End if 
End for 
VARIABLE TO BLOB:C532($Ro_State_ab; $0)

//End ut_db_SaveRWState