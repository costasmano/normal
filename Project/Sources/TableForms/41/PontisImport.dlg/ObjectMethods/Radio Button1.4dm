// ----------------------------------------------------
// Object Method: PM_Run_l
// User name (OS): charlesmiller
// Date and time: 05/22/09, 14:13:13
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r002  `05/22/09, 14:13:15 `Add code and tables to retrieve pontis simulation data
End if 
PM_ImportDate_ad:=0
If (PM_Run_l=1)
	OBJECT SET VISIBLE:C603(*; "RerunSelect@"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "RerunSelect@"; True:C214)
End if 
//End Object Method: PM_Run_l