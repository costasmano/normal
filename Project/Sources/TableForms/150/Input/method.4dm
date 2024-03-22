
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/07/13, 16:02:59
//----------------------------------------------------
//Method: Form Method: [ScourCriticalInfo]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (2/7/13 16:03:00)
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
	If (Read only state:C362([ScourCriticalInfo:150]))
		OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
		OBJECT SET VISIBLE:C603(bValidate; False:C215)
		
		
	Else 
		C_BOOLEAN:C305($Enterable_b)
		$Enterable_b:=False:C215
		If ([ScourCriticalInfo:150]MonitoringNeeded_b:5)
			$Enterable_b:=True:C214
		End if 
		OBJECT SET ENTERABLE:C238([ScourCriticalInfo:150]VisualMonitoring_b:6; $Enterable_b)
		OBJECT SET ENTERABLE:C238([ScourCriticalInfo:150]InstrumentMonitoring_b:7; $Enterable_b)
		OBJECT SET ENTERABLE:C238([ScourCriticalInfo:150]InstrMonitoringInstalled_b:8; $Enterable_b)
		
		OBJECT SET VISIBLE:C603(bValidate; True:C214)
		
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)
		If (Is new record:C668([ScourCriticalInfo:150]))
			[ScourCriticalInfo:150]BIN:1:=[Bridge MHD NBIS:1]BIN:3
		End if 
	End if 
End if 
//End Form Method: [ScourCriticalInfo]Input

