//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/25/07, 20:55:16
	// ----------------------------------------------------
	// Method: PRJ_BPGM_ListDetailData
	// Description
	// Get the data for the list line display
	// 
	// Parameters
	// $1 : $GetConsName_b : Boolean
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/3/2007 08:16:10)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/13/08 09:19:35)
	Mods_2008_CM_5403
	//Added var PRJ_RatingDone_s
	Mods_2009_05  //r001  `05/08/09, 14:00:42  `Continue changes PRJ Design Contract Changes  
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//[PRJ_ProjectFile]DC_DesignContractID_l to [PRJ_ProjectDetails]DC_DesignContractID_l
	Mods_2009_06  //r002 `06/11/09, 13:27:25   `Merge PRJ Design Contract Changes
	// Modified by: costasmanousakis-(Designer)-(5/21/10 12:10:50)
	Mods_2010_05
	//  `Added var PRJ_BPGM_AdDate_d
	// Modified by: costasmanousakis-(Designer)-(8/31/11 16:14:04)
	Mods_2011_08
	//  `move assignmnet of PRJ_ConsultantName_txt
End if 
C_BOOLEAN:C305($1; $GetConsName_b)
If (Count parameters:C259>0)
	$GetConsName_b:=$1
Else 
	$GetConsName_b:=True:C214
End if 
C_TEXT:C284($ConsultantName_txt; $RoadwayOver_txt; $RoadwayUnder_txt)
C_DATE:C307($InitInsp_d)
C_BOOLEAN:C305($RatingDone_b)
C_TEXT:C284($DistrNo_S; $UnderConstr_S)  // Command Replaced was o_C_STRING length was 2
$RatingDone_b:=False:C215
$ConsultantName_txt:=""
PRJ_ConsultantName_txt:=$ConsultantName_txt

If ($GetConsName_b)
	PRJ_LoadDesignContractForOutput
End if 
$RatingDone_b:=False:C215
$InitInsp_d:=!00-00-00!
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
ARRAY TEXT:C222($BINS_aS; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $BINS_aS)
QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $BINS_aS)
ARRAY DATE:C224($Item90s_aD; 0)
ARRAY DATE:C224($RatingDates_aD; 0)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item90:161; $Item90s_aD)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]DateRatReport:205; $RatingDates_aD)
SORT ARRAY:C229($Item90s_aD; <)
SORT ARRAY:C229($RatingDates_aD; <)
If (Size of array:C274($RatingDates_aD)>0)
Else 
	ARRAY DATE:C224($Item90s_aD; 1)
	ARRAY DATE:C224($RatingDates_aD; 1)
End if 
QUERY WITH ARRAY:C644([Inspections:27]BIN:1; $BINS_aS)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InitialInsp:9=True:C214)
ARRAY DATE:C224($InspDates_ad; 0)
SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $InspDates_ad)
SORT ARRAY:C229($InspDates_ad; <)
If (Size of array:C274($InspDates_ad)>0)
Else 
	ARRAY DATE:C224($InspDates_ad; 1)
End if 

C_DATE:C307($dateAwarded_D)
$dateAwarded_D:=[PRJ_ConstructionProject:116]CP_Awarded_d:4
If ($dateAwarded_D#!00-00-00!)
	$UnderConstr_S:="U"
	If ($InspDates_ad{1}>$dateAwarded_D)
		$InitInsp_d:=$InspDates_ad{1}
		$UnderConstr_S:="F"
	End if 
	If ($RatingDates_aD{1}>$dateAwarded_D)
		$RatingDone_b:=True:C214
	End if 
Else 
	$UnderConstr_S:="N"
End if 
If (([PRJ_ProjectDetails:115]PRJ_Completion_d:37<Current date:C33(*)) & ([PRJ_ProjectDetails:115]PRJ_Completion_d:37#!00-00-00!))
	If ($UnderConstr_S#"F")
		$UnderConstr_S:="P"
	End if 
Else 
End if 
If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
Else 
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
End if 
If (Records in selection:C76([Bridge MHD NBIS:1])>0)
	$RoadwayOver_txt:=[Bridge MHD NBIS:1]Item7:65
	$RoadwayUnder_txt:=[Bridge MHD NBIS:1]Item6A:63
	$DistrNo_S:=[Bridge MHD NBIS:1]Item2:60
Else 
	$DistrNo_S:="?"
	$RoadwayOver_txt:="????"
	$RoadwayUnder_txt:="????"
End if 
//============================================================

PRJ_RoadwayOver_txt:=$RoadwayOver_txt
PRJ_RoadwayUnder_txt:=$RoadwayUnder_txt
PRJ_DistrNo_txt:=$DistrNo_S
PRJ_InitInsp_D:=$InitInsp_d
PRJ_RatingDone_b:=$RatingDone_b
PRJ_RatingDone_s:=f_Boolean2String($RatingDone_b; "YN")
PRJ_UnderConstr_txt:=$UnderConstr_S
C_DATE:C307(PRJ_BPGM_AdDate_d)
If ([PRJ_ProjectFile:117]PF_Advertised_d:14=!00-00-00!)
	PRJ_BPGM_AdDate_d:=[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5
Else 
	If ([PRJ_ProjectFile:117]PF_Advertised_d:14<[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5)
		PRJ_BPGM_AdDate_d:=[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5
	Else 
		PRJ_BPGM_AdDate_d:=[PRJ_ProjectFile:117]PF_Advertised_d:14
	End if 
End if 
