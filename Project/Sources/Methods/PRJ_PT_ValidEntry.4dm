//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/12/07, 01:01:35
	// ----------------------------------------------------
	// Method: PRJ_PT_ValidEntry
	// Description
	// Check if the current info in the timeSheet Dlog is valid
	// 
	// Parameters
	// $0 : $ValidEntry_b
	// ----------------------------------------------------
	Mods_TimeTracking
	// Modified by: costasmanousakis-(Designer)-(3/1/09 20:55:09)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 
C_BOOLEAN:C305($0; $ValidEntry_b)
$ValidEntry_b:=False:C215
C_TEXT:C284(PRJ_PT_ValidErrMsg_txt)
PRJ_PT_ValidErrMsg_txt:=""
Case of 
	: (PT_EmployeeID_I<=0)
		PRJ_PT_ValidErrMsg_txt:=("No Person has been selected!")
	: (PRJ_PT_Hours_r<=0)
		PRJ_PT_ValidErrMsg_txt:=("Zero or Negative hours have been entered")
	: (PT_ProjectID_L=0)
		PRJ_PT_ValidErrMsg_txt:=("No Projects or cost code selected")
	: (PRJ_PT_EWO_s="")
		PRJ_PT_ValidErrMsg_txt:=("EWO is blank!!!")
	: (PRJ_PT_WeekEnding_d=!00-00-00!)
		PRJ_PT_ValidErrMsg_txt:=("Week Ending has not been entered")
	: (PRJ_PT_Scope_s="")
		PRJ_PT_ValidErrMsg_txt:=("Must choose a Review Stage -Type, Sketch, Final, Constr")
	Else 
		$ValidEntry_b:=True:C214
End case 
$0:=$ValidEntry_b