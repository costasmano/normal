//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlPageMovement
// User name (OS): cjmiller
// Date and time: 04/07/06, 14:53:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //12/14/06, 16:38:20`Add structural project manager drop down
	Mods_2006_CJMv2  //03/15/07, 15:59:18` remove * form bridge de variable
	Mods_2007_CJMv2  //r060   `05/16/07, 12:13:32  `Add code to control access 
	// Modified by: costasmanousakis-(Designer)-(6/8/2007 16:42:59)
	Mods_2007_CM11
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/23/2007 14:12:31)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v5303  //r004 `10/23/07, 10:42:16
	Mods_2007_CJM_v54  //r002 `11/20/07, 12:48:59 `Fix display issues when new record is created
	Mods_2008_CJM_v56  //r002`Fix defect with submission numbers and make sure correct sorts are being don  `e
	//[PRJ_TypeStudy];
	//[PRJ_SketchPlans]
	//[PRJ_StructuralReview]
	Mods_2008_December  //CJM `r001    `12/17/08, 15:30:33   `Add new page to project input form with proje  `ct file and design contract information    
	Mods_2009_05  //r001  `05/14/09, 11:17:07  `r001  `05/07/09, 11:28:58  `Continue changes PRJ Desi  `gn Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_  `ConsultantOverideID_l
	//Removed call to PRJ_LoadDesignContractData page 2 as it was already called loadin  `g pag 0
	Mods_2011_06  // CJ Miller`06/28/11, 10:23:09      ` If [PRJ_ProjectDetails] locked set to non-enterable
End if 
PRJ_SetManyTablesReadOnly
OBJECT SET VISIBLE:C603(*; "SummaryDisplayPage0_@"; True:C214)
If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5="")
	OBJECT SET VISIBLE:C603(*; "SummaryNonBridge"; True:C214)
	OBJECT SET VISIBLE:C603(*; "SummaryBridge"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "SummaryNonBridge"; False:C215)
	OBJECT SET VISIBLE:C603(*; "SummaryBridge"; True:C214)
End if 

OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; False:C215)
OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Not_editable)
OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; False:C215)
OBJECT SET ENTERABLE:C238(PRJ_ConsultantName_txt; False:C215)  //always false except chaqpter 85 on page 2
OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Not_editable)
PRJ_SetPage0Detail(False:C215)

C_LONGINT:C283($PageNumber_l)

