//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2008_CJM_v56
// User name (OS): cjmiller
// Date and time: 06/12/08, 15:47:55
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v56  //r00` `06/16/08, 12:06:06   `
	
End if 
//Add code to keep track of date changes in [PRJ_ReportData], [PRJ_SketchPlans], [PRJ_StructuralReview], and [PRJ_TypeStudy]
//--- DONE
//New dialog
//[PRJ_ProjectDetails];"LastAction.dlg"
//  ` Form Method: LastAction.dlg
//[PRJ_ReportData];"ReportData.i" - no form change
//  ` Object Method: bValidate
//[PRJ_StructuralReview];"ProjectReview.i"  `-no form change
//  ` Object Method: bValidate
//[PRJ_SketchPlans];"SketchPlans.i"  `-no form change
//  ` Object Method: bValidate
//[PRJ_TypeStudy];"TypeStudy.i"  `-no form change
//  ` Object Method: bValidate
//PRJ_UpdateLastAction

//r002 `06/16/08, 12:10:19   `Fix defect in sumbmission number ---DONE
//PRJ_ControlPageMovement 
//--- DONE

//r002 `06/16/08, 12:10:19   `Fix defect in bin not being updated correctly when new bin created
//[Bridge MHD NBIS];"AssignReplacement.dlg"
//  ` Object Method: Button1

//r002 `06/16/08, 12:10:19  `Fix defect wher wrong bin dialog displays - code nort updated
//[PRJ_ProjectDetails];"ProjectDetails.i"

//r002 `06/16/08, 13:03:04   `Fix bug with date button not updateing correct field ---DONE
//[PRJ_ReportData];"ReportData.i"
//  ` Object Method: Button1

//r002 `06/16/08, 14:01:00 ---DONE
//Made all prj included forms only use display detail and on validate events
//End Mods_2008_CJM_v56


//r004
//Add code to create include bin record when not replacement
PRJ_CreateIncludedBINRecord