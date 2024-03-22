
//  Object Method for LastServerProcessRunDate_d
//----------------------------------------------------
// User name (OS): cjmiller
// Date and time: 09/16/03, 15:48:27
// ----------------------------------------------------
// Description
// This method will reformat time stamp into a date for entry
//
// Parameters
//$1 TEXT (OR STRING) TIME STAMP PASSED IN
//$0 returned date
// ----------------------------------------------------
If (False:C215)
	Mods_2004_CJM02
	Mods_2005_CM05
	
End if 

If (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Losing Focus:K2:8)
	
	[ServerProcesses:87]LastRunTimeStamp_s:3:=ut_ReturnTimeStampFromDate(LastServerProcessRunDate_d; LastServerProcessRunDate_t)
	
End if 

//  End Object Method for LastServerProcessRunDate_d