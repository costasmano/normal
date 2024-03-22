//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/16, 15:26:34
//----------------------------------------------------
//Method: ut_LaunchCNVStop
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (5/26/16 15:26:41)
	
End if 

If (<>CNV_StopProcessID_L=0)
	<>CNV_StopProcessID_L:=New process:C317("ut_CNVDisplayRunningProcesses"; 0; "Control Stop process")
Else 
	C_TEXT:C284($Name_txt)
	C_LONGINT:C283($State_L; $Time_L)
	
	PROCESS PROPERTIES:C336(<>CNV_StopProcessID_L; $Name_txt; $State_L; $Time_L)
	If ($State_L<0) | ($Name_txt#"Control Stop process")
		<>CNV_StopProcessID_L:=New process:C317("ut_CNVDisplayRunningProcesses"; 0; "Control Stop process")
	Else 
		BRING TO FRONT:C326(<>CNV_StopProcessID_L)
	End if 
End if 

//End ut_LaunchCNVStop

