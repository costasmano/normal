//SC for ZZ2 (Previous Record) on layout [Cond Units];"Cond Units In".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//previous
COND_UNIT_AFTER
//C_LONGINT($Choice_L;$Row_L)
//$Row_L:=Selected record number([Cond Units])
//If (Read only state([Cond Units]))
//GOTO SELECTED RECORD([Cond Units];$Row_L-1)

//Else 
//COND_UNIT_AFTER 
//GOTO SELECTED RECORD([Cond Units];$Row_L-1)
//  //vbinspectionLocked:=not(ut_LoadRecordNoWait (->[Cond Units]))


//End if 
//FM_CondUnitsIn (On Load)
