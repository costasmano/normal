//%attributes = {"invisible":true}
//Mods_2004_CM01
//
//Modified ut_returnTimeStampFromDate to accept second 
//parameter as a time.
//added method ut_ReturnTimeFromTimeStamp
//added method ControlClientProcess
//added method BMSExternal_Transfer
//modified form [ServerProcesses]Input to add the ControlDelay_l field.
//modified method ut_SetNextRunTimeStamp to keep include the time in the 
//  `LastTimeRun time stamp and keep the time to run from the NextRunTime 
//  `time stamp.
//modified ControlServerProcesses to look for processname = "Server@"
//modified bDuplicate method in {Bridge]Inspections to initialize some 
//  `of the [Inspections] fields.
//modified Print_XXX routines for printing inspections to print form 
//  `"SI & A (Insp)".