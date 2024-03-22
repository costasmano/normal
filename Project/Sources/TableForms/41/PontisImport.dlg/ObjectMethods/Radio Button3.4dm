// ----------------------------------------------------
// Object Method: PM_DeleteRun_l
// User name (OS): charlesmiller
// Date and time: 05/22/09, 14:18:58
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r002  `05/22/09, 14:19:00 `Add code and tables to retrieve pontis simulation data
End if 
PM_ImportDate_ad:=0
If (PM_DeleteRun_l=1)
	OBJECT SET VISIBLE:C603(*; "RerunSelect@"; True:C214)
	If (Size of array:C274(PM_ImportDate_ad)=0)
		ALL RECORDS:C47([Pontis_Metrics:41])
		DISTINCT VALUES:C339([Pontis_Metrics:41]PM_ImportDate_d:4; PM_ImportDate_ad)
		INSERT IN ARRAY:C227(PM_ImportDate_ad; 0; 1)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "RerunSelect@"; False:C215)
End if 
//End Object Method: PM_ReRun_l