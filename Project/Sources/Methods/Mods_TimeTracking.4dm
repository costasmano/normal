//%attributes = {"invisible":true}
If (False:C215)
	//Mods_TimeTracking 
	//Mods for TimeTracking
	
	//Field(->[PRJ_ProjectTimeTracking]PT_EWO_s)  `new field A21
	//Field(->[PRJ_ProjectTimeTracking]PT_HourlyRate_r)  ` change to real
	//Field(->[PRJ_ProjectTimeTracking]PT_Hours_r)  `change to real
	//
	//PRJ_PT_GetConsRevLists 
	//PRJ_PT_GetOtherCostCodes 
	//PRJ_PT_GetProjectEWOs 
	//PRJ_PT_ValidateTime_OM 
	//PRJ_PT_ValidEntry 
	//PRJ_PT_CalcHourTotals 
	//
	//M_PRJ_PT_StartTimeSheetEntry 
	//P_PRJ_StartTimeSheets 
	//
	//DIALOG([PRJ_ProjectTimeTracking];"TImeSheetEntry")  `new form
	//DIALOG([PRJ_ProjectTimeTracking];"ProjectTimeTracking.i")  `modified + method
	//DIALOG([PRJ_ProjectTimeTracking];"PRJ_Details.inc")  `modified + method
	//
	//DIALOG([PRJ_ProjectDetails];"ProjectDetails.o")  `added button for TimeSheet + change in method to load pers arrays and list variables
	//DIALOG([PRJ_ProjectDetails];"ProjectDetails.i")  `added summary list in Timesheet + method to update summary on close detail
	
End if 
