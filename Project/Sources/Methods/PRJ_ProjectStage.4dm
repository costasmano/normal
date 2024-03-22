//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/31/07, 21:25:40
	// ----------------------------------------------------
	// Method: PRJ_ProjectStage
	// Description
	// <caret/>
	// 
	// Parameters
	// $0 : ProjectStage_r
	// ----------------------------------------------------
	
	Mods_2007_CM10a
End if 
C_REAL:C285($0; $ProjectStage_r)
//stages are:
//1 = start-
//2 = type study #1 -1
//type study done
//3 = sketch1-done
//4 = Sketch FHWAreview
//5 = Review1-done
//6 = PSE FHWAreview
//7 =-End is Bridge Mylar signed
Case of 
	: (Records in selection:C76([PRJ_StructuralReview:119])>0)
		ORDER BY:C49([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3; <)
		
		Case of 
			: ([PRJ_ProjectDetails:115]PRJ_FHWAPSEApproved_d:51#!00-00-00!)
				$ProjectStage_r:=7
			: ([PRJ_StructuralReview:119]SR_GradingStatus_l:10>5)
				$ProjectStage_r:=6.9
			: ([PRJ_StructuralReview:119]SR_GradingStatus_l:10>0)
				$ProjectStage_r:=6.2
			: ([PRJ_StructuralReview:119]SR_Assigned_d:6>!00-00-00!)
				$ProjectStage_r:=6.1
			Else 
				$ProjectStage_r:=6
		End case 
		
	: (Records in selection:C76([PRJ_SketchPlans:120])>0)
		$ProjectStage_r:=4
	: (Records in selection:C76([PRJ_TypeStudy:121])>0)
	Else 
		$ProjectStage_r:=1
End case 

$0:=$ProjectStage_r