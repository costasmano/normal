//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/15/09, 13:33:23
	// ----------------------------------------------------
	// Method: SCPOA_FldMonPgmChecks
	// Description
	//  `Manage the chekboxes in the Flood Monitoring program
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(5/19/11 16:51:13)
	Mods_2011_05
	//New POA  ver
	// Modified by: Costas Manousakis-(Designer)-(1/13/15 16:13:01)
	Mods_2015_01
	//  `need to run  SCPOA_MonitorChecks  after changing SCPOA_OtherMonitDev_L this links also to section 6b as needed
End if 
C_LONGINT:C283($check_L)
$check_L:=SCPOA_OtherMonitVis_L+SCPOA_OtherMonitinstr_L+SCPOA_DischOvr_L+SCPOA_Stage_L+SCPOA_ElevMeas_L+SCPOA_DOTSitRept_L
$check_L:=$check_L+SCPOA_FldForecast_L+SCPOA_FldWarnSys_L+SCPOA_NotifPublic_L+SCPOA_NotifFixMonitor_L+SCPOA_NotifPublic_L
If ($check_L>0)
	SCPOA_OtherMonitDev_L:=1
Else 
	SCPOA_OtherMonitDev_L:=0
End if 
SCPOA_MonitorChecks