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
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($i; $numRecs; $k; $j; $l; $duration)
$numRecs:=Records in selection:C76([PRJ_ProjectDetails:115])
ARRAY TEXT:C222(PRJ_RWYOver_atxt; 0)
ARRAY TEXT:C222(PRJ_RWYUnder_atxt; 0)
ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
ARRAY TEXT:C222(PRJ_DistrNo_aS; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(PRJ_UnderConstr_aS; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY LONGINT:C221(PRJ_BPGM_RecNumbers_aL; 0)
ARRAY DATE:C224(PRJ_InitInsp_aD; 0)
ARRAY BOOLEAN:C223(PRJ_RatingDone_ab; 0)

ARRAY TEXT:C222(PRJ_RWYOver_atxt; $numRecs)
ARRAY TEXT:C222(PRJ_RWYUnder_atxt; $numRecs)
ARRAY TEXT:C222(PRJ_ConsName_atxt; $numRecs)
ARRAY TEXT:C222(PRJ_DistrNo_aS; $numRecs)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(PRJ_UnderConstr_aS; $numRecs)  //Command Replaced was o_ARRAY string length was 2
ARRAY LONGINT:C221(PRJ_BPGM_RecNumbers_aL; $numRecs)
ARRAY DATE:C224(PRJ_InitInsp_aD; $numRecs)
ARRAY BOOLEAN:C223(PRJ_RatingDone_ab; $numRecs)

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
SHORT_MESSAGE("Please Wait..")
ARRAY REAL:C219($TickCount_ar; 20)
C_LONGINT:C283($Tcounter)
$Tcounter:=0
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsName_atxt; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $PRJBrNos_atxt; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34; $PRJBINs_as; [PRJ_ConstructionProject:116]CP_Awarded_d:4; $AwardDate_ad; [PRJ_ProjectDetails:115]PRJ_Completion_d:37; $CompleteDate_ad; [PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $PRJIDs_aL)
RELATE MANY SELECTION:C340([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1)

$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458
For ($i; 1; Size of array:C274($PRJBrNos_atxt))
	$PRJBrNos_atxt{$i}:=Substring:C12($PRJBrNos_atxt{$i}; 1; 6)
End for 
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458

SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; $PRJIDsIncl_aL; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $InclBIN_as)
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458

QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $InclBIN_as)

SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BrBINs_as; [Bridge MHD NBIS:1]DateRatReport:205; $BRRtg_ad; [Bridge MHD NBIS:1]Item90:161; $BTI90_ad)
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458

QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $PRJBINs_as)

SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BrPrimBINs_as; [Bridge MHD NBIS:1]Item6A:63; $BRBINIT6A_as; [Bridge MHD NBIS:1]Item7:65; $BRBINIT7_as; [Bridge MHD NBIS:1]Item2:60; $BRBINIT2_as)
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458

QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; $PRJBrNos_atxt)

SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BDEPT:1; $BDEPTS_as; [Bridge MHD NBIS:1]Item6A:63; $BRBDIT6A_as; [Bridge MHD NBIS:1]Item7:65; $BRBDIT7_as; [Bridge MHD NBIS:1]Item2:60; $BRBDIT2_as)
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458

QUERY WITH ARRAY:C644([Inspections:27]BIN:1; $InclBIN_as)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InitialInsp:9=True:C214)
SELECTION TO ARRAY:C260([Inspections:27]BIN:1; $InspBins_as; [Inspections:27]Insp Date:78; $InspIniDate_ad)
SORT ARRAY:C229($InspBins_as; $InspIniDate_ad)
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458

For ($i; 1; $numRecs)
	ARRAY TEXT:C222($CurrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY DATE:C224($CurrRtgs_ad; 1)
	ARRAY DATE:C224($CurrIT90s_ad; 1)
	ARRAY DATE:C224($CurrIniInsp_ad; 1)
	$CurrRtgs_ad{1}:=!00-00-00!
	$CurrIT90s_ad{1}:=!00-00-00!
	$CurrIniInsp_ad{1}:=!00-00-00!
	$k:=Find in array:C230($PRJIDsIncl_aL; $PRJIDs_aL{$i})
	If ($k>0)
		ARRAY TEXT:C222($CurrBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
		Repeat 
			INSERT IN ARRAY:C227($CurrBINs_as; 1)
			$CurrBINs_as{1}:=$InclBIN_as{$k}
			$k:=Find in array:C230($PRJIDsIncl_aL; $PRJIDs_aL{$i}; ($k+1))
		Until ($k<=0)
		ARRAY DATE:C224($CurrRtgs_ad; Size of array:C274($CurrBINs_as))
		ARRAY DATE:C224($CurrIT90s_ad; Size of array:C274($CurrBINs_as))
		ARRAY DATE:C224($CurrIniInsp_ad; Size of array:C274($CurrBINs_as))
		For ($l; 1; Size of array:C274($CurrBINs_as))
			$j:=Find in array:C230($BrBINs_as; $CurrBINs_as{$l})
			If ($j>0)
				$CurrRtgs_ad{$l}:=$BRRtg_ad{$j}
				$CurrIT90s_ad{$l}:=$BTI90_ad{$j}
			End if 
			$j:=Find in array:C230($InspBins_as; $CurrBINs_as{$l})
			If ($j>0)
				$CurrIniInsp_ad{$l}:=$InspIniDate_ad{$j}
			End if 
			
		End for 
		SORT ARRAY:C229($CurrRtgs_ad; <)
		SORT ARRAY:C229($CurrIT90s_ad; <)
		SORT ARRAY:C229($CurrIniInsp_ad; <)
		
	End if 
	If ($AwardDate_ad{$i}#!00-00-00!)
		PRJ_UnderConstr_aS{$i}:="U"
		If ($AwardDate_ad{$i}<$CurrIniInsp_ad{1})
			PRJ_InitInsp_aD{$i}:=$CurrIniInsp_ad{1}
			PRJ_UnderConstr_aS{$i}:="F"
		Else 
			
		End if 
		If ($CurrRtgs_ad{1}>$AwardDate_ad{$i})
			PRJ_RatingDone_ab{$i}:=True:C214
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
$Tcounter:=$Tcounter+1
$TickCount_ar{$Tcounter}:=Tickcount:C458
CLOSE WINDOW:C154
$duration:=$TickCount_ar{$Tcounter}-$TickCount_ar{1}
For ($i; 1; (Size of array:C274($TickCount_ar)-1))
	If ($TickCount_ar{$i+1}>0)
		$TickCount_ar{$i}:=$TickCount_ar{$i+1}-$TickCount_ar{$i}
	End if 
End for 

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

//ALERT("Duration :"+String($duration))