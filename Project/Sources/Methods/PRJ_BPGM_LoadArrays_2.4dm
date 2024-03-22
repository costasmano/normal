//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/07, 14:36:05
	// ----------------------------------------------------
	// Method: PRJ_BPGM_LoadArrays_2
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/3/2007 08:14:07)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/13/08 08:07:20)
	Mods_2008_CM_5403
	//  `use new methodology where arrays are loaded only when needed for sorting
	// Modified by: costasmanousakis-(Designer)-(5/21/10 11:33:01)
	Mods_2010_05
	//  `Added array PRJ_BPGMAdDate_aD
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_BOOLEAN:C305($initArrays_b)
If (Count parameters:C259=1)
	C_POINTER:C301($1; $NeedArray_ptr)
	$NeedArray_ptr:=$1
	$initArrays_b:=False:C215
Else 
	$initArrays_b:=True:C214
End if 

C_LONGINT:C283($i; $numRecs; $k; $j; $l)
$numRecs:=Records in selection:C76([PRJ_ProjectDetails:115])
If ($initArrays_b)
	
	ARRAY TEXT:C222(PRJ_RWYOver_atxt; 0)
	ARRAY TEXT:C222(PRJ_RWYUnder_atxt; 0)
	ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
	ARRAY TEXT:C222(PRJ_DistrNo_aS; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(PRJ_UnderConstr_aS; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY LONGINT:C221(PRJ_BPGM_RecNumbers_aL; 0)
	ARRAY DATE:C224(PRJ_InitInsp_aD; 0)
	ARRAY DATE:C224(PRJ_BPGMAdDate_aD; 0)  //Actual or Sched Ad Date
	ARRAY BOOLEAN:C223(PRJ_RatingDone_ab; 0)
	
Else 
	ARRAY TEXT:C222(PRJ_RWYOver_atxt; $numRecs)
	ARRAY TEXT:C222(PRJ_RWYUnder_atxt; $numRecs)
	ARRAY TEXT:C222(PRJ_ConsName_atxt; $numRecs)
	ARRAY TEXT:C222(PRJ_DistrNo_aS; $numRecs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(PRJ_UnderConstr_aS; $numRecs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY LONGINT:C221(PRJ_BPGM_RecNumbers_aL; $numRecs)
	ARRAY DATE:C224(PRJ_InitInsp_aD; $numRecs)
	ARRAY DATE:C224(PRJ_BPGMAdDate_aD; $numRecs)  //Actual or Sched Ad Date
	ARRAY BOOLEAN:C223(PRJ_RatingDone_ab; $numRecs)
	
	ARRAY TEXT:C222($PRJBrNos_atxt; $numRecs)
	ARRAY TEXT:C222($PRJBINs_as; $numRecs)
	ARRAY DATE:C224($AwardDate_ad; 0)
	ARRAY DATE:C224($CompleteDate_ad; 0)
	ARRAY LONGINT:C221($PRJIDs_aL; 0)
	ARRAY LONGINT:C221($PRJIDsIncl_aL; 0)
	ARRAY TEXT:C222($InclBIN_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($BrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY DATE:C224($BRRtg_ad; 0)
	ARRAY DATE:C224($BTI90_ad; 0)
	ARRAY TEXT:C222($BrPrimBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($BRBINIT6A_as; 0)  //Command Replaced was o_ARRAY string length was 24
	ARRAY TEXT:C222($BRBDIT6A_as; 0)  //Command Replaced was o_ARRAY string length was 24
	ARRAY TEXT:C222($BRBINIT7_as; 0)  //Command Replaced was o_ARRAY string length was 18
	ARRAY TEXT:C222($BRBDIT7_as; 0)  //Command Replaced was o_ARRAY string length was 18
	ARRAY TEXT:C222($BRBINIT2_as; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($BRBDIT2_as; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($BDEPTS_as; 0)  //Command Replaced was o_ARRAY string length was 6
	Case of 
		: (($NeedArray_ptr=(->PRJ_RWYOver_atxt)) | ($NeedArray_ptr=(->PRJ_DistrNo_aS)) | ($NeedArray_ptr=(->PRJ_RWYUnder_atxt)))  //Need RDY under `Need RDY over
			SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34; $PRJBINs_as; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $PRJBrNos_atxt)
			For ($i; 1; Size of array:C274($PRJBrNos_atxt))
				$PRJBrNos_atxt{$i}:=Substring:C12($PRJBrNos_atxt{$i}; 1; 6)
			End for 
			QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $PRJBINs_as)
			
			SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BrPrimBINs_as; [Bridge MHD NBIS:1]Item6A:63; $BRBINIT6A_as; [Bridge MHD NBIS:1]Item7:65; $BRBINIT7_as; [Bridge MHD NBIS:1]Item2:60; $BRBINIT2_as)
			QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; $PRJBrNos_atxt)
			
			SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BDEPT:1; $BDEPTS_as; [Bridge MHD NBIS:1]Item6A:63; $BRBDIT6A_as; [Bridge MHD NBIS:1]Item7:65; $BRBDIT7_as; [Bridge MHD NBIS:1]Item2:60; $BRBDIT2_as)
			For ($i; 1; $numRecs)
				$k:=Find in array:C230($BrPrimBINs_as; $PRJBINs_as{$i})
				If ($k>0)
					PRJ_RWYOver_atxt{$i}:=$BRBINIT7_as{$k}
					PRJ_RWYUnder_atxt{$i}:=$BRBINIT6A_as{$k}
					PRJ_DistrNo_aS{$i}:=$BRBINIT2_as{$k}
				Else 
					$k:=Find in array:C230($BDEPTS_as; $PRJBrNos_atxt{$i})
					If ($k>0)
						PRJ_RWYOver_atxt{$i}:=$BRBDIT7_as{$k}
						PRJ_RWYUnder_atxt{$i}:=$BRBDIT6A_as{$k}
						PRJ_DistrNo_aS{$i}:=$BRBDIT2_as{$k}
					Else 
						PRJ_RWYOver_atxt{$i}:="???"
						PRJ_RWYUnder_atxt{$i}:="???"
						PRJ_DistrNo_aS{$i}:="??"
					End if 
				End if 
				
			End for 
			
			
		: ($NeedArray_ptr=(->PRJ_ConsName_atxt))  //Need consultant
			SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsName_atxt)
		: ($NeedArray_ptr=(->PRJ_UnderConstr_aS))  //Need under constr
			SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34; $PRJBINs_as; [PRJ_ConstructionProject:116]CP_Awarded_d:4; $AwardDate_ad; [PRJ_ProjectDetails:115]PRJ_Completion_d:37; $CompleteDate_ad; [PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $PRJIDs_aL)
			For ($i; 1; Size of array:C274($PRJBrNos_atxt))
				$PRJBrNos_atxt{$i}:=Substring:C12($PRJBrNos_atxt{$i}; 1; 6)
			End for 
			RELATE MANY SELECTION:C340([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1)
			SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; $PRJIDsIncl_aL; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $InclBIN_as)
			QUERY WITH ARRAY:C644([Inspections:27]BIN:1; $InclBIN_as)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InitialInsp:9=True:C214)
			SELECTION TO ARRAY:C260([Inspections:27]BIN:1; $InspBins_as; [Inspections:27]Insp Date:78; $InspIniDate_ad)
			SORT ARRAY:C229($InspBins_as; $InspIniDate_ad)
			
			For ($i; 1; $numRecs)
				ARRAY TEXT:C222($CurrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
				ARRAY DATE:C224($CurrIniInsp_ad; 1)
				$CurrIniInsp_ad{1}:=!00-00-00!
				$k:=Find in array:C230($PRJIDsIncl_aL; $PRJIDs_aL{$i})
				If ($k>0)
					ARRAY TEXT:C222($CurrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
					Repeat 
						INSERT IN ARRAY:C227($CurrBINs_as; 1)
						$CurrBINs_as{1}:=$InclBIN_as{$k}
						$k:=Find in array:C230($PRJIDsIncl_aL; $PRJIDs_aL{$i}; ($k+1))
					Until ($k<=0)
					ARRAY DATE:C224($CurrIniInsp_ad; Size of array:C274($CurrBINs_as))
					For ($l; 1; Size of array:C274($CurrBINs_as))
						$j:=Find in array:C230($InspBins_as; $CurrBINs_as{$l})
						If ($j>0)
							$CurrIniInsp_ad{$l}:=$InspIniDate_ad{$j}
						End if 
					End for 
					SORT ARRAY:C229($CurrIniInsp_ad; <)
					
				End if 
				If ($AwardDate_ad{$i}#!00-00-00!)
					PRJ_UnderConstr_aS{$i}:="U"
					If ($AwardDate_ad{$i}<$CurrIniInsp_ad{1})
						PRJ_UnderConstr_aS{$i}:="F"
					Else 
						
					End if 
				Else 
					PRJ_UnderConstr_aS{$i}:="N"
				End if 
				If (($CompleteDate_ad{$i}<Current date:C33(*)) & ($CompleteDate_ad{$i}#!00-00-00!))
					If (PRJ_UnderConstr_aS{$i}#"F")
						PRJ_UnderConstr_aS{$i}:="P"
					End if 
				Else 
				End if 
				
			End for 
			
		: ($NeedArray_ptr=(->PRJ_InitInsp_aD))  //Need init insp date
			SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; [PRJ_ConstructionProject:116]CP_Awarded_d:4; $AwardDate_ad; [PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $PRJIDs_aL)
			RELATE MANY SELECTION:C340([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1)
			SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; $PRJIDsIncl_aL; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $InclBIN_as)
			QUERY WITH ARRAY:C644([Inspections:27]BIN:1; $InclBIN_as)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InitialInsp:9=True:C214)
			SELECTION TO ARRAY:C260([Inspections:27]BIN:1; $InspBins_as; [Inspections:27]Insp Date:78; $InspIniDate_ad)
			SORT ARRAY:C229($InspBins_as; $InspIniDate_ad)
			For ($i; 1; $numRecs)
				ARRAY TEXT:C222($CurrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
				ARRAY DATE:C224($CurrIniInsp_ad; 1)
				$CurrIniInsp_ad{1}:=!00-00-00!
				$k:=Find in array:C230($PRJIDsIncl_aL; $PRJIDs_aL{$i})
				If ($k>0)
					ARRAY TEXT:C222($CurrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
					Repeat 
						INSERT IN ARRAY:C227($CurrBINs_as; 1)
						$CurrBINs_as{1}:=$InclBIN_as{$k}
						$k:=Find in array:C230($PRJIDsIncl_aL; $PRJIDs_aL{$i}; ($k+1))
					Until ($k<=0)
					ARRAY DATE:C224($CurrIniInsp_ad; Size of array:C274($CurrBINs_as))
					For ($l; 1; Size of array:C274($CurrBINs_as))
						$j:=Find in array:C230($InspBins_as; $CurrBINs_as{$l})
						If ($j>0)
							$CurrIniInsp_ad{$l}:=$InspIniDate_ad{$j}
						End if 
					End for 
					SORT ARRAY:C229($CurrIniInsp_ad; <)
				End if 
				If ($AwardDate_ad{$i}#!00-00-00!)
					If ($AwardDate_ad{$i}<$CurrIniInsp_ad{1})
						PRJ_InitInsp_aD{$i}:=$CurrIniInsp_ad{1}
					Else 
						
					End if 
				Else 
				End if 
			End for 
			
		: ($NeedArray_ptr=(->PRJ_BPGMAdDate_aD))  //Need init insp date
			ARRAY DATE:C224($PrjSchedAd_ad; $numRecs)
			ARRAY DATE:C224($PrjActAd_ad; $numRecs)
			SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; [PRJ_ProjectFile:117]PF_Advertised_d:14; $PrjActAd_ad; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; $PrjSchedAd_ad)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(PRJ_BPGMAdDate_aD))
				If ($PrjActAd_ad{$loop_L}=!00-00-00!)
					PRJ_BPGMAdDate_aD{$loop_L}:=$PrjSchedAd_ad{$loop_L}
				Else 
					If ($PrjActAd_ad{$loop_L}<$PrjSchedAd_ad{$loop_L})
						PRJ_BPGMAdDate_aD{$loop_L}:=$PrjSchedAd_ad{$loop_L}
					Else 
						PRJ_BPGMAdDate_aD{$loop_L}:=$PrjActAd_ad{$loop_L}
					End if 
				End if 
			End for 
			ARRAY DATE:C224($PrjSchedAd_ad; 0)
			ARRAY DATE:C224($PrjActAd_ad; 0)
			
	End case 
	
	ARRAY TEXT:C222($PRJBrNos_atxt; 0)
	ARRAY TEXT:C222($PRJBINs_as; 0)
	ARRAY DATE:C224($AwardDate_ad; 0)
	ARRAY DATE:C224($CompleteDate_ad; 0)
	ARRAY LONGINT:C221($PRJIDs_aL; 0)
	ARRAY LONGINT:C221($PRJIDsIncl_aL; 0)
	ARRAY TEXT:C222($InclBIN_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($BrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY DATE:C224($BRRtg_ad; 0)
	ARRAY DATE:C224($BTI90_ad; 0)
	ARRAY TEXT:C222($BrPrimBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($BRBINIT6A_as; 0)  //Command Replaced was o_ARRAY string length was 24
	ARRAY TEXT:C222($BRBDIT6A_as; 0)  //Command Replaced was o_ARRAY string length was 24
	ARRAY TEXT:C222($BRBINIT7_as; 0)  //Command Replaced was o_ARRAY string length was 18
	ARRAY TEXT:C222($BRBDIT7_as; 0)  //Command Replaced was o_ARRAY string length was 18
	ARRAY TEXT:C222($BRBINIT2_as; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($BRBDIT2_as; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($BDEPTS_as; 0)  //Command Replaced was o_ARRAY string length was 6
End if 

//ALERT("Duration :"+String($duration))