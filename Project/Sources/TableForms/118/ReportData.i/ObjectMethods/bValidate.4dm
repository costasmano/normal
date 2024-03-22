// ----------------------------------------------------
// Object Method: bValidate
// User name (OS): cjmiller
// Date and time: 11/27/07, 12:56:08
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 12:56:10   `Make sure add only does one record at a time
	Mods_2008_CJM_v56  //r001 `06/12/08, 16:09:13   `Add update of last action date    
End if 
If (Is new record:C668([PRJ_ReportData:118]))
	PRJ_2ndAddSubRecord_b:=True:C214
End if 

PRJ_UpdateLastAction(Table name:C256(->[PRJ_ReportData:118]))

//End Object Method: bValidate