//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_DetailOutsideCall
// User name (OS): cjmiller
// Date and time: 11/20/07, 16:12:33
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r002 `11/20/07, 16:13:01`Add record - made it so outside call is a method so add record form uses exact same call
	// Modified by: costasmanousakis-(Designer)-(5/27/08 16:55:58)
	Mods_2008_CM_5403
	//Copy from CJM of update to handle better "OverrideConsultant" when 
	//there is no ProjectFile associated with the projdetail record
	// Modified by: costasmanousakis-(Designer)-(6/16/08 13:33:48)
	Mods_2008_CM_5403
	//Another update for  "OverrideConsultant" when there is a projectfile with no des contract.
	Mods_2009_04  // `r001  `04/17/09, 10:33:59 `Fix bug where consultant changes not being made. Record was in read only state
	Mods_2009_05  //r001  `05/07/09, 12:04:39  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_05  //r001  `05/14/09, 11:19:26  `r001  `05/07/09, 11:28:58  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l`change  (◊SelectionOption_txt="Consultant")
	Mods_2009_05  //r001  `05/14/09, 14:28:43  `r001  `05/07/09, 11:28:58  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l`Add code re selecting design contract when from project file number
	Mods_2009_06  //r002 `06/11/09, 13:40:02   `Merge PRJ Design Contract Changes
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2022_05  //Convert from using modify selection to list boxes 
	//Modified by: Chuck Miller (5/24/22 10:59:53)
	
End if 
//HIDE PROCESS(<>ProjectSelectionProcess_l)
//PAUSE PROCESS(<>ProjectSelectionProcess_l)
TRACE:C157
Case of 
	: (<>SelectionOption_txt="Bridge")
		If (<>PRJ_SelectedData_txt="")
			If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
				PRJ_DEBridgeNo_s:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
				PRJ_DEBin_s:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
			Else 
				PRJ_DEBridgeNo_s:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
				PRJ_DEBin_s:=""
			End if 
		Else 
			<>PRJ_SelectedBIN_txt:=Substring:C12(<>PRJ_SelectedData_txt; 7)
			<>PRJ_SelectedData_txt:=Substring:C12(<>PRJ_SelectedData_txt; 1; 6)
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=<>PRJ_SelectedData_txt)
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			If (Substring:C12(PRJ_DEBridgeNo_s; 1; 6)#<>PRJ_SelectedData_txt) & (Length:C16(PRJ_DEBridgeNo_s)>5)
				CONFIRM:C162("Change BDEPT from "+PRJ_DEBridgeNo_s+" to "+<>PRJ_SelectedData_txt)
				If (OK=1)
					PRJ_ResetBridge
				End if 
			Else 
				PRJ_ResetBridge
			End if 
			OBJECT SET VISIBLE:C603(*; "NonBridgeTitle"; False:C215)
			OBJECT SET VISIBLE:C603(*; "BridgeTitle"; True:C214)
			REDRAW WINDOW:C456
		End if 
		PRJ_BD_BuildBrgDataShtList
		PRJ_SetEntryCheckBoxes
	: (<>SelectionOption_txt="FederalAid")
		If (<>PRJ_SelectedData_txt="")
		Else 
			[PRJ_ProjectDetails:115]PRJ_FederalAid_s:25:=<>PRJ_SelectedData_txt
		End if 
	: (<>SelectionOption_txt="Program")
		If (<>PRJ_SelectedData_txt="")
		Else 
			[PRJ_ProjectDetails:115]PRJ_Program_s:23:=<>PRJ_SelectedData_txt
		End if 
	: (<>SelectionOption_txt="Bins")  //not used any longer
		PRJ_LoadPage2Bins
		
	: (<>SelectionOption_txt="ProjectFile")
		If (<>PRJ_SelectedData_txt="")
		Else 
			[PRJ_ProjectDetails:115]PF_FileID_l:3:=Num:C11(<>PRJ_SelectedData_txt)
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
			
			QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectDetails:115]PF_FileID_l:3)
			Case of 
				: (Records in selection:C76([PRJ_DCPFJoin:135])=0)
				: (Records in selection:C76([PRJ_DCPFJoin:135])=1)
					[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2
				Else 
					PRJ_SelectCorrectDC
			End case 
			[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=0
			
			PRJ_LoadProjectFileData
			PRJ_LoadDesignContractData
			PRJ_SetEntryCheckBoxes
		End if 
		
	: (<>SelectionOption_txt="DesignContract")  //does this need more work
		If (<>PRJ_SelectedData_txt="")
		Else 
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=Num:C11(<>PRJ_SelectedData_txt))
			QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DC_DesignProjectID_l:2=[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
			
			PRJ_SelectCorrectPF
			
		End if 
		PRJ_LoadProjectFileData
		PRJ_SetEntryCheckBoxes
	: (<>SelectionOption_txt="OverideConsultant")
		C_BOOLEAN:C305($Update_b)
		$Update_b:=False:C215
		If (<>PRJ_SelectedData_txt="")
			
		Else 
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
			If (Records in selection:C76([PRJ_DesignContracts:123])>0)
				If ([PRJ_DesignContracts:123]DC_DesignContractID_l:1=Num:C11(<>PRJ_SelectedData_txt))
					<>PRJ_SelectedData_txt:=""
					$Update_b:=True:C214
				Else 
					$Update_b:=True:C214
				End if 
			Else 
				$Update_b:=True:C214
			End if 
			
		End if 
		If ($Update_b)
			[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=Num:C11(<>PRJ_SelectedData_txt)
		End if 
		PRJ_LoadDesignContractData
	: (<>SelectionOption_txt="Consultant")
		//◊PRJ_SelectedData_txt`this is consultant ID
		Case of 
				
			: (<>PRJ_SelectedData_txt="Skip")
			: (<>PRJ_SelectedData_txt="")
			Else 
				[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=Num:C11(<>PRJ_SelectedData_txt)
		End case 
		C_LONGINT:C283($Loc_l)
		$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
		If ($Loc_l>0)
			PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
		End if 
		
End case 
//End PRJ_DetailOutsideCall