//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJUpdateFromImport($CurrentStructural_l;$LastAction_txt;$LumpSumBreakdown_txt;$Commments_txt;$BeamCost_txt;$BeamUnit_txt;$UnitsBeam_txt;$Item995_txt;$Status_txt)
// User name (OS): cjmiller
// Date and time: 02/26/08, 14:49:36
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v001
	// Modified by: costasmanousakis-(Designer)-(5/27/08 09:44:07)
	Mods_2008_CM_5403
	//  `use a blob to pass all parameters,
	//  `added more updating of related records by adding ones that are not found
	//  `added more detail on the type of updates done.
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($CurrentStructural_l)
C_TEXT:C284($LastAction_txt; $LumpSumBreakdown_txt; $Commments_txt; $BeamCost_txt; $BeamUnit_txt; $UnitsBeam_txt; $Item995_txt; $Status_txt; $ErrorDescription_txt; $Changes_txt)
C_TEXT:C284($Commments_txt; $BDS_txt; $BinUpdateRequest_txt; $CompletionDate_txt)
C_TEXT:C284($HydroReport_txt; $GeotechReport_txt; $TypeStudy_txt; $TypeStudyApprovedType_txt; $SketchPlan_txt; $SketchPlanReview_txt; $SketchPlanSigned_txt; $SketchPlanResponse_txt)
C_TEXT:C284($StructureReviewAll_txt; $StructureReview1ComToDE_txt; $StructureReviewApproval_txt; $StructureReview2_txt; $StructureReview3_txt)
C_LONGINT:C283($PRJ_utReviewerID_L)
C_TIME:C306($SQLDocument_tm)
If (False:C215)
	//C_LONGINT($1;$CurrentStructural_l)
	//$CurrentStructural_l:=$1
	//C_TEXT($0;$2;$LastAction_txt;$3;$LumpSumBreakdown_txt;$4;$Commments_txt;$5;$BeamCost_txt;$6;$BeamUnit_txt;$7;$UnitsBeam_txt;$8;$Item995_txt;$9;$Status_txt;$ErrorDescription_txt;$Changes_txt)
	//$LastAction_txt:=$2
	//$LumpSumBreakdown_txt:=$3
	//$Commments_txt:=$4
	//$BeamCost_txt:=$5
	//$BeamUnit_txt:=$6
	//$UnitsBeam_txt:=$7
	//$Item995_txt:=$8
	//$Status_txt:=$9
Else 
	C_TEXT:C284($0)
	C_BLOB:C604($1; $Params_x)
	$Params_x:=$1
	C_LONGINT:C283($offset_L)
	$offset_L:=0
	BLOB TO VARIABLE:C533($Params_x; $CurrentStructural_l; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $LastAction_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $LumpSumBreakdown_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $Commments_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $BeamCost_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $BeamUnit_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $UnitsBeam_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $Item995_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $Status_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $BDS_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $BinUpdateRequest_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $CompletionDate_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $HydroReport_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $GeotechReport_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $TypeStudy_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $TypeStudyApprovedType_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $SketchPlan_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $SketchPlanReview_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $SketchPlanSigned_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $SketchPlanResponse_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $StructureReviewAll_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $StructureReview1ComToDE_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $StructureReviewApproval_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $StructureReview2_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $StructureReview3_txt; $offset_L)
	BLOB TO VARIABLE:C533($Params_x; $PRJ_utReviewerID_L; $offset_L)
	
	//BLOB TO VARIABLE($Params_x;;$offset_L)
	
End if 
$ErrorDescription_txt:=""
$Changes_txt:=""
C_DATE:C307($date_d)
C_LONGINT:C283($LongInteger_l)

