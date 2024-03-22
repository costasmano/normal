//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/11/07, 20:34:56
	// ----------------------------------------------------
	// Method: P_PRJ_StartTimeSheets
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_TimeTracking
	// Modified by: costasmanousakis-(Designer)-(3/1/09 23:38:10)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 
SHORT_MESSAGE("Please wait..")
PRJ_PT_GetConsRevLists
PRJ_PT_GetOtherCostCodes
PRJ_PT_GetProjectEWOs
CLOSE WINDOW:C154
C_LONGINT:C283(PT_EmployeeID_I)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(PT_ProjectID_L)
C_DATE:C307(PRJ_PT_WeekEnding_d)
C_TEXT:C284(PRJ_PT_Coments_txt)
C_TEXT:C284(PRJ_PT_EWO_s)  // Command Replaced was o_C_STRING length was 21
C_REAL:C285(PRJ_PT_Hours_r)
C_LONGINT:C283(PT_ProjectListIndex_L)
C_TEXT:C284(PRJ_PT_Scope_s)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($DialogWindow_L)
PRJ_PT_WeekEnding_d:=Add to date:C393(Current date:C33(*); 0; 0; (7-Day number:C114(Current date:C33(*))))

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([PRJ_ProjectTimeTracking:124]; "TimeSheetEntry"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 1; Movable dialog box:K34:7)
//$DialogWindow_L:=Open form window([PRJ_ProjectTimeTracking];"TimeSheetEntry";Modal dialog )

DIALOG:C40([PRJ_ProjectTimeTracking:124]; "TimeSheetEntry")
CLOSE WINDOW:C154
If (Is a list:C621(PT_DesignProjectList_HL))
	CLEAR LIST:C377(PT_DesignProjectList_HL; *)
End if 
If (Is a list:C621(PT_ConstructionProjectList_HL))
	CLEAR LIST:C377(PT_ConstructionProjectList_HL; *)
End if 