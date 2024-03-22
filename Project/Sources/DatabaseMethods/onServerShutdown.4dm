If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/6/2007 08:45:43)
	Mods_2007_CM07
	Mods_2017_01  //Add code to enable saving of [Preferences] record for server
	//Modified by: administrator (1/5/17 15:16:48)
	Mods_2017_01  //Add code to enable saving of [ServerProcesses] record for server - 1st stop process "Control Server Process"
	//Modified by: administrator (1/13/17 15:16:48)
End if 
StopControlSrvProcess
UG_SaveUsersAndGroups
ut_savePrefRecord

ut_SaveServerProcessRecords