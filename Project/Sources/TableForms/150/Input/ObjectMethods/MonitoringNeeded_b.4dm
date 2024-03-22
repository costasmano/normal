
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/12/13, 16:01:23
//----------------------------------------------------
//Method: Object Method: [ScourCriticalInfo].Input.MonitoringNeeded_b
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (2/12/13 16:01:24)
	
End if 
C_BOOLEAN:C305($Enterable_b)
$Enterable_b:=False:C215
If ([ScourCriticalInfo:150]MonitoringNeeded_b:5)
	$Enterable_b:=True:C214
End if 
If (Not:C34($Enterable_b))
	[ScourCriticalInfo:150]VisualMonitoring_b:6:=$Enterable_b
	[ScourCriticalInfo:150]InstrumentMonitoring_b:7:=$Enterable_b
	[ScourCriticalInfo:150]InstrMonitoringInstalled_b:8:=$Enterable_b
End if 
OBJECT SET ENTERABLE:C238([ScourCriticalInfo:150]VisualMonitoring_b:6; $Enterable_b)
OBJECT SET ENTERABLE:C238([ScourCriticalInfo:150]InstrumentMonitoring_b:7; $Enterable_b)
OBJECT SET ENTERABLE:C238([ScourCriticalInfo:150]InstrMonitoringInstalled_b:8; $Enterable_b)

//End Object Method: [ScourCriticalInfo].Input.MonitoringNeeded_b

