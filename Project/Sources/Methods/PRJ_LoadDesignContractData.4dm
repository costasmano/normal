//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadDesignContractData
// User name (OS): cjmiller
// Date and time: 03/24/06, 11:02:12
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_PRJSELECTION
	Mods_2007_CJM_v5303  //r004 `10/23/07, 16:30:01`Add code to allow for overide  consultant
	Mods_2008_December  //CJM `r001    `12/17/08, 12:59:55 ``Add new page to project input form with project file and design contract information    
	Mods_2009_05  //r001  `05/07/09, 15:32:51  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 13:35:41   `Merge PRJ Design Contract Changes
	Mods_2009_12  // r001 CJ Miller`12/10/09, 14:33:42     `Fix bug when displaying consultant name
End if 
PRJ_DCDescription_txt:=""
PRJ_DCContrFederalAidNos_s:=""
PRJ_DCActualAmount_s:=""
PRJ_DCCompletion_d:=!00-00-00!

PRJ_DCEstComplete_d:=!00-00-00!
PRJ_DCProjectInfoAmount_s:=""
PRJ_DCRemainingAmount_s:=""

PRJ_ConsultantName_txt:=""
ARRAY TEXT:C222(PRJ_DCDropDown_atxt; 0)

//SET VISIBLE(*;"SummaryDisplayPage0_DCDD";False)
C_LONGINT:C283($Loc_l; $Loop_l)
If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
	PRJ_FillConsAndSetButton([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
Else 
	QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectDetails:115]PF_FileID_l:3)
	
	Case of 
		: (Records in selection:C76([PRJ_DCPFJoin:135])=0)
			If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
				QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
				$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
				ARRAY TEXT:C222(PRJ_DCDropDown_atxt; 1)
				If ($Loc_l>0)
					PRJ_DCDropDown_atxt{1}:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+" - "+PRJ_ConsultantName_atxt{$Loc_l}
				Else 
					PRJ_DCDropDown_atxt{1}:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+" - "+"No Consultant assigned"
				End if 
				PRJ_DCDropDown_atxt:=1
			Else 
				PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
				$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
				If ($Loc_l>0)
					PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
				End if 
				
			End if 
			
		: (Records in selection:C76([PRJ_DCPFJoin:135])<2)
			
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2)
			$ConsultantIDToUse_l:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
			$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
			ARRAY TEXT:C222(PRJ_DCDropDown_atxt; 1)
			If ($Loc_l>0)
				PRJ_DCDropDown_atxt{1}:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+" - "+PRJ_ConsultantName_atxt{$Loc_l}
			Else 
				PRJ_DCDropDown_atxt{1}:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+" - "+"No Consultant assigned"
			End if 
			PRJ_DCDropDown_atxt:=1
			$ConsultantIDToUse_l:=PRJ_FillDCForDisplay
		Else 
			
			ARRAY LONGINT:C221($DC_ProjectIDs_al; 0)
			ARRAY LONGINT:C221($DC_ProjectIDs_al; Records in selection:C76([PRJ_DCPFJoin:135]))
			SELECTION TO ARRAY:C260([PRJ_DCPFJoin:135]DC_DesignProjectID_l:2; $DC_ProjectIDs_al)
			QUERY WITH ARRAY:C644([PRJ_DesignContracts:123]DC_DesignContractID_l:1; $DC_ProjectIDs_al)
			ARRAY TEXT:C222(PRJ_DCDropDown_atxt; 0)
			ARRAY TEXT:C222(PRJ_DCDropDown_atxt; Records in selection:C76([PRJ_DesignContracts:123]))
			ARRAY LONGINT:C221(PRJDCRecordNUmber_al; 0)
			ARRAY LONGINT:C221(PRJDCRecordNUmber_al; Records in selection:C76([PRJ_DesignContracts:123]))
			ARRAY LONGINT:C221($DC_DesignPRJIDs_al; 0)
			ARRAY LONGINT:C221($DC_DesignPRJIDs_al; Records in selection:C76([PRJ_DesignContracts:123]))
			
			
			C_LONGINT:C283($ConsultantIDToUse_l)
			$ConsultantIDToUse_l:=0
			SELECTION TO ARRAY:C260([PRJ_DesignContracts:123]; PRJDCRecordNUmber_al; [PRJ_DesignContracts:123]DC_DesignContractID_l:1; $DC_DesignPRJIDs_al; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3; $DCContractNumber_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2; $ConsultantID_al)
			If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
				If (Records in selection:C76([PRJ_DesignContracts:123])=0)
					QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
				End if 
			End if 
			For ($Loop_l; 1; Size of array:C274(PRJDCRecordNUmber_al))
				GOTO RECORD:C242([PRJ_DesignContracts:123]; PRJDCRecordNUmber_al{$Loop_l})
				$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
				If ($Loc_l>0)
					PRJ_DCDropDown_atxt{$Loop_l}:=String:C10($DCContractNumber_al{$Loop_l})+" - "+PRJ_ConsultantName_atxt{$Loc_l}
				Else 
					PRJ_DCDropDown_atxt{$Loop_l}:=String:C10($DCContractNumber_al{$Loop_l})+" - "+"No Consultant assigned"
				End if 
				
			End for 
			$ConsultantIDToUse_l:=Find in array:C230($DC_DesignPRJIDs_al; [PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
			If ($ConsultantIDToUse_l>0)
			Else 
				$ConsultantIDToUse_l:=1
			End if 
			If (Size of array:C274(PRJDCRecordNUmber_al)>0)
				PRJ_DCDropDown_atxt:=$ConsultantIDToUse_l
				GOTO RECORD:C242([PRJ_DesignContracts:123]; PRJDCRecordNUmber_al{PRJ_DCDropDown_atxt})
			End if 
			
			$ConsultantIDToUse_l:=PRJ_FillDCForDisplay
			PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
			$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
			If ($Loc_l>0)
				PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
			End if 
	End case 
	//RELATE ONE([PRJ_ProjectFile]DC_DesignProjectID_l;[PRJ_DesignContracts]DC_DesignProjectID_l)
	//QUERY([PRJ_DesignContracts];[PRJ_DesignContracts]DC_DesignProjectID_l=[PRJ_ProjectFile]DC_DesignProjectID_l)
	If (Size of array:C274(PRJ_DCDropDown_atxt)=0)
		OBJECT SET VISIBLE:C603(*; "SummaryPage0_DCDD@"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "SummaryPage0_DCDD@"; True:C214)
	End if 
	PRJ_FillConsAndSetButton($ConsultantIDToUse_l)
End if 


//End PRJ_LoadDesignContractData