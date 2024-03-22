//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/05/07, 11:51:01
	// ----------------------------------------------------
	// Method: PRJ_BPGM_LoadArrays
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (False:C215)
	C_LONGINT:C283($i; $numRecs; $startTick; $Duration; $EndTick)
	$numRecs:=Records in selection:C76([PRJ_ProjectDetails:115])
	ARRAY TEXT:C222(PRJ_RWYOver_atxt; $numRecs)
	ARRAY TEXT:C222(PRJ_RWYUnder_atxt; $numRecs)
	ARRAY TEXT:C222(PRJ_ConsName_atxt; $numRecs)
	ARRAY TEXT:C222(PRJ_DistrNo_aS; $numRecs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(PRJ_UnderConstr_aS; $numRecs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY LONGINT:C221(PRJ_BPGM_RecNumbers_aL; $numRecs)
	ARRAY DATE:C224(PRJ_InitInsp_aD; $numRecs)
	ARRAY DATE:C224(PRJ_BPGMAdDate_aD; $numRecs)  //Actual or Sched Ad Date
	ARRAY BOOLEAN:C223(PRJ_RatingDone_ab; $numRecs)
	
	C_TEXT:C284($ConsultantName_txt; $RoadwayOver_txt; $RoadwayUnder_txt)
	C_DATE:C307($InitInsp_d)
	C_BOOLEAN:C305($RatingDone_b)
	C_TEXT:C284($DistrNo_S; $UnderConstr_S)  // Command Replaced was o_C_STRING length was 2
	//CONFIRM("Long ?";"Long";"Short")
	PRJ_BPGM_LongWay_b:=False:C215
	SHORT_MESSAGE("Please wait...")
	$startTick:=Tickcount:C458
	If (PRJ_BPGM_LongWay_b)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL)
	Else 
		SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsName_atxt)
	End if 
	If (True:C214)
		
		FIRST RECORD:C50([PRJ_ProjectDetails:115])
		For ($i; 1; $numRecs)
			//in list  the parent seems that it does not get loaded automatically.
			QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1=[PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2)
			PRJ_BPGM_ListDetailData(False:C215)  //don't ask for cons name
			
			If (PRJ_BPGM_LongWay_b)
				PRJ_ConsName_atxt{$i}:=PRJ_ConsultantName_txt
			End if 
			PRJ_RWYOver_atxt{$i}:=PRJ_RoadwayOver_txt
			PRJ_RWYUnder_atxt{$i}:=PRJ_RoadwayUnder_txt
			PRJ_DistrNo_aS{$i}:=PRJ_DistrNo_txt
			PRJ_InitInsp_aD{$i}:=PRJ_InitInsp_D
			PRJ_RatingDone_ab{$i}:=PRJ_RatingDone_b
			PRJ_UnderConstr_aS{$i}:=PRJ_UnderConstr_txt
			
			NEXT RECORD:C51([PRJ_ProjectDetails:115])
		End for 
		
	End if 
	$EndTick:=Tickcount:C458
	CLOSE WINDOW:C154
	$Duration:=$EndTick-$StartTick
	//ALERT("Duration = "+String($Duration))
	
End if 
PRJ_BPGM_LoadArrays_2