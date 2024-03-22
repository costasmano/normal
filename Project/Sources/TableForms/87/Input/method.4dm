//  Form method input for [ServerProcesses];"Input"
//----------------------------------------------------
// User name (OS): cjmiller
// Date and time: 09/16/03, 15:48:27
// ----------------------------------------------------
// Description
// 
//
// Parameters
//none
// ----------------------------------------------------
If (False:C215)
	Mods_2004_CJM02
	Mods_2005_CM05
	// Modified by: Costas Manousakis-(Designer)-(8/11/20 18:07:26)
	Mods_2020_08_bug
	//  `changed entry filter on dates to allow 4 digit year - fixed tab order to go to the time after the date entry
End if 

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		ARRAY TEXT:C222(ProcessRunSchedule_atxt; 6)
		ProcessRunSchedule_atxt{1}:="Daily"
		ProcessRunSchedule_atxt{2}:="Weekly"
		ProcessRunSchedule_atxt{3}:="Monthly"
		ProcessRunSchedule_atxt{4}:="Yearly"
		ProcessRunSchedule_atxt{5}:="Hourly"
		ProcessRunSchedule_atxt{6}:="One Time"
		
		If (Record number:C243([ServerProcesses:87])=New record:K29:1)
			LastServerProcessRunDate_d:=!00-00-00!
			NextServerProcessRunDate_d:=!00-00-00!
			LastServerProcessRunDate_t:=?00:00:00?
			NextServerProcessRunDate_t:=?00:00:00?
		Else 
			LastServerProcessRunDate_d:=ut_ReturnDateFromTimeStamp([ServerProcesses:87]LastRunTimeStamp_s:3)
			NextServerProcessRunDate_d:=ut_ReturnDateFromTimeStamp([ServerProcesses:87]NextRunTimeStamp_s:4)
			LastServerProcessRunDate_t:=ut_ReturnTimeFromTimeStamp([ServerProcesses:87]LastRunTimeStamp_s:3)
			NextServerProcessRunDate_t:=ut_ReturnTimeFromTimeStamp([ServerProcesses:87]NextRunTimeStamp_s:4)
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		ARRAY TEXT:C222(ProcessRunSchedule_atxt; 0)
		
End case 