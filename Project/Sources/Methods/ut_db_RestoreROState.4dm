//%attributes = {"invisible":true}
//Method: ut_db_RestoreROState
//Description
//Restore the RO state of all tables from a blob containing an array of booleans
// Parameters
// $1 : $BlobWithArray
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/28/16, 13:56:42
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	C_BLOB:C604(ut_db_RestoreROState; $1)
End if 
//
C_BLOB:C604($1)
C_LONGINT:C283($Tables_L; $i; $offset)
ARRAY BOOLEAN:C223($Ro_State_ab; 0)
$offset:=0
BLOB TO VARIABLE:C533($1; $Ro_State_ab; $offset)
$Tables_L:=Get last table number:C254
If (Size of array:C274($Ro_State_ab)>0)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Ro_State_ab))
		If (Is table number valid:C999($loop_L))
			If ($Ro_State_ab{$loop_L})
				READ ONLY:C145(Table:C252($loop_L)->)
			Else 
				READ WRITE:C146(Table:C252($loop_L)->)
			End if 
		End if 
		
	End for 
	
End if 

//End ut_db_RestoreROState