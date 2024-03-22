//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_UpdateLastAction
// User name (OS): cjmiller
// Date and time: 06/12/08, 15:59:03
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v56  //r001 `06/12/08, 16:09:24   `Add update of last action date
	// Modified by: costasmanousakis-(Designer)-(6/25/09 09:13:31)
	Mods_2009_06  //fix Action text for [PRJ_SketchPlans]SKT_ChiefEngApproval_d
	// Modified by: costasmanousakis-(Designer)-(4/20/10 13:58:12)
	Mods_2010_04
	//  `Added actions for [PRJ_SketchPlans]SKT_ReceivedFromHydro_d & [PRJ_SketchPlans]SKT_ReceivedFromGeotech_d
End if 
C_TEXT:C284($1; $TableName_txt)
$TableName_txt:=$1
C_BOOLEAN:C305($Continue_b)
$Continue_b:=True:C214
C_TEXT:C284(PRJ_CurrentAction_txt)
Case of 
	: ($TableName_txt="PRJ_ReportData")
		Case of 
			: ([PRJ_ReportData:118]RPT_Approved_d:4)#(Old:C35([PRJ_ReportData:118]RPT_Approved_d:4))
				PRJ_CurrentAction_txt:="Report - Approved "+String:C10([PRJ_ReportData:118]RPT_Approved_d:4; Internal date short special:K1:4)+" "+[PRJ_ReportData:118]RPT_ReportType_s:2
				
			: ([PRJ_ReportData:118]RPT_Received_d:3)#(Old:C35([PRJ_ReportData:118]RPT_Received_d:3))
				PRJ_CurrentAction_txt:="Report - Received "+String:C10([PRJ_ReportData:118]RPT_Received_d:3; Internal date short special:K1:4)+" "+[PRJ_ReportData:118]RPT_ReportType_s:2
				
			Else 
				$Continue_b:=False:C215
		End case 
		
	: ($TableName_txt="PRJ_SketchPlans")
		Case of 
			: ([PRJ_SketchPlans:120]SKT_DistributionForSignature_d:12)#(Old:C35([PRJ_SketchPlans:120]SKT_DistributionForSignature_d:12))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Distribution for signature "+String:C10([PRJ_SketchPlans:120]SKT_DistributionForSignature_d:12; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13)#(Old:C35([PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Chief Engineer Approval "+String:C10([PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_CommentsToDE_d:11)#(Old:C35([PRJ_SketchPlans:120]SKT_CommentsToDE_d:11))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Comments to DE "+String:C10([PRJ_SketchPlans:120]SKT_CommentsToDE_d:11; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_AssToHydro_d:8)#(Old:C35([PRJ_SketchPlans:120]SKT_AssToHydro_d:8))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Assigned to Hydraulic "+String:C10([PRJ_SketchPlans:120]SKT_AssToHydro_d:8; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_ReceivedFromHydro_d:10)#(Old:C35([PRJ_SketchPlans:120]SKT_ReceivedFromHydro_d:10))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Received from Hydraulic "+String:C10([PRJ_SketchPlans:120]SKT_ReceivedFromHydro_d:10; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_AssToGeotech_d:7)#(Old:C35([PRJ_SketchPlans:120]SKT_AssToGeotech_d:7))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Assigned to Geotech "+String:C10([PRJ_SketchPlans:120]SKT_AssToGeotech_d:7; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_ReceivedFromGeotech_d:9)#(Old:C35([PRJ_SketchPlans:120]SKT_ReceivedFromGeotech_d:9))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Received from Geotech "+String:C10([PRJ_SketchPlans:120]SKT_ReceivedFromGeotech_d:9; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_Assigned_d:6)#(Old:C35([PRJ_SketchPlans:120]SKT_Assigned_d:6))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Assigned "+String:C10([PRJ_SketchPlans:120]SKT_Assigned_d:6; Internal date short special:K1:4)
				
			: ([PRJ_SketchPlans:120]SKT_Recieved_d:5)#(Old:C35([PRJ_SketchPlans:120]SKT_Recieved_d:5))
				PRJ_CurrentAction_txt:="Sketch #"+String:C10([PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3)+"- Received "+String:C10([PRJ_SketchPlans:120]SKT_Recieved_d:5; Internal date short special:K1:4)
				
			Else 
				$Continue_b:=False:C215
		End case 
		
	: ($TableName_txt="PRJ_StructuralReview")
		Case of 
			: ([PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4)#(Old:C35([PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4))
				PRJ_CurrentAction_txt:="Structural review #"+String:C10([PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3)+"- Comments to DE "+String:C10([PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4; Internal date short special:K1:4)
				
			: ([PRJ_StructuralReview:119]SR_Assigned_d:6)#(Old:C35([PRJ_StructuralReview:119]SR_Assigned_d:6))
				PRJ_CurrentAction_txt:="Structural review  #"+String:C10([PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3)+"- Assigned "+String:C10([PRJ_StructuralReview:119]SR_Assigned_d:6; Internal date short special:K1:4)
				
			: ([PRJ_StructuralReview:119]SR_Received_d:7)#(Old:C35([PRJ_StructuralReview:119]SR_Received_d:7))
				PRJ_CurrentAction_txt:="Structural review  #"+String:C10([PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3)+"- Received "+String:C10([PRJ_StructuralReview:119]SR_Received_d:7; Internal date short special:K1:4)
				
			Else 
				$Continue_b:=False:C215
		End case 
		
	: ($TableName_txt="PRJ_TypeStudy")
		Case of 
			: ([PRJ_TypeStudy:121]TYP_Approved_d:10)#(Old:C35([PRJ_TypeStudy:121]TYP_Approved_d:10))
				PRJ_CurrentAction_txt:="Type Study - Approved "+String:C10([PRJ_TypeStudy:121]TYP_Approved_d:10; Internal date short special:K1:4)
			: ([PRJ_TypeStudy:121]TYP_CommentsToDE_d:11)#(Old:C35([PRJ_TypeStudy:121]TYP_CommentsToDE_d:11))
				PRJ_CurrentAction_txt:="Type Study - Comments to DE  "+String:C10([PRJ_TypeStudy:121]TYP_CommentsToDE_d:11; Internal date short special:K1:4)
			: ([PRJ_TypeStudy:121]TYP_RecFromHydro_d:8)#(Old:C35([PRJ_TypeStudy:121]TYP_RecFromHydro_d:8))
				PRJ_CurrentAction_txt:="Type Study - Received from Hydraulic  "+String:C10([PRJ_TypeStudy:121]TYP_RecFromHydro_d:8; Internal date short special:K1:4)
			: ([PRJ_TypeStudy:121]TYP_RecFromGeotech_d:9)#(Old:C35([PRJ_TypeStudy:121]TYP_RecFromGeotech_d:9))
				PRJ_CurrentAction_txt:="Type Study - Received from GEO  "+String:C10([PRJ_TypeStudy:121]TYP_RecFromGeotech_d:9; Internal date short special:K1:4)
			: ([PRJ_TypeStudy:121]TYP_Distribution_d:7)#(Old:C35([PRJ_TypeStudy:121]TYP_Distribution_d:7))
				PRJ_CurrentAction_txt:="Type Study - Assigned "+String:C10([PRJ_TypeStudy:121]TYP_Distribution_d:7; Internal date short special:K1:4)
			: ([PRJ_TypeStudy:121]TYP_Received_d:5)#(Old:C35([PRJ_TypeStudy:121]TYP_Received_d:5))
				PRJ_CurrentAction_txt:="Type Study - Received "+String:C10([PRJ_TypeStudy:121]TYP_Received_d:5; Internal date short special:K1:4)
			Else 
				$Continue_b:=False:C215
		End case 
		
End case 

If ($Continue_b)
	C_LONGINT:C283($Width_l; $Height_l)
	FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "LastAction.dlg"; $Width_l; $Height_l)
	NewWindow($Width_l; $Height_l; 1; 0; "Last Action Update")
	DIALOG:C40([PRJ_ProjectDetails:115]; "LastAction.dlg")
	CLOSE WINDOW:C154
End if 
//End PRJ_UpdateLastAction