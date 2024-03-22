//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_UnloadAllTables
// User name (OS): charlesmiller
// Date and time: 06/23/11, 14:13:57
// ----------------------------------------------------
// Description
// This method will fill array of pointers to tables and then it will unload all records
//It is meant to run at start up to fil arrays and upon close of input forms to make sure all records are unloaded
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  // CJ Miller`06/23/11, 14:13:59      `Add code to allow for auto unload of record for all tables
End if 
C_LONGINT:C283($loop_l)
Case of 
	: (Count parameters:C259=1)
		C_TEXT:C284($1)
		
		ARRAY POINTER:C280(<>Table_aPtrs; 0)
		//ARRAY POINTER(◊Table_aPtrs;Get last table number)
		
		For ($loop_l; 1; Get last table number:C254)
			If (Is table number valid:C999($loop_l))
				APPEND TO ARRAY:C911(<>Table_aPtrs; Table:C252($loop_l))
				//◊Table_aPtrs{$loop_l}:=Table($loop_l)
			End if 
		End for 
		
	Else 
		For ($loop_l; 1; Size of array:C274(<>Table_aPtrs))
			UNLOAD RECORD:C212(<>Table_aPtrs{$loop_l}->)
		End for 
		
End case 
//End ut_UnloadAllTables