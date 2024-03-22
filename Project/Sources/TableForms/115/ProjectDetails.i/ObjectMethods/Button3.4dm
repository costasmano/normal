// ----------------------------------------------------
// Object Method: PRJ_Save_l
// User name (OS): cjmiller
// Date and time: 11/27/07, 13:12:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 13:12:26`Make sure that after save many records are there
End if 
PRJ_SaveProjectdata
SAVE RECORD:C53([PRJ_ProjectDetails:115])
ProjectChangesMade_b:=False:C215

VALIDATE TRANSACTION:C240
RELATE MANY:C262([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
Case of 
	: (FORM Get current page:C276=3)
		ORDER BY:C49([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]TYP_Received_d:5; <)
	: (FORM Get current page:C276=4)
		ORDER BY:C49([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]TYP_Received_d:5; <)
	: (FORM Get current page:C276=5)
		ORDER BY:C49([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]SKT_Recieved_d:5; <)
	: (FORM Get current page:C276=6)
		ORDER BY:C49([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3; <)
End case 
START TRANSACTION:C239
//End Object Method: PRJ_Save_l