C_REAL:C285($RealNumber_r)
C_BOOLEAN:C305($Changesmade_b)
If (ut_LoadRecord(->[PRJ_ProjectDetails:115]))
	$Changesmade_b:=False:C215
	If ([PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39=$CurrentStructural_l)
	Else 
		$Changesmade_b:=True:C214
		[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39:=$CurrentStructural_l
		PRJ_SaveProjectdata
		$Changes_txt:=$Changes_txt+" StrMgr "
	End if 
	If ([PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9#$LastAction_txt)
		[PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9:=$LastAction_txt
		$Changesmade_b:=True:C214
		$Changes_txt:=$Changes_txt+" LastAct "
	End if 
	If ($LumpSumBreakdown_txt#"")
		$date_d:=ut_PRJ_SetDate($LumpSumBreakdown_txt)
		If ([PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22#$Date_d)
			$Changesmade_b:=True:C214
			[PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22:=$Date_d
			$Changes_txt:=$Changes_txt+" LSB "
		End if 
	End if 
	If ([PRJ_ProjectDetails:115]PRJ_Comments_txt:10#$Commments_txt)
		$Changesmade_b:=True:C214
		[PRJ_ProjectDetails:115]PRJ_Comments_txt:10:=$Commments_txt
		$Changes_txt:=$Changes_txt+" Comments "
	End if 
	If ([PRJ_ProjectDetails:115]PRJ_BridgeDataSheetComplete_s:13#$BDS_txt)
		$Changesmade_b:=True:C214
		[PRJ_ProjectDetails:115]PRJ_BridgeDataSheetComplete_s:13:=$BDS_txt
		$Changes_txt:=$Changes_txt+" BDS "
	End if 
	If ([PRJ_ProjectDetails:115]PRJ_BinUpdateRequest_s:26#$BinUpdateRequest_txt)
		$Changesmade_b:=True:C214
		[PRJ_ProjectDetails:115]PRJ_BinUpdateRequest_s:26:=$BinUpdateRequest_txt
		$Changes_txt:=$Changes_txt+" BinUpd "
	End if 
	If ($CompletionDate_txt#"")
		$date_d:=ut_PRJ_SetDate($CompletionDate_txt)
		If ([PRJ_ProjectDetails:115]PRJ_Completion_d:37#$Date_d)
			$Changesmade_b:=True:C214
			[PRJ_ProjectDetails:115]PRJ_Completion_d:37:=$Date_d
			$Changes_txt:=$Changes_txt+" ComplDate "
		End if 
	End if 
	
	If ($BeamCost_txt#"")
		$BeamCost_txt:=ut_PRJRemoveExtraCharacters($BeamCost_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
		If (ut_IsaRealNumber($BeamCost_txt))
			$RealNumber_r:=Round:C94(Num:C11($BeamCost_txt); 2)
			If (Round:C94($RealNumber_r; 2)#Round:C94([PRJ_ProjectDetails:115]PRJ_BeamCost_r:27; 2))
				[PRJ_ProjectDetails:115]PRJ_BeamCost_r:27:=Round:C94(Num:C11($BeamCost_txt); 2)
				$Changesmade_b:=True:C214
				$Changes_txt:=$Changes_txt+" BmCost "
			End if 
		End if 
	End if 
	If ($BeamUnit_txt#"")
		$BeamUnit_txt:=ut_PRJRemoveExtraCharacters($BeamUnit_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
		If (ut_IsALongint($BeamUnit_txt))
			$LongInteger_l:=Num:C11($BeamUnit_txt)
			If ($LongInteger_l#[PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28)
				[PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28:=$LongInteger_l
				$Changesmade_b:=True:C214
				$Changes_txt:=$Changes_txt+" BmUnit "
			End if 
		End if 
	End if 
	If ([PRJ_ProjectDetails:115]PRJ_BeamUnitType_s:36#$UnitsBeam_txt)
		[PRJ_ProjectDetails:115]PRJ_BeamUnitType_s:36:=$UnitsBeam_txt
		$Changesmade_b:=True:C214
		$Changes_txt:=$Changes_txt+" BmUniType "
	End if 
	$Item995_txt:=ut_PRJRemoveExtraCharacters($Item995_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
	//$Item995_txt:=Replace string($Item995_txt;;"")
	//$Item995_txt:=Replace string($Item995_txt;" ";"")
	//$Item995_txt:=Replace string($Item995_txt;",";"")
	//$Item995_txt:=Replace string($Item995_txt;Char(Double quote );"";100)
	If ($Item995_txt#"")
		If (ut_IsaRealNumber($Item995_txt))
			If (Num:C11($Item995_txt)#[PRJ_ProjectDetails:115]PRJ_Item995_r:29)
				[PRJ_ProjectDetails:115]PRJ_Item995_r:29:=Num:C11($Item995_txt)
				$Changesmade_b:=True:C214
				$Changes_txt:=$Changes_txt+" Itm995 "
			End if 
		Else 
			$ErrorDescription_txt:="Item995"
		End if 
	End if 
	If ([PRJ_ProjectDetails:115]PRJ_Status_s:35#$Status_txt)
		[PRJ_ProjectDetails:115]PRJ_Status_s:35:=$Status_txt
		$Changesmade_b:=True:C214
		$Changes_txt:=$Changes_txt+" Status "
	End if 
	If ($HydroReport_txt#"")
		QUERY:C277([PRJ_ReportData:118]; [PRJ_ReportData:118]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
		QUERY:C277([PRJ_ReportData:118];  & ; [PRJ_ReportData:118]RPT_ReportType_s:2="Hydraulic")
		If (Records in selection:C76([PRJ_ReportData:118])>0)
			
		Else 
			$HydroReport_txt:=ut_PRJRemoveExtraCharacters($HydroReport_txt; Char:C90(Double quote:K15:41))
			ut_PRJImportCreateHydraulic($HydroReport_txt; "Hydraulic")
			$Changesmade_b:=True:C214
			$Changes_txt:=$Changes_txt+" Hydraulic "
		End if 
	End if 
	If ($GeotechReport_txt#"")
		QUERY:C277([PRJ_ReportData:118]; [PRJ_ReportData:118]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
		QUERY:C277([PRJ_ReportData:118];  & ; [PRJ_ReportData:118]RPT_ReportType_s:2="GEOTech")
		If (Records in selection:C76([PRJ_ReportData:118])>0)
			
		Else 
			$GeotechReport_txt:=ut_PRJRemoveExtraCharacters($GeotechReport_txt; Char:C90(Double quote:K15:41))
			ut_PRJImportCreateGeotech($GeotechReport_txt; "GEOTech")
			$Changesmade_b:=True:C214
			$Changes_txt:=$Changes_txt+" Geotech "
		End if 
	End if 
	$TypeStudy_txt:=ut_PRJRemoveExtraCharacters($TypeStudy_txt; Char:C90(Double quote:K15:41))
	$TypeStudyApprovedType_txt:=ut_PRJRemoveExtraCharacters($TypeStudyApprovedType_txt; Char:C90(Double quote:K15:41))
	If ($TypeStudy_txt#"")
		QUERY:C277([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
		If (Records in selection:C76([PRJ_TypeStudy:121])>0)
			
		Else 
			ut_PRJCreateTypeStudy($TypeStudy_txt; $TypeStudyApprovedType_txt; $CurrentStructural_l)
			$Changesmade_b:=True:C214
			$Changes_txt:=$Changes_txt+" Type "
		End if 
	End if 
	$SketchPlan_txt:=ut_PRJRemoveExtraCharacters($SketchPlan_txt; Char:C90(Double quote:K15:41))
	$SketchPlanReview_txt:=ut_PRJRemoveExtraCharacters($SketchPlanReview_txt; Char:C90(Double quote:K15:41))
	$SketchPlanSigned_txt:=ut_PRJRemoveExtraCharacters($SketchPlanSigned_txt; Char:C90(Double quote:K15:41))
	$SketchPlanResponse_txt:=ut_PRJRemoveExtraCharacters($SketchPlanResponse_txt; Char:C90(Double quote:K15:41))
	
	If ($SketchPlan_txt="") & ($SketchPlanReview_txt="") & ($SketchPlanSigned_txt="") & ($SketchPlanResponse_txt="")
		
	Else 
		QUERY:C277([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
		If (Records in selection:C76([PRJ_SketchPlans:120])>0)
		Else 
			ut_PRJCreateSketchPlan($SketchPlan_txt; $SketchPlanReview_txt; $SketchPlanSigned_txt; $SketchPlanResponse_txt; $CurrentStructural_l)
			$Changesmade_b:=True:C214
			$Changes_txt:=$Changes_txt+" Sketch "
		End if 
	End if 
	
	C_LONGINT:C283($NumberOfReviews_l)
	$NumberOfReviews_l:=0
	$StructureReviewAll_txt:=ut_PRJRemoveExtraCharacters($StructureReviewAll_txt; Char:C90(Double quote:K15:41))
	$StructureReview1ComToDE_txt:=ut_PRJRemoveExtraCharacters($StructureReview1ComToDE_txt; Char:C90(Double quote:K15:41))
	$StructureReviewApproval_txt:=ut_PRJRemoveExtraCharacters($StructureReviewApproval_txt; Char:C90(Double quote:K15:41))
	If ($StructureReviewAll_txt="") & ($StructureReview1ComToDE_txt="") & ($StructureReviewApproval_txt="")
		
	Else 
		$NumberOfReviews_l:=1
		QUERY:C277([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
		QUERY:C277([PRJ_StructuralReview:119];  & ; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3=$NumberOfReviews_l)
		If (Records in selection:C76([PRJ_StructuralReview:119])=0)
			ut_PRJCreateStructuralReview(1; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview1ComToDE_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
			$Changesmade_b:=True:C214
			$Changes_txt:=$Changes_txt+" StrRv1 "
		End if 
		
	End if 
	$StructureReview2_txt:=ut_PRJRemoveExtraCharacters($StructureReview2_txt; Char:C90(Double quote:K15:41))
	If ($StructureReview2_txt="")
	Else 
		$NumberOfReviews_l:=$NumberOfReviews_l+1
		QUERY:C277([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
		QUERY:C277([PRJ_StructuralReview:119];  & ; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3=$NumberOfReviews_l)
		If (Records in selection:C76([PRJ_StructuralReview:119])=0)
			ut_PRJCreateStructuralReview(2; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview2_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
			$Changesmade_b:=True:C214
			$Changes_txt:=$Changes_txt+" StrRv2 "
		End if 
	End if 
	$StructureReview3_txt:=ut_PRJRemoveExtraCharacters($StructureReview3_txt; Char:C90(Double quote:K15:41))
	If ($StructureReview3_txt="")
	Else 
		$NumberOfReviews_l:=$NumberOfReviews_l+1
		QUERY:C277([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
		QUERY:C277([PRJ_StructuralReview:119];  & ; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3=$NumberOfReviews_l)
		If (Records in selection:C76([PRJ_StructuralReview:119])=0)
			ut_PRJCreateStructuralReview(3; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview3_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
			$Changesmade_b:=True:C214
			$Changes_txt:=$Changes_txt+" StrRv3 "
		End if 
	End if 
	
	$0:=$ErrorDescription_txt
	If ($Changesmade_b)
		SAVE RECORD:C53([PRJ_ProjectDetails:115])
		
		If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
			$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5+$Changes_txt+Char:C90(Carriage return:K15:38)
		Else 
			$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7+$Changes_txt+Char:C90(Carriage return:K15:38)
		End if 
		$SQLDocument_tm:=Append document:C265(DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; "Updated "+$Changes_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
	End if 
	UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
	UNLOAD RECORD:C212([PRJ_ProjectFile:117])
	
End if 
//End ut_PRJUpdateFromImport