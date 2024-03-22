//SC for ZZ4 (Last Record) on layout [Cond Units];"Cond Units In".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//last
COND_UNIT_AFTER
//C_LONGINT($Choice_L;$Row_L)
//$Row_L:=Records in selection([Cond Units])
//If (Read only state([Cond Units]))
//GOTO SELECTED RECORD([Cond Units];$Row_L)

//Else 
//COND_UNIT_AFTER 
//GOTO SELECTED RECORD([Cond Units];$Row_L)
//  //vbinspectionLocked:=Not(ut_LoadRecordNoWait (->[Cond Units]))
//End if 
//FM_CondUnitsIn (On Load)
