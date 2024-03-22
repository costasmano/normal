//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2004_CJM02
// User name (OS): cjmiller
// Date and time: 03/12/04, 09:50:18
// ----------------------------------------------------
// Description
// This method will outline changes made per Costas by me
//
// Parameters
// None
// ----------------------------------------------------
//Modify to try and make speed improvements on client startup
//Startup `modiified to collect more time information
//INIT_FIELDS_DES `modified by removing list to array sections
//Init_Fields_DES1 `new method
//  `Changed selection to array so they are on one line as oppossed to multiple
//  `lines


//Create new table and process to handle server processes
//ServerProcesses table
//ProcessName_s (41)
//NextProcessRun_s (13)
//LastRunTimeStamp_s (12)
//NextRunTimeStamp_s (12)
//ProcessRunning_b (booolean)
//ControlProcessDelay_l (long)

//Changed methods
//On server startup


//new method
//ControlServerProcesses 
//ut_ReturnDateFromTimeStamp 
//ut_ReturnTimeStampFromDate 
//ut_ReturnDateFromTimeStamp 
//TestHourly 
//testWeekly 
//testDaily 
//TestMonthly 
//testYearly 
//Changed methods


//on server startup

//New forms
//[ServerProcesses];"Input"
//[ServerProcesses];"Output"

//To implement this code, you need to do the following to things

//1. Add line of code 
//ut_SetNextRunTimeStamp (Current method name)
//as the last line in a method to be added to be run on thhe server
//2. Create a record with a Process Name equal to the method name.
//The next time you start the server, the new system will be in place and any 
//records found in the ServerProcesses table will attempt to start a new process
//using that name
