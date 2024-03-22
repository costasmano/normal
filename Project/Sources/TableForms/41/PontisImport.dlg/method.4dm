// ----------------------------------------------------
// Form Method: PontisImport.dlg
// User name (OS): charlesmiller
// Date and time: 05/22/09, 14:14:26
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r002  `05/22/09, 14:14:28 `Add code and tables to retrieve pontis simulation data
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		ALL RECORDS:C47([Pontis_Metrics:41])
		ARRAY DATE:C224(PM_ImportDate_ad; 0)
		PM_Run_l:=1
		PM_ReRun_l:=0
		
		OBJECT SET VISIBLE:C603(*; "RerunSelect@"; False:C215)
	: (Form event code:C388=On Unload:K2:2)
		
		
End case 
//End Form Method: PontisImport.dlg