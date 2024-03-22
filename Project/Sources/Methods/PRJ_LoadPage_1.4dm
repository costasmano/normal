//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadPage_1
// User name (OS): cjmiller
// Date and time: 03/31/06, 15:00:43
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //10/13/06, 11:23:02`Fill in report last data 
	Mods_2006_CJMv2  //12/14/06, 11:13:34`Fix problem where once set to invisible not reset when data is there
	Mods_2006_CJMv2  //03/15/07, 15:59:18` remove * form bridge de variable
	Mods_2007_CJMv2  //05/09/07, 11:55:47`set new buttons visibility on pages `PRJ_GotoPrjInfo_FN
	Mods_2007_CJMv3  //06/13/07 `Make sure that when report records exists data appears even when dates are incorrect
	Mods_2007_CJMv3  //06/13/07 Make sure many area is invisible on load
	Mods_2007_CJM_v5310  //06/28/07 Make projec infor buttons visibility based upon data as well as platform
End if 



PRJ_LoadBasedUponBIN
PRJ_ReportButtonTitle_s:="Report:"
PRJ_TypeStudyButtonTitle_s:="Type Study:"
PRJ_SketchPlansButtonTitle_s:="Sketch Plans:"
PRJ_ProjectReviewButtonTitle_s:="Structural Review:"
PRJ_ProjectReviewLast_txt:=""
PRJ_SketchPlanLast_txt:=""
PRJ_TypeStudyLast_txt:=""
PRJ_ReportLast_txt:=""
C_DATE:C307($Oldest_d)
C_TEXT:C284($OldestDescription_txt)
OBJECT SET VISIBLE:C603(*; "Manybuttons@"; True:C214)
OBJECT SET VISIBLE:C603(*; "ManyButtonsProjReview2"; False:C215)

