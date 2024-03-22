//%attributes = {"invisible":true}
//  `testHourly
//  ` User name (OS): cjmiller
//  ` Date and time: 
//  ` ----------------------------------------------------
//  ` Description
//  `This method will test Hourly use methods
//
//If (False)
//Mods_2004_CJM02 
//End if 
//ALERT("We have started "+Current method name+" process")
//
//READ ONLY([ServerProcesses])
//QUERY([ServerProcesses];[ServerProcesses]ProcessName_s=Current method name)
//$Msg:="ProcessRunSchedule_s -> "+[ServerProcesses]ProcessRunSchedule_s+Char(13)
//$Msg:=$Msg+"LastRunTimeStamp_s -> "+[ServerProcesses]LastRunTimeStamp_s+Char(13)
//
//$Msg:=$Msg+"NextRunTimeStamp_s -> "+[ServerProcesses]NextRunTimeStamp_s+Char(13)
//
//ALERT($Msg)
//
//ut_SetNextRunTimeStamp (Current method name)
//READ ONLY([ServerProcesses])
//QUERY([ServerProcesses];[ServerProcesses]ProcessName_s=Current method name)
//$Msg:="ProcessRunSchedule_s -> "+[ServerProcesses]ProcessRunSchedule_s+Char(13)
//$Msg:=$Msg+"LastRunTimeStamp_s -> "+[ServerProcesses]LastRunTimeStamp_s+Char(13)
//
//$Msg:=$Msg+"NextRunTimeStamp_s -> "+[ServerProcesses]NextRunTimeStamp_s+Char(13)
//ALERT($Msg)
//ALERT("We have finished "+Current method name+" process")
