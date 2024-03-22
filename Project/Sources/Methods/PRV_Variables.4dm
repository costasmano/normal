//%attributes = {"invisible":true}
//Method: PRV_Variables
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/12, 08:01:54
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	
End if 

C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
C_LONGINT:C283($NumReviews_L)

Case of 
	: ($Task_txt="COMPILER")
		COMPILER_Preservation
		
	: ($Task_txt="INIT")
		
		If (Not:C34(Is compiled mode:C492))
			COMPILER_Preservation
		End if 
		
		PRV_BDEPT_txt:=""
		PRV_Dist_txt:=""
		PRV_BIN_txt:=""
		PRV_Item8_txt:=""
		PRV_Town_txt:=""
		PRV_AASHTO_txt:=""
		PRV_OverUnder_txt:=""
		PRV_SD_txt:=""
		PRV_FO_txt:=""
		PRV_OnOff_txt:=""
		
		PRV_ProjMgr_txt:=""
		PRV_ROWCertYN_txt:=""
		PRV_EnvClrYN_txt:=""
		PRV_TMPApprYN_txt:=""
		PRV_UtilitiesYN_txt:=""
		PRV_ConstructionYN_txt:=""
		PRV_First25SubDate_d:=!00-00-00!
		PRV_StructApproval25_d:=!00-00-00!
		PRV_HwyApproval25_d:=!00-00-00!
		PRV_First90SubDate_d:=!00-00-00!
		PRV_StructApproval90_d:=!00-00-00!
		PRV_HWYApproval75_d:=!00-00-00!
		PRV_FinalPSESubDate_d:=!00-00-00!
		PRV_FinalPSEApprove_d:=!00-00-00!
		PRV_25SubAppr_d:=!00-00-00!
		PRV_90SubAppr_d:=!00-00-00!
		
		PRV_ProjDescr_txt:=""
		PRV_PNFDate_d:=!00-00-00!
		PRV_PIFDate_d:=!00-00-00!
		PRV_PRCApprovalDate_d:=!00-00-00!
		PRV_PRCSubmitDate_d:=!00-00-00!
		PRV_PNFEvent_txt:=""
		PRV_PIFEvent_txt:=""
		PRV_SchedAdDate_d:=!00-00-00!
		PRV_ActualAdDate_d:=!00-00-00!
		PRV_BidOpeningSched_d:=!00-00-00!
		PRV_BidOpeningAct_d:=!00-00-00!
		PRV_BidAmmount_r:=0
		PRV_AwardDate_d:=!00-00-00!
		PRV_ConstrContr_txt:=""
		PRV_ConstrContractor_txt:=""
		
		PRV_Consultant_txt:=""
		PRV_ConsultantPM_txt:=""
		
		//If (False)
		//ARRAY TEXT(PRV_REVIEWTYPEDESC_ATXT;Size of array($ValuePairs_atxt))
		//ARRAY TEXT(PRV_REVIEWTYPECODE_ATXT;Size of array($ValuePairs_atxt))
		//C_LONGINT($loop_L;$Delim_k)
		//For ($loop_L;1;Size of array($ValuePairs_atxt))
		//$Delim_k:=Position(";";$ValuePairs_atxt{$loop_L})
		//PRV_REVIEWTYPECODE_ATXT{$loop_L}:=Substring($ValuePairs_atxt{$loop_L};1;($Delim_k-1))
		//PRV_REVIEWTYPEDESC_ATXT{$loop_L}:=Substring($ValuePairs_atxt{$loop_L};($Delim_k+1))
		//End for 
		//
		//End if 
		
		PRV_OrigCostTotal_r:=0
		
		PRV_ActCostHRS_r:=0
		PRV_ActCostTLF_r:=0
		PRV_ActCostDC_r:=0
		PRV_ActCostSum_r:=0
		
		PRV_Balance_HRS_r:=0
		PRV_Balance_TLF_r:=0
		PRV_Balance_DC_r:=0
		PRV_Balance_Sum_r:=0
		
		PRV_Addend_HRS_r:=0
		PRV_Addend_TLF_r:=0
		PRV_Addend_DC_r:=0
		
		PRV_ApprTotal_HRS_r:=0
		PRV_ApprTotal_TLF_r:=0
		PRV_ApprTotal_DC_r:=0
		PRV_ApprTotal_Sum_r:=0
		
	: ($Task_txt="LOADGLOBAL")
		
		C_TEXT:C284($paramValue_txt; $elemeRef_txt; $DomTree_txt)
		$paramValue_txt:=ut_GetSysParameter("PRV_REVIEWTYPEDESCXM")
		PRV_REVIEWTYPESTREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
		$paramValue_txt:=ut_GetSysParameter("PRV_ADTTable")
		PRV_ADTTABLETREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
		$paramValue_txt:=ut_GetSysParameter("PRV_DetourTable")
		PRV_DETOURTABLETREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
		$paramValue_txt:=ut_GetSysParameter("PRV_ClassTable")
		PRV_CLASSTABLETREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
		$paramValue_txt:=ut_GetSysParameter("PRV_FormulaFactors")
		$DomTree_txt:=DOM Parse XML variable:C720($paramValue_txt)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "ADTFactor"; 1; PRV_ADTFactor_r)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "DetourFactor"; 1; PRV_DetourFactor_r)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "ClassFactor"; 1; PRV_ClassFactor_r)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "EmergReplPoints"; 1; PRV_EmergRepPoints_L)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "ActiveRRPoints"; 1; PRV_ActiveRRPoints_L)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "EvacRoutePoints"; 1; PRV_EvacRoutePoints_L)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "EmergReplFactor"; 1; PRV_EmergRepFactor_r)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "ActiveRRFactor"; 1; PRV_ActiveRRFactor_r)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "EvacRouteFactor"; 1; PRV_EvacRouteFactor_r)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "HWYEvalFactor"; 1; PRV_HWYEvalFactor_r)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "OtherFactor"; 1; PRV_OtherFactor_r)
		DOM CLOSE XML:C722($DomTree_txt)
		
		$paramValue_txt:=ut_GetSysParameter("PRV_Recommend")
		$DomTree_txt:=DOM Parse XML variable:C720($paramValue_txt)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "Choise"; 1; PRV_ConsMethod1_txt)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "Choise"; 2; PRV_ConsMethod2_txt)
		$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "Choise"; 3; PRV_ConsMethod3_txt)
		DOM CLOSE XML:C722($DomTree_txt)
		
		ARRAY TEXT:C222(PRV_ProjectStatus_atxt; 0)
		$paramValue_txt:=ut_GetSysParameter("PRV_ProjectStatus")
		$DomTree_txt:=DOM Parse XML variable:C720($paramValue_txt)
		C_LONGINT:C283($numColors_L; $Loop_L; $AttrValue_L)
		C_TEXT:C284($elemValue_txt; $AttrVal_txt)
		$numColors_L:=DOM Count XML elements:C726($DomTree_txt; "Status")
		For ($Loop_L; 1; $numColors_L)
			$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "Status"; $Loop_L; $elemValue_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elemeRef_txt; "Name"; $AttrVal_txt)
			APPEND TO ARRAY:C911(PRV_ProjectStatus_atxt; $AttrVal_txt)
		End for 
		
		DOM CLOSE XML:C722($DomTree_txt)
		
		ARRAY TEXT:C222(PRV_PreservationTypes_atxt; 0)
		$paramValue_txt:=ut_GetSysParameter("PRV_PreservationType")
		$DomTree_txt:=DOM Parse XML variable:C720($paramValue_txt)
		C_LONGINT:C283($numColors_L; $Loop_L; $AttrValue_L)
		C_TEXT:C284($elemValue_txt; $AttrVal_txt)
		$numColors_L:=DOM Count XML elements:C726($DomTree_txt; "PreservType")
		For ($Loop_L; 1; $numColors_L)
			$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "PreservType"; $Loop_L; $elemValue_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elemeRef_txt; "Name"; $AttrVal_txt)
			APPEND TO ARRAY:C911(PRV_PreservationTypes_atxt; $AttrVal_txt)
		End for 
		
		DOM CLOSE XML:C722($DomTree_txt)
		
		ARRAY TEXT:C222(PRV_Fundings_atxt; 0)
		$paramValue_txt:=ut_GetSysParameter("PRV_Fundings")
		$DomTree_txt:=DOM Parse XML variable:C720($paramValue_txt)
		C_LONGINT:C283($numColors_L; $Loop_L; $AttrValue_L)
		C_TEXT:C284($elemValue_txt; $AttrVal_txt)
		$numColors_L:=DOM Count XML elements:C726($DomTree_txt; "Fundings")
		For ($Loop_L; 1; $numColors_L)
			$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "Fundings"; $Loop_L; $elemValue_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elemeRef_txt; "Name"; $AttrVal_txt)
			APPEND TO ARRAY:C911(PRV_Fundings_atxt; $AttrVal_txt)
		End for 
		
		DOM CLOSE XML:C722($DomTree_txt)
		
		ARRAY TEXT:C222(PRV_LateAction_atxt; 0)
		$paramValue_txt:=ut_GetSysParameter("PRV_LateActions")
		$DomTree_txt:=DOM Parse XML variable:C720($paramValue_txt)
		C_LONGINT:C283($numColors_L; $Loop_L; $AttrValue_L)
		C_TEXT:C284($elemValue_txt; $AttrVal_txt)
		$numColors_L:=DOM Count XML elements:C726($DomTree_txt; "Action")
		For ($Loop_L; 1; $numColors_L)
			$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "Action"; $Loop_L; $elemValue_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elemeRef_txt; "Name"; $AttrVal_txt)
			APPEND TO ARRAY:C911(PRV_LateAction_atxt; $AttrVal_txt)
		End for 
		
		DOM CLOSE XML:C722($DomTree_txt)
		
		ARRAY TEXT:C222(PRV_ProjectColors_atxt; 0)
		ARRAY LONGINT:C221(PRV_ProjectColors_aL; 0)
		PRV_ColorMenuPopup_txt:="Change Color...<I;(-"
		$paramValue_txt:=ut_GetSysParameter("PRV_AssignColors")
		$DomTree_txt:=DOM Parse XML variable:C720($paramValue_txt)
		$numColors_L:=DOM Count XML elements:C726($DomTree_txt; "Color")
		For ($Loop_L; 1; $numColors_L)
			$elemeRef_txt:=DOM Get XML element:C725($DomTree_txt; "Color"; $Loop_L; $elemValue_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elemeRef_txt; "Name"; $AttrVal_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elemeRef_txt; "Value"; $AttrValue_L)
			APPEND TO ARRAY:C911(PRV_ProjectColors_atxt; $AttrVal_txt)
			PRV_ColorMenuPopup_txt:=PRV_ColorMenuPopup_txt+";"+$AttrVal_txt
			APPEND TO ARRAY:C911(PRV_ProjectColors_aL; $AttrValue_L)
		End for 
		
		DOM CLOSE XML:C722($DomTree_txt)
		
		ARRAY TEXT:C222(PRV_InHouseDesign_atxt; 3)
		PRV_InHouseDesign_atxt{1}:="District In-House"
		PRV_InHouseDesign_atxt{2}:="Boston In-House"
		PRV_InHouseDesign_atxt{3}:=""
		
	: ($Task_txt="LOAD")
		
		PRV_Variables("RELATEBRIDGEINFO")
		PRV_Variables("RELATEPINFO")
		PRV_Variables("SUMMARYVARS")
		
	: ($Task_txt="RELATEPINFO")
		READ ONLY:C145([PRJ_ProjectFile:117])
		READ ONLY:C145([PRJ_ConstructionProject:116])
		READ ONLY:C145([PRJ_Contractor:114])
		READ ONLY:C145([PRJ_DesignContracts:123])
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=Num:C11([Contract_Assignment_Maintenance:101]ProjectIS:4))
		PRV_ProjMgr_txt:=[PRJ_ProjectFile:117]PF_ProjectExpediter_s:6
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3=[Contract_Assignment_Maintenance:101]ContractNo:1)
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
		PRV_Consultant_txt:=[Conslt_Name:127]ConsultantName_s:2
		PRV_PNFDate_d:=[PRJ_ProjectFile:117]PF_PNFDate_d:18
		PRV_PIFDate_d:=[PRJ_ProjectFile:117]PF_PIFDate_d:19
		PRV_PNFEvent_txt:=[PRJ_ProjectFile:117]PF_PNFEvent_s:21
		PRV_PIFEvent_d:=[PRJ_ProjectFile:117]PF_PIFDate_d:19
		PRV_SchedAdDate_d:=[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5
		PRV_ActualAdDate_d:=[PRJ_ProjectFile:117]PF_Advertised_d:14
		PRV_PRCSubmitDate_d:=[PRJ_ProjectFile:117]PF_PRCSubmDate_d:24
		PRV_PRCApprovalDate_d:=[PRJ_ProjectFile:117]PF_PRCApprDate_d:20
		PRV_ProjDescr_txt:=[PRJ_ProjectFile:117]PF_Description_txt:16
		//If ([PRJ_ProjectFile]PF_PRCEvent_s="@letter@") | ([PRJ_ProjectFile]PF_PRCEvent_s="@approved@")
		//PRV_PRCApprovalDate_d:=[PRJ_ProjectFile]PF_PRCApprDate_d
		//End if 
		PRV_BidOpeningSched_d:=[PRJ_ProjectFile:117]PF_BidOpened_d:12
		QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]PF_FileID_l:11=[PRJ_ProjectFile:117]PF_FileID_l:1)
		If (Records in selection:C76([PRJ_ConstructionProject:116])>0)
			PRV_AwardDate_d:=[PRJ_ConstructionProject:116]CP_Awarded_d:4
			PRV_BidOpeningAct_d:=[PRJ_ConstructionProject:116]CP_BidOpening_d:3
			PRV_BidAmmount_r:=[PRJ_ConstructionProject:116]CP_LowBid_r:7
			PRV_ConstrContr_txt:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
			QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_ContractorID_l:1=[PRJ_ConstructionProject:116]CTR_ContractorID_l:2)
			PRV_ConstrContractor_txt:=[PRJ_Contractor:114]CTR_CompanyName_s:2
		End if 
		
	: ($Task_txt="RELATEBRIDGEINFO")
		PRV_BDEPT_txt:=""
		PRV_Dist_txt:=""
		PRV_BIN_txt:=""
		PRV_Item8_txt:=""
		PRV_Town_txt:=""
		PRV_AASHTO_txt:=""
		PRV_OverUnder_txt:=""
		PRV_SD_txt:=""
		PRV_FO_txt:=""
		PRV_OnOff_txt:=""
		
		READ ONLY:C145([Bridge MHD NBIS:1])
		READ ONLY:C145([Contract_Project_Maintenance:100])
		PRV_CTRLSelections("BRIDGES")
		
		If (Records in selection:C76([Contract_Project_Maintenance:100])>0)
			PRV_SD_txt:="N"
			PRV_FO_txt:="N"
			ARRAY TEXT:C222($ContrBINS_atxt; Records in selection:C76([Contract_Project_Maintenance:100]))
			ARRAY TEXT:C222($ContrBDEPTS_atxt; Records in selection:C76([Contract_Project_Maintenance:100]))
			ARRAY TEXT:C222($ContrLoc_atxt; Records in selection:C76([Contract_Project_Maintenance:100]))
			ARRAY TEXT:C222($ContrTown_atxt; Records in selection:C76([Contract_Project_Maintenance:100]))
			ARRAY TEXT:C222($ContrDist_atxt; Records in selection:C76([Contract_Project_Maintenance:100]))
			SELECTION TO ARRAY:C260([Contract_Project_Maintenance:100]BIN:5; $ContrBINS_atxt; [Contract_Project_Maintenance:100]BridgeNo:4; $ContrBDEPTS_atxt; [Contract_Project_Maintenance:100]Location:6; $ContrLoc_atxt; [Contract_Project_Maintenance:100]Town:7; $ContrTown_atxt; [Contract_Project_Maintenance:100]District:8; $ContrDist_atxt)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($ContrBDEPTS_atxt))
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$ContrBINS_atxt{$loop_L})
				If (Position:C15($ContrBDEPTS_atxt{$loop_L}; PRV_BDEPT_txt)<=0)
					If (PRV_BDEPT_txt="")
						PRV_BDEPT_txt:=$ContrBDEPTS_atxt{$loop_L}
					Else 
						PRV_BDEPT_txt:=PRV_BDEPT_txt+", "+$ContrBDEPTS_atxt{$loop_L}
					End if 
				End if 
				
				If (PRV_BIN_txt="")
					PRV_BIN_txt:=$ContrBINs_atxt{$loop_L}
				Else 
					PRV_BIN_txt:=PRV_BIN_txt+", "+$ContrBINs_atxt{$loop_L}
				End if 
				If (PRV_Item8_txt="")
					PRV_Item8_txt:=[Bridge MHD NBIS:1]Item8:206
				Else 
					PRV_Item8_txt:=PRV_Item8_txt+", "+[Bridge MHD NBIS:1]Item8:206
				End if 
				C_TEXT:C284($Dist_txt)
				$Dist_txt:=String:C10(Num:C11($ContrDist_atxt{$loop_L}))
				If (Position:C15($Dist_txt; PRV_Dist_txt)<=0)
					If (PRV_Dist_txt="")
						PRV_Dist_txt:=$Dist_txt
					Else 
						PRV_Dist_txt:=PRV_Dist_txt+", "+$Dist_txt
					End if 
				End if 
				If (Position:C15($ContrTown_atxt{$loop_L}; PRV_Town_txt)<=0)
					If (PRV_Town_txt="")
						PRV_Town_txt:=$ContrTown_atxt{$loop_L}
					Else 
						PRV_Town_txt:=PRV_Town_txt+", "+$ContrTown_atxt{$loop_L}
					End if 
				End if 
				
				If (PRV_OverUnder_txt="")
					PRV_OverUnder_txt:=Replace string:C233(f_TrimStr($ContrLoc_atxt{$loop_L}; True:C214; True:C214); "  "; " ")
				Else 
					PRV_OverUnder_txt:=PRV_OverUnder_txt+", "+Replace string:C233(f_TrimStr($ContrLoc_atxt{$loop_L}; True:C214; True:C214); "  "; " ")
				End if 
				
				If (PRV_AASHTO_txt="")
					PRV_AASHTO_txt:=String:C10([Bridge MHD NBIS:1]AASHTO:5; "###.##")
				Else 
					PRV_AASHTO_txt:=PRV_AASHTO_txt+", "+String:C10([Bridge MHD NBIS:1]AASHTO:5; "###.##")
				End if 
				
				If ([Bridge MHD NBIS:1]StructDef:103)
					PRV_SD_txt:="Y"
				End if 
				C_TEXT:C284($ThisOnOff_txt)
				$ThisOnOff_txt:=QR_Item26OnOff
				If (PRV_OnOff_txt="")
					PRV_OnOff_txt:=$ThisOnOff_txt
				Else 
					
					If (Position:C15($ThisOnOff_txt; PRV_OnOff_txt)>0)
					Else 
						PRV_OnOff_txt:=PRV_OnOff_txt+","+$ThisOnOff_txt
					End if 
				End if 
				
				If ([Bridge MHD NBIS:1]FunctObs:106)
					PRV_FO_txt:="Y"
				End if 
				
			End for 
		End if 
		
	: ($Task_txt="SUMMARYVARS")
		PRV_Variables("SUMMSTR25")
		PRV_Variables("SUMMSTR90")
		PRV_Variables("SUMMFINALPSE")
		PRV_Variables("SUMMFINALPSEASST")
		PRV_Variables("SUMMROW")
		PRV_Variables("SUMMENV")
		PRV_Variables("SUMMTRA")
		PRV_Variables("SUMMCONSTR")
		PRV_Variables("SUMMOTHER")
		PRV_Variables("TOTALHRS")
		PRV_Variables("TOTALCOSTS")
		
	: ($Task_txt="SUMMSTR25") | ($Task_txt="SUMMHWY25")
		READ ONLY:C145([Preservation_Reviews:145])
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="STR25")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4)
		$NumReviews_L:=Records in selection:C76([Preservation_Reviews:145])
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; 1)
		PRV_First25SubDate_d:=[Preservation_Reviews:145]Received_d:4
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; $NumReviews_L)
		
		If ([Preservation_Reviews:145]Action_s:8="APPROVED")
			PRV_StructApproval25_d:=[Preservation_Reviews:145]SentBackToPM_d:9
		End if 
		
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="HWY25")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4)
		$NumReviews_L:=Records in selection:C76([Preservation_Reviews:145])
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; $NumReviews_L)
		If ([Preservation_Reviews:145]Action_s:8="APPROVED")
			PRV_HwyApproval25_d:=[Preservation_Reviews:145]SentBackToPM_d:9
		End if 
		
		If ((PRV_HwyApproval25_d#!00-00-00!) & (PRV_StructApproval25_d#!00-00-00!))
			If (PRV_HwyApproval25_d>PRV_StructApproval25_d)
				PRV_25SubAppr_d:=PRV_HwyApproval25_d
			Else 
				PRV_25SubAppr_d:=PRV_StructApproval25_d
			End if 
		End if 
		
	: ($Task_txt="SUMMSTR90") | ($Task_txt="SUMMHWY75")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="STR90")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4)
		$NumReviews_L:=Records in selection:C76([Preservation_Reviews:145])
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; 1)
		PRV_First90SubDate_d:=[Preservation_Reviews:145]Received_d:4
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; $NumReviews_L)
		
		If ([Preservation_Reviews:145]Action_s:8="APPROVED")
			PRV_StructApproval90_d:=[Preservation_Reviews:145]SentBackToPM_d:9
		End if 
		
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="HWY75")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4)
		$NumReviews_L:=Records in selection:C76([Preservation_Reviews:145])
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; $NumReviews_L)
		If ([Preservation_Reviews:145]Action_s:8="APPROVED")
			PRV_HwyApproval75_d:=[Preservation_Reviews:145]SentBackToPM_d:9
		End if 
		
		If ((PRV_HwyApproval75_d#!00-00-00!) & (PRV_StructApproval90_d#!00-00-00!))
			If (PRV_HwyApproval75_d>PRV_StructApproval90_d)
				PRV_90SubAppr_d:=PRV_HwyApproval75_d
			Else 
				PRV_90SubAppr_d:=PRV_StructApproval90_d
			End if 
		End if 
		
	: ($Task_txt="SUMMFINALPSE")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="FINALPSE")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4)
		$NumReviews_L:=Records in selection:C76([Preservation_Reviews:145])
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; 1)
		PRV_FinalPSESubDate_d:=[Preservation_Reviews:145]Received_d:4
		GOTO SELECTED RECORD:C245([Preservation_Reviews:145]; $NumReviews_L)
		
		If ([Preservation_Reviews:145]Action_s:8="APPROVED")
			PRV_FinalPSEApprove_d:=[Preservation_Reviews:145]SentBackToPM_d:9
		End if 
		
	: ($Task_txt="SUMMFINALPSEASST")
		
	: ($Task_txt="SUMMROW")
		READ ONLY:C145([Preservation_Reviews:145])
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="ROW")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]SentToREviewer_d:5; <)
		
		If ([Preservation_Reviews:145]Action_s:8="@Certificate@")
			PRV_ROWCertYN_txt:="Y"
		End if 
		
	: ($Task_txt="SUMMENV")
		READ ONLY:C145([Preservation_Reviews:145])
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="ENV")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]SentToREviewer_d:5; <)
		
		If ([Preservation_Reviews:145]Action_s:8="@Certificate@")
			PRV_EnvClrYN_txt:="Y"
		End if 
		
	: ($Task_txt="SUMMTRA")
		READ ONLY:C145([Preservation_Reviews:145])
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="TRA")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]SentToREviewer_d:5; <)
		
		If ([Preservation_Reviews:145]Action_s:8="@Approved@")
			PRV_TMPApprYN_txt:="Y"
		End if 
		
	: ($Task_txt="SUMMCONSTR")
		READ ONLY:C145([Preservation_Reviews:145])
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="CONSTR")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]SentToREviewer_d:5; <)
		
		If ([Preservation_Reviews:145]Action_s:8="@Approved@")
			PRV_ConstructionYN_txt:="Y"
		End if 
	: ($Task_txt="SUMMFHWA")
		READ ONLY:C145([Preservation_Reviews:145])
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="FHWA")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]SentToREviewer_d:5; <)
		
		If ([Preservation_Reviews:145]Action_s:8="@Approved@")
			PRV_FHWAApproval_txt:="Y"
		End if 
		
	: ($Task_txt="SUMMOTHER")
		
	: ($Task_txt="CLEAR")
		DOM CLOSE XML:C722(PRV_REVIEWTYPESTREE_txt)
		DOM CLOSE XML:C722(PRV_ADTTABLETREE_txt)
		DOM CLOSE XML:C722(PRV_DETOURTABLETREE_txt)
		DOM CLOSE XML:C722(PRV_CLASSTABLETREE_txt)
		
	: ($Task_txt="TOTALCOSTS")
		PRV_OrigCostTotal_r:=[Contract_Assignment_Maintenance:101]OrigSub_TotalLimFee_r:69+[Contract_Assignment_Maintenance:101]OrigSub_DirectCost_r:70
		C_LONGINT:C283(PRV_CURRASSIGNID_L)
		PRV_CURRASSIGNID_L:=[Contract_Assignment_Maintenance:101]AssignID:3
		C_DATE:C307(PRV_BlankDate_d)
		PRV_BlankDate_d:=!00-00-00!
		Begin SQL
			select sum(Addendum_Maintenance.Appr_DirectExpense_r), sum(Addendum_Maintenance.Appr_TotalLimmitFee_r )
			from Addendum_Maintenance
			where Addendum_Maintenance.AssignID = :PRV_CURRASSIGNID_L
			 and  Addendum_Maintenance.Approved_d > :PRV_BlankDate_d
			 into :PRV_Addend_DC_r, :PRV_Addend_TLF_r ;
		End SQL
		PRV_ApprTotal_TLF_r:=[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+PRV_Addend_TLF_r
		PRV_ApprTotal_DC_r:=[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26+PRV_Addend_DC_r
		
		Begin SQL
			select sum(Invoice_Maintenance.DirectExpenses), sum(Invoice_Maintenance.TotalLimFeeConstr+Invoice_Maintenance.TotalLimFeeDes )
			from Invoice_Maintenance
			where Invoice_Maintenance.AssignID_L = :PRV_CURRASSIGNID_L
			 and  Invoice_Maintenance.DateProcessFoward > :PRV_BlankDate_d
			 into :PRV_ActCostDC_r, :PRV_ActCostTLF_r ;
		End SQL
		
		PRV_ActCostSum_r:=PRV_ActCostTLF_r+PRV_ActCostDC_r
		PRV_ApprTotal_Sum_r:=PRV_ApprTotal_TLF_r+PRV_ApprTotal_DC_r
		
		PRV_Balance_TLF_r:=PRV_ApprTotal_TLF_r-PRV_ActCostTLF_r
		PRV_Balance_DC_r:=PRV_ApprTotal_DC_r-PRV_ActCostDC_r
		PRV_Balance_Sum_r:=PRV_Balance_TLF_r+PRV_Balance_DC_r
		
	: ($Task_txt="TOTALHRS")
		C_LONGINT:C283(PRV_CURRASSIGNID_L)
		PRV_CURRASSIGNID_L:=[Contract_Assignment_Maintenance:101]AssignID:3
		C_DATE:C307(PRV_BlankDate_d)
		PRV_BlankDate_d:=!00-00-00!
		
		Begin SQL
			select sum(Addendum_Maintenance.Appr_HRS_r)
			from Addendum_Maintenance
			where Addendum_Maintenance.AssignID = :PRV_CURRASSIGNID_L
			 and  Addendum_Maintenance.Approved_d > :PRV_BlankDate_d
			 into :PRV_Addend_HRS_r ;
		End SQL
		
		PRV_ApprTotal_HRS_r:=[Contract_Assignment_Maintenance:101]AgreedTotalHRS_r:46+PRV_Addend_HRS_r
		
		Begin SQL
			select sum(Invoice_Maintenance.TotalHRS_r)
			from Invoice_Maintenance
			where Invoice_Maintenance.AssignID_L = :PRV_CURRASSIGNID_L
			 and  Invoice_Maintenance.DateProcessFoward > :PRV_BlankDate_d
			 into :PRV_ActCostHRS_r ;
		End SQL
		
		PRV_Balance_HRS_r:=PRV_ApprTotal_HRS_r-PRV_ActCostHRS_r
End case 

//End PRV_Variables