If (Records in selection:C76([PRJ_ReportData:118])=0)
	PRJ_ReportButtonTitle_s:="No "+PRJ_ReportButtonTitle_s
	OBJECT SET VISIBLE:C603(*; "LastReport@"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "LastReport@"; True:C214)
	ORDER BY:C49([PRJ_ReportData:118]; [PRJ_ReportData:118]RPT_Received_d:3; <)
	PRJ_ReportLast_txt:=""
	C_TEXT:C284($PRJ_ReportLast_txt)
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Records in selection:C76([PRJ_ReportData:118]))
		GOTO SELECTED RECORD:C245([PRJ_ReportData:118]; $Loop_l)
		$PRJ_ReportLast_txt:=""
		
		Case of 
			: ([PRJ_ReportData:118]RPT_Approved_d:4#!00-00-00!)
				$PRJ_ReportLast_txt:=[PRJ_ReportData:118]RPT_ReportType_s:2+" Approved by / date "+[PRJ_ReportData:118]RPT_ApprovedBy_s:5+"/"+String:C10([PRJ_ReportData:118]RPT_Approved_d:4; 7)+"; "
			: ([PRJ_ReportData:118]RPT_Received_d:3#!00-00-00!)
				$PRJ_ReportLast_txt:=[PRJ_ReportData:118]RPT_ReportType_s:2+" Received date "+String:C10([PRJ_ReportData:118]RPT_Received_d:3; 7)+"; "
			Else 
				$PRJ_ReportLast_txt:=[PRJ_ReportData:118]RPT_ReportType_s:2+";"
		End case 
		If ($PRJ_ReportLast_txt#"")
			PRJ_ReportLast_txt:=PRJ_ReportLast_txt+$PRJ_ReportLast_txt
		End if 
	End for 
	
End if 
If (Records in selection:C76([PRJ_TypeStudy:121])=0)
	PRJ_TypeStudyButtonTitle_s:="No "+PRJ_TypeStudyButtonTitle_s
	OBJECT SET VISIBLE:C603(*; "LastType@"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "LastType@"; True:C214)
	ORDER BY:C49([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]TYP_Received_d:5; <)
	FIRST RECORD:C50([PRJ_TypeStudy:121])
	PRJ_TypeStudyLast_txt:="No. "+String:C10(Records in selection:C76([PRJ_TypeStudy:121]))+" By: "+[PRJ_TypeStudy:121]TYP_Source_s:6+" - "+[PRJ_TypeStudy:121]TYP_StructureType_s:4+" - "
	$Oldest_d:=!00-00-00!
	$OldestDescription_txt:=""
	If ([PRJ_TypeStudy:121]TYP_Received_d:5>$Oldest_d)
		$Oldest_d:=[PRJ_TypeStudy:121]TYP_Received_d:5
		$OldestDescription_txt:="Rec'd "
	End if 
	If ([PRJ_TypeStudy:121]TYP_RecFromGeotech_d:9>=$Oldest_d)
		$Oldest_d:=[PRJ_TypeStudy:121]TYP_RecFromGeotech_d:9
		$OldestDescription_txt:="Rec'd from Geot. "
	End if 
	If ([PRJ_TypeStudy:121]TYP_RecFromHydro_d:8>=$Oldest_d)
		$Oldest_d:=[PRJ_TypeStudy:121]TYP_RecFromHydro_d:8
		$OldestDescription_txt:="Rec'd from Hyd "
	End if 
	If ([PRJ_TypeStudy:121]TYP_CommentsToDE_d:11>=$Oldest_d)
		$Oldest_d:=[PRJ_TypeStudy:121]TYP_CommentsToDE_d:11
		$OldestDescription_txt:="Commments to D.E. "
	End if 
	If ([PRJ_TypeStudy:121]TYP_Distribution_d:7>=$Oldest_d)
		$Oldest_d:=[PRJ_TypeStudy:121]TYP_Distribution_d:7
		$OldestDescription_txt:="Distribution "
	End if 
	If ([PRJ_TypeStudy:121]TYP_Approved_d:10>=$Oldest_d)
		$Oldest_d:=[PRJ_TypeStudy:121]TYP_Approved_d:10
		$OldestDescription_txt:="Approved  "
	End if 
	PRJ_TypeStudyLast_txt:=PRJ_TypeStudyLast_txt+$OldestDescription_txt+String:C10($Oldest_d; 7)
End if 
If (Records in selection:C76([PRJ_SketchPlans:120])=0)
	PRJ_SketchPlansButtonTitle_s:="No "+PRJ_SketchPlansButtonTitle_s
	OBJECT SET VISIBLE:C603(*; "LastSketch@"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "LastSketch@"; True:C214)
	PRJ_SketchPlanLast_txt:="No. "+String:C10(Records in selection:C76([PRJ_SketchPlans:120]))+" "
	ORDER BY:C49([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3; <)
	FIRST RECORD:C50([PRJ_SketchPlans:120])
	$Oldest_d:=!00-00-00!
	$OldestDescription_txt:=""
	If ([PRJ_SketchPlans:120]SKT_Recieved_d:5>$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_Recieved_d:5
		$OldestDescription_txt:="Rec'd "
	End if 
	If ([PRJ_SketchPlans:120]SKT_Assigned_d:6>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_Assigned_d:6
		$OldestDescription_txt:="Ass. "
	End if 
	If ([PRJ_SketchPlans:120]SKT_AssToGeotech_d:7>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_AssToGeotech_d:7
		$OldestDescription_txt:="Ass. to Geot. "
	End if 
	If ([PRJ_SketchPlans:120]SKT_ReceivedFromGeotech_d:9>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_ReceivedFromGeotech_d:9
		$OldestDescription_txt:="Rec'd from Geot. "
	End if 
	If ([PRJ_SketchPlans:120]SKT_AssToHydro_d:8>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_AssToHydro_d:8
		$OldestDescription_txt:="Ass. to Hyd "
	End if 
	If ([PRJ_SketchPlans:120]SKT_ReceivedFromHydro_d:10>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_ReceivedFromHydro_d:10
		$OldestDescription_txt:="Rec'd from Hyd "
	End if 
	If ([PRJ_SketchPlans:120]SKT_CommentsToDE_d:11>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_CommentsToDE_d:11
		$OldestDescription_txt:="Commments to D.E. "
	End if 
	If ([PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13
		$OldestDescription_txt:="Chief Engineer Approval  "
	End if 
	
	If ([PRJ_SketchPlans:120]SKT_DistributionForSignature_d:12>=$Oldest_d)
		$Oldest_d:=[PRJ_SketchPlans:120]SKT_DistributionForSignature_d:12
		$OldestDescription_txt:="Distributed for signature  "
	End if 
	PRJ_SketchPlanLast_txt:=PRJ_SketchPlanLast_txt+$OldestDescription_txt+String:C10($Oldest_d; 7)
	
End if 
If (Records in selection:C76([PRJ_StructuralReview:119])=0)
	PRJ_ProjectReviewButtonTitle_s:="No "+PRJ_ProjectReviewButtonTitle_s
	OBJECT SET VISIBLE:C603(*; "LastProjReview@"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "LastProjReview@"; True:C214)
	PRJ_ProjectReviewLast_txt:="No. "+String:C10(Records in selection:C76([PRJ_StructuralReview:119]))+" "
	ORDER BY:C49([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3; <)
	FIRST RECORD:C50([PRJ_StructuralReview:119])
	$Oldest_d:=!00-00-00!
	$OldestDescription_txt:=""
	If ([PRJ_StructuralReview:119]SR_Received_d:7>$Oldest_d)
		$Oldest_d:=[PRJ_StructuralReview:119]SR_Received_d:7
		$OldestDescription_txt:="Rec'd "
	End if 
	If ([PRJ_StructuralReview:119]SR_Assigned_d:6>$Oldest_d)
		$Oldest_d:=[PRJ_StructuralReview:119]SR_Assigned_d:6
		$OldestDescription_txt:="Ass. "
	End if 
	If ([PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4>$Oldest_d)
		$Oldest_d:=[PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4
		$OldestDescription_txt:="Comments to D.E. "
	End if 
	PRJ_ProjectReviewLast_txt:=PRJ_ProjectReviewLast_txt+$OldestDescription_txt+String:C10($Oldest_d; 7)
End if 
If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
	PRJ_DEBridgeNo_s:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
Else 
	PRJ_DEBridgeNo_s:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
End if 

OBJECT SET VISIBLE:C603(*; "SummaryDisplayPage0_1"; False:C215)
OBJECT SET VISIBLE:C603(*; "SummaryDisplayPage0_48"; False:C215)
If (<>PL_LPlatfrm=Windows:K25:3)
	If ([PRJ_ProjectFile:117]PF_FileNumber_l:3>0)
		OBJECT SET VISIBLE:C603(*; "SummaryDisplayPage0_1"; True:C214)
	End if 
	If ([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3>0)
		OBJECT SET VISIBLE:C603(*; "SummaryDisplayPage0_48"; True:C214)
	End if 
End if 

//End PRJ_LoadPage_1