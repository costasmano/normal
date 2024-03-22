//%attributes = {"invisible":true}
// Method: PRV_Decision_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 08/23/12, 21:32:42
	// ----------------------------------------------------
	// First Release
	Mods_2012_08
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_LONGINT:C283($FormEvent_L)
C_LONGINT:C283($RecalcDecision_L; $UpdateBINInfo_L; $ShowTree_L; $VarsToFields_L; $FieldsToVars)
$RecalcDecision_L:=15200
$UpdateBINInfo_L:=15201
$ShowTree_L:=15202
$VarsToFields_L:=15203
$FieldsToVars:=15204
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
	: (($FormEvent_L=On Clicked:K2:4) | ($FormEvent_L=On Data Change:K2:15))
		C_POINTER:C301($cliickedone_ptr)
		$cliickedone_ptr:=Focus object:C278
		C_TEXT:C284($varName_txt)
		C_LONGINT:C283($tbl_L; $Fld_L)
		RESOLVE POINTER:C394($cliickedone_ptr; $varName_txt; $tbl_L; $Fld_L)
		PRV_Decision_FM($VarsToFields_L)
		
		If ($tbl_L=Table:C252(->[Contract_Project_Maintenance:100]))
			PRV_Decision_FM($RecalcDecision_L)
		End if 
		If ($varName_txt="PRV_DEC_@")
			PRV_Decision_FM($RecalcDecision_L)
		End if 
		
		If ($varName_txt="PRV_RecommMethod_txt")
			[Contract_Project_Maintenance:100]RecommConstr_txt:36:=PRV_RecommMethod_txt
		End if 
		
	: ($FormEvent_L=On Load:K2:1)
		PRV_CTRLSelections("INSPECT")
		C_LONGINT:C283(vApproveLvl)  //Command Replaced was o_C_INTEGER
		vApproveLvl:=0  //Cannot approve inspections from this point of entry. 
		PRV_CTRLListBoxes("INSPECT")
		
		PRV_Decision_FM($FieldsToVars)  //Load the fields into variables
		
		//Load the Decision tree
		If (Read only state:C362([Contract_Assignment_Maintenance:101]))
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE@btn"; False:C215)
		Else 
			C_LONGINT:C283($LoadRecResult_L)
			$LoadRecResult_L:=ut_LoadRecordInteractiveV2(->[Contract_Project_Maintenance:100])
			
			Case of 
				: ($LoadRecResult_L=1)
					PRV_Decision_FM($UpdateBINInfo_L)
					PRV_Decision_FM($FieldsToVars)  //Load the fields into variables
					
					If (Modified record:C314([Contract_Project_Maintenance:100]))
						PRV_Decision_FM($RecalcDecision_L)
					End if 
				: ($LoadRecResult_L=2)
					OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "DE@btn"; False:C215)
			End case 
			
		End if 
		
		PRV_Decision_FM($ShowTree_L)
		PRV_RecommMethod_txt:=[Contract_Project_Maintenance:100]RecommConstr_txt:36
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
	: ($FormEvent_L=$ShowTree_L)
		
		OBJECT SET VISIBLE:C603(*; "FLOW@"; False:C215)
		If ([Contract_Project_Maintenance:100]PrelimDecisValue_r:28<7)
			OBJECT SET VISIBLE:C603(*; "@LT7@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "@GT7@"; True:C214)
			
			OBJECT SET VISIBLE:C603(*; "@PCOSTLY@"; [Contract_Project_Maintenance:100]PrefabCostLess_b:35)
			OBJECT SET VISIBLE:C603(*; "@PCOSTLN@"; Not:C34([Contract_Project_Maintenance:100]PrefabCostLess_b:35))
			
			OBJECT SET VISIBLE:C603(*; "@PJUSY@"; [Contract_Project_Maintenance:100]PrefabJustif_b:34)
			OBJECT SET VISIBLE:C603(*; "@PJUSN@"; Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
			If (Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
				OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
			End if 
			
			OBJECT SET VISIBLE:C603(*; "@PDELY@"; [Contract_Project_Maintenance:100]PrefabDeliv_b:33)
			OBJECT SET VISIBLE:C603(*; "@PDELN@"; Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
			
			If (Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
				OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "@PJUS@"; False:C215)
			End if 
			
			OBJECT SET VISIBLE:C603(*; "@STGY@"; [Contract_Project_Maintenance:100]StagingAvail_b:29)
			OBJECT SET VISIBLE:C603(*; "@STGN@"; Not:C34([Contract_Project_Maintenance:100]StagingAvail_b:29))
			
			If ([Contract_Project_Maintenance:100]StagingAvail_b:29)
				
				OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "@PJUS@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "@PDEL@"; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "@ABCY@"; [Contract_Project_Maintenance:100]ABCOver30_b:32)
				OBJECT SET VISIBLE:C603(*; "@ABCN@"; Not:C34([Contract_Project_Maintenance:100]ABCOver30_b:32))
				
				If ([Contract_Project_Maintenance:100]ABCOver30_b:32)
					OBJECT SET VISIBLE:C603(*; "@PCOSTLY@"; [Contract_Project_Maintenance:100]PrefabCostLess_b:35)
					OBJECT SET VISIBLE:C603(*; "@PCOSTLN@"; Not:C34([Contract_Project_Maintenance:100]PrefabCostLess_b:35))
					
					OBJECT SET VISIBLE:C603(*; "@PJUSY@"; [Contract_Project_Maintenance:100]PrefabJustif_b:34)
					OBJECT SET VISIBLE:C603(*; "@PJUSN@"; Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
					If (Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
						OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
					End if 
					
					OBJECT SET VISIBLE:C603(*; "@PDELY@"; [Contract_Project_Maintenance:100]PrefabDeliv_b:33)
					OBJECT SET VISIBLE:C603(*; "@PDELN@"; Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
					
					If (Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
						OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "@PJUS@"; False:C215)
					End if 
					
				End if 
				
				OBJECT SET VISIBLE:C603(*; "@CLBY@"; [Contract_Project_Maintenance:100]BridgeClose_b:31)
				OBJECT SET VISIBLE:C603(*; "@CLBN@"; Not:C34([Contract_Project_Maintenance:100]BridgeClose_b:31))
				
				If (Not:C34([Contract_Project_Maintenance:100]BridgeClose_b:31))
					OBJECT SET VISIBLE:C603(*; "@ABC@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "@PCOSTLY@"; [Contract_Project_Maintenance:100]PrefabCostLess_b:35)
					OBJECT SET VISIBLE:C603(*; "@PCOSTLN@"; Not:C34([Contract_Project_Maintenance:100]PrefabCostLess_b:35))
					
					OBJECT SET VISIBLE:C603(*; "@PJUSY@"; [Contract_Project_Maintenance:100]PrefabJustif_b:34)
					OBJECT SET VISIBLE:C603(*; "@PJUSN@"; Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
					If (Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
						OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
					End if 
					
					OBJECT SET VISIBLE:C603(*; "@PDELY@"; [Contract_Project_Maintenance:100]PrefabDeliv_b:33)
					OBJECT SET VISIBLE:C603(*; "@PDELN@"; Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
					
					If (Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
						OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "@PJUS@"; False:C215)
					End if 
					
				End if 
				
				OBJECT SET VISIBLE:C603(*; "@UTY@"; [Contract_Project_Maintenance:100]UtilRelocate_b:30)
				OBJECT SET VISIBLE:C603(*; "@UTN@"; Not:C34([Contract_Project_Maintenance:100]UtilRelocate_b:30))
				
				If (Not:C34([Contract_Project_Maintenance:100]UtilRelocate_b:30))
					OBJECT SET VISIBLE:C603(*; "@ABC@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "@CLB@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "@PCOSTLY@"; [Contract_Project_Maintenance:100]PrefabCostLess_b:35)
					OBJECT SET VISIBLE:C603(*; "@PCOSTLN@"; Not:C34([Contract_Project_Maintenance:100]PrefabCostLess_b:35))
					
					OBJECT SET VISIBLE:C603(*; "@PJUSY@"; [Contract_Project_Maintenance:100]PrefabJustif_b:34)
					OBJECT SET VISIBLE:C603(*; "@PJUSN@"; Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
					If (Not:C34([Contract_Project_Maintenance:100]PrefabJustif_b:34))
						OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
					End if 
					
					OBJECT SET VISIBLE:C603(*; "@PDELY@"; [Contract_Project_Maintenance:100]PrefabDeliv_b:33)
					OBJECT SET VISIBLE:C603(*; "@PDELN@"; Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
					
					If (Not:C34([Contract_Project_Maintenance:100]PrefabDeliv_b:33))
						OBJECT SET VISIBLE:C603(*; "@PCOSTL@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "@PJUS@"; False:C215)
					End if 
					
				End if 
			Else 
				OBJECT SET VISIBLE:C603(*; "@CLB@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "@UT@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "@ABC@"; False:C215)
			End if 
			
		End if 
		
	: ($FormEvent_L=$RecalcDecision_L)
		
		C_LONGINT:C283($adtVal_L; $DetVal_L; $ClassVal_L; $otherVal_L; $EmerPts_L; $ActiveRRPts_L; $EvacPts_L)
		C_REAL:C285($HwyEval_r; $OtherF_r; $PrelimValue_r)
		
		$adtVal_L:=PRV_LimitTableValue(PRV_ADTTABLETREE_txt; [Contract_Project_Maintenance:100]ADT_L:14)
		If ($adtVal_L#[Contract_Project_Maintenance:100]ADTValue_L:15)
			[Contract_Project_Maintenance:100]ADTValue_L:15:=$adtVal_L
		End if 
		
		
		$DetVal_L:=PRV_LimitTableValue(PRV_DETOURTABLETREE_txt; [Contract_Project_Maintenance:100]Detour_L:16)
		If ($DetVal_L#[Contract_Project_Maintenance:100]DetourValue_L:17)
			[Contract_Project_Maintenance:100]DetourValue_L:17:=$DetVal_L
		End if 
		
		$ClassVal_L:=PRV_ListTableValue(PRV_CLASSTABLETREE_txt; [Contract_Project_Maintenance:100]Classification_s:18)
		
		If ($ClassVal_L#[Contract_Project_Maintenance:100]ClassificationValue_L:19)
			[Contract_Project_Maintenance:100]ClassificationValue_L:19:=$ClassVal_L
		End if 
		
		$HwyEval_r:=([Contract_Project_Maintenance:100]ADTValue_L:15*PRV_ADTFactor_r)+([Contract_Project_Maintenance:100]DetourValue_L:17*PRV_DetourFactor_r)+([Contract_Project_Maintenance:100]ClassificationValue_L:19*PRV_ClassFactor_r)
		$HwyEval_r:=Round:C94($HwyEval_r; 2)
		If ($HwyEval_r#[Contract_Project_Maintenance:100]HWYEvalValue_r:20)
			[Contract_Project_Maintenance:100]HWYEvalValue_r:20:=$HwyEval_r
		End if 
		$EmerPts_L:=0
		$ActiveRRPts_L:=0
		$EvacPts_L:=0
		If ([Contract_Project_Maintenance:100]EmergRepl_b:21)
			$EmerPts_L:=PRV_EmergRepPoints_L
		End if 
		
		If ($EmerPts_L#[Contract_Project_Maintenance:100]EmergReplPts_L:22)
			[Contract_Project_Maintenance:100]EmergReplPts_L:22:=$EmerPts_L
		End if 
		
		If ([Contract_Project_Maintenance:100]ActiveRR_b:23)
			$ActiveRRPts_L:=PRV_ActiveRRPoints_L
		End if 
		
		If ($ActiveRRPts_L#[Contract_Project_Maintenance:100]ActiveRRPts_L:24)
			[Contract_Project_Maintenance:100]ActiveRRPts_L:24:=$ActiveRRPts_L
		End if 
		
		If ([Contract_Project_Maintenance:100]EvacRoute_b:25)
			$EvacPts_L:=PRV_EvacRoutePoints_L
		End if 
		
		If ($EvacPts_L#[Contract_Project_Maintenance:100]EvacRoutePts_L:26)
			[Contract_Project_Maintenance:100]EvacRoutePts_L:26:=$EvacPts_L
		End if 
		$OtherF_r:=([Contract_Project_Maintenance:100]EmergReplPts_L:22*PRV_EmergRepFactor_r)+([Contract_Project_Maintenance:100]ActiveRRPts_L:24*PRV_ActiveRRFactor_r)+([Contract_Project_Maintenance:100]EvacRoutePts_L:26*PRV_EvacRouteFactor_r)
		$OtherF_r:=Round:C94($OtherF_r; 2)
		If ($OtherF_r#[Contract_Project_Maintenance:100]OtherFactorsValue_r:27)
			[Contract_Project_Maintenance:100]OtherFactorsValue_r:27:=$OtherF_r
		End if 
		
		$PrelimValue_r:=([Contract_Project_Maintenance:100]HWYEvalValue_r:20*PRV_HWYEvalFactor_r)+([Contract_Project_Maintenance:100]OtherFactorsValue_r:27*PRV_OtherFactor_r)
		$PrelimValue_r:=Round:C94($PrelimValue_r; 2)
		If ($PrelimValue_r#[Contract_Project_Maintenance:100]PrelimDecisValue_r:28)
			[Contract_Project_Maintenance:100]PrelimDecisValue_r:28:=$PrelimValue_r
		End if 
		
		If ([Contract_Project_Maintenance:100]PrelimDecisValue_r:28<7)
			[Contract_Project_Maintenance:100]RecommConstr_txt:36:=PRV_ConsMethod1_txt
		Else 
			
			If ([Contract_Project_Maintenance:100]StagingAvail_b:29 & [Contract_Project_Maintenance:100]UtilRelocate_b:30 & [Contract_Project_Maintenance:100]BridgeClose_b:31 & Not:C34([Contract_Project_Maintenance:100]ABCOver30_b:32))
				[Contract_Project_Maintenance:100]RecommConstr_txt:36:=PRV_ConsMethod3_txt
			Else 
				If ([Contract_Project_Maintenance:100]PrefabDeliv_b:33 & [Contract_Project_Maintenance:100]PrefabJustif_b:34 & [Contract_Project_Maintenance:100]PrefabCostLess_b:35)
					[Contract_Project_Maintenance:100]RecommConstr_txt:36:=PRV_ConsMethod2_txt
				Else 
					[Contract_Project_Maintenance:100]RecommConstr_txt:36:=PRV_ConsMethod1_txt
				End if 
			End if 
			
		End if 
		
		PRV_RecommMethod_txt:=[Contract_Project_Maintenance:100]RecommConstr_txt:36
		
		PRV_Decision_FM($ShowTree_L)
		
	: ($FormEvent_L=$UpdateBINInfo_L)
		READ ONLY:C145([Bridge MHD NBIS:1])
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)
		If ([Contract_Project_Maintenance:100]ADT_L:14<=0)
			[Contract_Project_Maintenance:100]ADT_L:14:=[Bridge MHD NBIS:1]Item29:88
		End if 
		If ([Contract_Project_Maintenance:100]Detour_L:16<=0)
			[Contract_Project_Maintenance:100]Detour_L:16:=[Bridge MHD NBIS:1]Item19:91
		End if 
		If ([Contract_Project_Maintenance:100]Classification_s:18="")
			[Contract_Project_Maintenance:100]Classification_s:18:=[Bridge MHD NBIS:1]Item26:120
		End if 
	: ($FormEvent_L=$FieldsToVars)
		
		PRV_DEC_ADT_L:=[Contract_Project_Maintenance:100]ADT_L:14
		PRV_DEC_Detour_L:=[Contract_Project_Maintenance:100]Detour_L:16
		PRV_DEC_Classification_s:=[Contract_Project_Maintenance:100]Classification_s:18
		PRV_DEC_NeedSnowFence_b:=f_boolean2Num([Contract_Project_Maintenance:100]NeedSnowFence_b:37)
		PRV_DEC_StagingAvail_b:=f_boolean2Num([Contract_Project_Maintenance:100]StagingAvail_b:29)
		PRV_DEC_UtilRelocate_b:=f_boolean2Num([Contract_Project_Maintenance:100]UtilRelocate_b:30)
		PRV_DEC_BridgeClose_b:=f_boolean2Num([Contract_Project_Maintenance:100]BridgeClose_b:31)
		PRV_DEC_ABCOver30_b:=f_boolean2Num([Contract_Project_Maintenance:100]ABCOver30_b:32)
		PRV_DEC_PrefabDeliv_b:=f_boolean2Num([Contract_Project_Maintenance:100]PrefabDeliv_b:33)
		PRV_DEC_PrefabJustif_b:=f_boolean2Num([Contract_Project_Maintenance:100]PrefabJustif_b:34)
		PRV_DEC_PrefabCostLess_b:=f_boolean2Num([Contract_Project_Maintenance:100]PrefabCostLess_b:35)
		PRV_DEC_EmergRepl_b:=f_boolean2Num([Contract_Project_Maintenance:100]EmergRepl_b:21)
		PRV_DEC_ActiveRR_b:=f_boolean2Num([Contract_Project_Maintenance:100]ActiveRR_b:23)
		PRV_DEC_EvacRoute_b:=f_boolean2Num([Contract_Project_Maintenance:100]EvacRoute_b:25)
		
	: ($FormEvent_L=$VarsToFields_L)
		
		[Contract_Project_Maintenance:100]ADT_L:14:=PRV_DEC_ADT_L
		[Contract_Project_Maintenance:100]Detour_L:16:=PRV_DEC_Detour_L
		[Contract_Project_Maintenance:100]Classification_s:18:=PRV_DEC_Classification_s
		[Contract_Project_Maintenance:100]NeedSnowFence_b:37:=(PRV_DEC_NeedSnowFence_b=1)
		[Contract_Project_Maintenance:100]StagingAvail_b:29:=(PRV_DEC_StagingAvail_b=1)
		[Contract_Project_Maintenance:100]UtilRelocate_b:30:=(PRV_DEC_UtilRelocate_b=1)
		[Contract_Project_Maintenance:100]BridgeClose_b:31:=(PRV_DEC_BridgeClose_b=1)
		[Contract_Project_Maintenance:100]ABCOver30_b:32:=(PRV_DEC_ABCOver30_b=1)
		[Contract_Project_Maintenance:100]PrefabDeliv_b:33:=(PRV_DEC_PrefabDeliv_b=1)
		[Contract_Project_Maintenance:100]PrefabJustif_b:34:=(PRV_DEC_PrefabJustif_b=1)
		[Contract_Project_Maintenance:100]PrefabCostLess_b:35:=(PRV_DEC_PrefabCostLess_b=1)
		[Contract_Project_Maintenance:100]EmergRepl_b:21:=(PRV_DEC_EmergRepl_b=1)
		[Contract_Project_Maintenance:100]ActiveRR_b:23:=(PRV_DEC_ActiveRR_b=1)
		[Contract_Project_Maintenance:100]EvacRoute_b:25:=(PRV_DEC_EvacRoute_b=1)
		
End case 