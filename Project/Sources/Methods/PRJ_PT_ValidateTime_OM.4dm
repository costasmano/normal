//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/12/07, 00:36:12
	// ----------------------------------------------------
	// Method: PRJ_PT_ValidateTime_OM
	// Description
	// Yhe Validate method for time sheet entry
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_TimeTracking
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(3/1/09 20:36:15)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 

Case of 
	: (Not:C34(PRJ_PT_ValidEntry))
		ALERT:C41(PRJ_PT_ValidErrMsg_txt)
	Else 
		C_LONGINT:C283($NewTimeTrackID_L; PT_ProjectID_L; $EntryExistCount_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $EntryExistCount_L)
		QUERY:C277([PRJ_ProjectTimeTracking:124]; [PRJ_ProjectTimeTracking:124]Person ID:3=PT_EmployeeID_I; *)
		QUERY:C277([PRJ_ProjectTimeTracking:124];  & ; [PRJ_ProjectTimeTracking:124]PT_WeekEnding_d:4=PRJ_PT_WeekEnding_d; *)
		QUERY:C277([PRJ_ProjectTimeTracking:124];  & ; [PRJ_ProjectTimeTracking:124]PT_Scope_s:11=PRJ_PT_Scope_s; *)
		QUERY:C277([PRJ_ProjectTimeTracking:124];  & ; [PRJ_ProjectTimeTracking:124]PRJ_ProjectID_l:2=PT_ProjectID_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($EntryExistCount_L>0)
			C_TEXT:C284($msg)
			$msg:="There is already an entry for "+PRJ_ConsultantReviewers_atxt{PRJ_ConsultantReviewers_atxt}+" under "+PRJ_PT_Scope_s+" stage"
			$msg:=$msg+" for week ending "+String:C10(PRJ_PT_WeekEnding_d)+"!"+" Data not saved!"
			ALERT:C41($msg)
		Else 
			CREATE RECORD:C68([PRJ_ProjectTimeTracking:124])
			Inc_Sequence("PRJ_TimeSheetEntry"; ->[PRJ_ProjectTimeTracking:124]PT_TimeTrackingID_l:1)
			[PRJ_ProjectTimeTracking:124]PRJ_ProjectID_l:2:=PT_ProjectID_L
			[PRJ_ProjectTimeTracking:124]Person ID:3:=PT_EmployeeID_I
			[PRJ_ProjectTimeTracking:124]PT_Coments_txt:5:=PRJ_PT_Coments_txt
			[PRJ_ProjectTimeTracking:124]PT_EWO_s:8:=PRJ_PT_EWO_s
			[PRJ_ProjectTimeTracking:124]PT_Hours_r:6:=PRJ_PT_Hours_r
			[PRJ_ProjectTimeTracking:124]PT_WeekEnding_d:4:=PRJ_PT_WeekEnding_d
			[PRJ_ProjectTimeTracking:124]PT_Scope_s:11:=PRJ_PT_Scope_s
			PRJ_SetProjectChangesMade(->[PRJ_ProjectTimeTracking:124]; ->[PRJ_ProjectTimeTracking:124]PT_ModifiedBy_s:9; ->[PRJ_ProjectTimeTracking:124]PT_ModifiedTimeStamp_s:10)  //Mods_PRJSELECTION
			SAVE RECORD:C53([PRJ_ProjectTimeTracking:124])
			PRJ_PT_Hours_r:=0
		End if 
End case 