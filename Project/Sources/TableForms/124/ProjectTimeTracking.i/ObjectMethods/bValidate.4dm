// ----------------------------------------------------
// Object Method: bValidate
// User name (OS): cjmiller
// Date and time: 01/27/06, 13:00:00
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_TimeTracking
	// Modified by: costasmanousakis-(Designer)-(3/1/09 23:26:51)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 
Case of 
	: ([PRJ_ProjectTimeTracking:124]Person ID:3=0)
		ALERT:C41("You must select a person before you can save the record!")
	: ([PRJ_ProjectTimeTracking:124]PT_Hours_r:6<=0)
		ALERT:C41("No Hours entered !")
	: ([PRJ_ProjectTimeTracking:124]PT_WeekEnding_d:4=!00-00-00!)
		ALERT:C41("No Week Ending Date entered !")
	: ([PRJ_ProjectTimeTracking:124]PT_Scope_s:11="")
		ALERT:C41("No Review Stage entered !")
	Else 
		ACCEPT:C269
End case 
//End Object Method: bValidate