Case of 
	: (PRJProjectTabs_as=1)
		SAVE RECORD:C53([PRJ_ProjectDetails:115])
		PRJ_LoadPage_1
		$PageNumber_l:=1
		PRJ_SetAccessPage_1
		
	: (PRJProjectTabs_as=2)
		
		PRJ_CurrentPrjMgr_txt:=""
		PRJ_SetUpStructuralPrjMgr(->[PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)
		If ([PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39=0)
			PRJ_StructPrjMgr_atxt:=0
			PRJ_StructPrjMgrID_al:=0
			PRJ_CurrentPrjMgr_txt:="No Project Manager selected selected"
		End if 
		ORDER BY:C49([PRJ_StrPrjManagerHistory:128]; [PRJ_StrPrjManagerHistory:128]SPMH_Replaced_d:3; <)
		
		PRJ_PrjMgrHistory_txt:=""
		ARRAY DATE:C224($Date_ad; 0)
		ARRAY TEXT:C222($Name_atxt; 0)
		
		SELECTION TO ARRAY:C260([PRJ_StrPrjManagerHistory:128]SPMH_Replaced_d:3; $Date_ad; [PRJ_StrPrjManagerHistory:128]SPMH_StructuralProjManager_txt:2; $Name_atxt)
		C_LONGINT:C283($Loop_l)
		For ($loop_l; 1; Size of array:C274($Name_atxt))
			PRJ_PrjMgrHistory_txt:=PRJ_PrjMgrHistory_txt+$Name_atxt{$Loop_l}+" replaced "+String:C10($Date_ad{$Loop_l}; 7)+Char:C90(Carriage return:K15:38)
		End for 
		If (PRJ_PrjMgrHistory_txt="")
			PRJ_PrjMgrHistory_txt:="No previous structural project managers"+Char:C90(Carriage return:K15:38)
		End if 
		OBJECT SET VISIBLE:C603(*; "SummaryDisplayPage0_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "SummaryNonBridge"; False:C215)
		OBJECT SET VISIBLE:C603(*; "SummaryBridge"; False:C215)
		
		SAVE RECORD:C53([PRJ_ProjectDetails:115])
		PRJ_LoadPage2Bins
		PRJ_AllowBridgeEntry_l:=0
		PRJ_AllowBinEntry_l:=0
		PRJ_AllowProjectEntry_l:=0
		
		If (PRJ_DEBridgeNo_s="")
			OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; True:C214)
			OBJECT SET VISIBLE:C603(PRJ_AllowBridgeEntry_l; False:C215)
			OBJECT SET VISIBLE:C603(PRJ_AllowBinEntry_l; False:C215)
			OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; False:C215)
			OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Editable)
			OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Editable)
			
			If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
				OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; True:C214)
				OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Editable)
			Else 
				OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; False:C215)
				OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Not_editable)
			End if 
			
			
		End if 
		PRJ_SetAccessPage_2
		Case of 
				
			: ([PRJ_ProjectDetails:115]PRJ_NonBridge_s:7#"")
				OBJECT SET VISIBLE:C603(*; "NonBridgeTitle"; True:C214)
				OBJECT SET VISIBLE:C603(*; "BridgeTitle"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Select Included Bins"; False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*; "NonBridgeTitle"; False:C215)
				OBJECT SET VISIBLE:C603(*; "BridgeTitle"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Select Included Bins"; True:C214)
		End case 
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
		
		//QUERY([PRJ_DesignContracts];[PRJ_DesignContracts]DC_DesignContractNumber_l=[PRJ_P  `rojectDetails]DC_DesignContractID_l)
		
		//PRJ_LoadDesignContractData 
		
		
		GOTO OBJECT:C206(TrapVariable)
		
		$PageNumber_l:=2
	: (PRJProjectTabs_as=3)  //Report Data
		
		If (PRJ_ReturnAccessAllowed)
			SAVE RECORD:C53([PRJ_ProjectDetails:115])
			READ WRITE:C146([PRJ_ReportData:118])
		Else 
			READ ONLY:C145([PRJ_ReportData:118])
		End if 
		ORDER BY:C49([PRJ_ReportData:118]; [PRJ_ReportData:118]RPT_Received_d:3; <)
		$PageNumber_l:=3
		
	: (PRJProjectTabs_as=4)  //Type Study
		PRJ_LastReview_l:=0
		If (PRJ_ReturnAccessAllowed)
			SAVE RECORD:C53([PRJ_ProjectDetails:115])
			READ WRITE:C146([PRJ_TypeStudy:121])
		Else 
			READ ONLY:C145([PRJ_TypeStudy:121])
		End if 
		If (Records in selection:C76([PRJ_TypeStudy:121])>0)
			ORDER BY:C49([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]TYP_Received_d:5; <)
		End if 
		$PageNumber_l:=4
	: (PRJProjectTabs_as=5)  //sketch plans
		If (PRJ_ReturnAccessAllowed)
			SAVE RECORD:C53([PRJ_ProjectDetails:115])
			READ WRITE:C146([PRJ_SketchPlans:120])
		Else 
			READ ONLY:C145([PRJ_SketchPlans:120])
		End if 
		PRJ_LastReview_l:=0
		PRJ_LastReviewer_l:=0
		If (Records in selection:C76([PRJ_SketchPlans:120])>0)
			ORDER BY:C49([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3; <)
			PRJ_LastReview_l:=[PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3
			PRJ_LastReviewer_l:=[PRJ_SketchPlans:120]RV_ReviewID_l:2
			ORDER BY:C49([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]SKT_Recieved_d:5; <)
		End if 
		$PageNumber_l:=5
	: (PRJProjectTabs_as=6)  //Stuctural review
		
		If (PRJ_ReturnAccessAllowed)
			SAVE RECORD:C53([PRJ_ProjectDetails:115])
			READ WRITE:C146([PRJ_StructuralReview:119])
		Else 
			READ ONLY:C145([PRJ_StructuralReview:119])
		End if 
		PRJ_LastReview_l:=0
		PRJ_LastReviewer_l:=0
		If (Records in selection:C76([PRJ_StructuralReview:119])>0)
			ORDER BY:C49([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3; <)
			//LAST RECORD([PRJ_StructuralReview])
			PRJ_LastReview_l:=[PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3
			PRJ_LastReviewer_l:=[PRJ_StructuralReview:119]RV_ReviewID_l:2
		End if 
		UNLOAD RECORD:C212([PRJ_StructuralReview:119])
		$PageNumber_l:=6
	: (PRJProjectTabs_as=7)  //Time Tracking
		
		If (PRJ_ReturnAccessAllowed)
			SAVE RECORD:C53([PRJ_ProjectDetails:115])
			READ WRITE:C146([PRJ_ProjectTimeTracking:124])
		Else 
			READ ONLY:C145([PRJ_ProjectTimeTracking:124])
		End if 
		$PageNumber_l:=7
	: (PRJProjectTabs_as=8)  //Project file and Design Contract
		SAVE RECORD:C53([PRJ_ProjectDetails:115])
		$PageNumber_l:=8
		QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=[PRJ_ProjectFile:117]PF_FileNumber_l:3)
		ORDER BY:C49([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]ATTFile_Created_d:3; >)
		SELECTION TO ARRAY:C260([PRJ_ATTRFileNoXrefs:131]ATTFile_Created_d:3; PRJ_Attribute_ad; [PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; $AttIds_al)
		ARRAY TEXT:C222(PRJ_AttributeDescription_atxt; Size of array:C274(PRJ_Attribute_ad))
		C_LONGINT:C283($Loop_l)
		
		For ($Loop_l; 1; Size of array:C274(PRJ_Attribute_ad))
			QUERY:C277([PRJ_Attributes:130]; [PRJ_Attributes:130]ATTR_ID_l:1=$AttIds_al{$loop_l})
			PRJ_AttributeDescription_atxt{$Loop_l}:=[PRJ_Attributes:130]ATTR_Name_s:2
		End for 
		
End case 
PRJ_ResetForLockedRecord
FORM GOTO PAGE:C247($PageNumber_l)
//PRJProjectTabs_as{1}:="Summary"  `Page 1
//PRJProjectTabs_as{2}:="Project"  `Page 2
//PRJProjectTabs_as{3}:="Report data"  `Page 3
//PRJProjectTabs_as{4}:="type study"  `Page 4
//PRJProjectTabs_as{5}:="sketch plans"  `Page 5
//PRJProjectTabs_as{6}:="Stuctural review"  `Page 6
//PRJProjectTabs_as{7}:="Time Tracking"  `Page 7

//End PRJ_ControlPageMovement
