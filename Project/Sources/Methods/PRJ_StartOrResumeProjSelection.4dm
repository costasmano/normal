//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_StartOrResumeProjSelection
// User name (OS): cjmiller
// Date and time: 01/19/06, 14:51:49
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2012_02  //r003 `Remove the parameter in new process as it is an interprocess variable anyway
	//Modified by: Charles Miller (2/14/12 16:21:19)
	Mods_2022_05  //Changed call to this as we are going to start a new process each time
	//Modified by: Chuck Miller (5/24/22 10:56:14)
	
End if 
If (Not:C34(<>fQuit))
	If (<>ProjectSelectionProcess_l=0)
		<>ProjectSelectionProcess_l:=New process:C317("PRJ_ControlSelect"; 0; "Project List Selection")  //;◊PRJ_SelectedData_txt)
	Else 
		C_LONGINT:C283($ProcessState_l; $ProcessTime_l; $UniqueProcessNumber_l; $ProcessOrigin_l)
		C_BOOLEAN:C305($ProcessVisible_b)
		C_TEXT:C284($ProcessName_txt)
		PROCESS PROPERTIES:C336(<>ProjectSelectionProcess_l; $ProcessName_txt; $ProcessState_l; $ProcessTime_l; $ProcessVisible_b; $UniqueProcessNumber_l; $ProcessOrigin_l)
		If ($ProcessState_l=Aborted:K13:1) | ($ProcessState_l=Does not exist:K13:3)
			<>ProjectSelectionProcess_l:=New process:C317("PRJ_ControlSelect"; 0; "Project List Selection")  //;◊PRJ_SelectedData_txt)
		Else 
			<>RESTART_B:=True:C214
			RESUME PROCESS:C320(<>ProjectSelectionProcess_l)
			POST OUTSIDE CALL:C329(<>ProjectSelectionProcess_l)
		End if 
	End if 
End if 
//End PRJ_StartOrResumeProjSelection