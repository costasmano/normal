//SC for ZZ1 (First Record) on layout [Cond Units];"Cond Units In".
//Copyright © 1996, Thomas D. Nee, All Rights Reser
//first

COND_UNIT_AFTER
//If (Read only state([Cond Units]))
//GOTO SELECTED RECORD([Cond Units];1)

//Else 
//COND_UNIT_AFTER 
//GOTO SELECTED RECORD([Cond Units];1)
//  //vbinspectionLocked:=not(ut_LoadRecordNoWait (->[Cond Units]))

//End if 
//FM_CondUnitsIn (On Load)

