//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlSelectFileNumber
// User name (OS): cjmiller
// Date and time: 11/27/07, 10:55:21
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 10:55:23
End if 
C_LONGINT:C283(<>ProjectSelectionProcess_l)

If (PRJ_SelectByDesignContract_l=0)
	If (PRJ_DEProjectFileNo_l=0)
		[PRJ_ProjectDetails:115]PF_FileID_l:3:=0
		PRJ_LoadProjectFileData
		PRJ_SetEntryCheckBoxes
		PRJ_SetAccessPage_2
	Else   //C_TEXT($search_txt)
		//$search_txt:=String(PRJ_DEProjectFileNo_l)+"@"
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_DEProjectFileNo_l)
		If (Records in selection:C76([PRJ_ProjectFile:117])=1) & (PRJ_DEProjectFileNo_l>99999)
			PRJ_DEProjectFileNo_l:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
			[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
			PRJ_LoadProjectFileData
			PRJ_SetEntryCheckBoxes
			PRJ_SetAccessPage_2
			
		Else 
			<>SelectionOption_txt:="ProjectFile"
			<>ProjectProcess_l:=Current process:C322
			<>PRJ_SelectedData_txt:=String:C10(PRJ_DEProjectFileNo_l)
			
			PRJ_StartOrResumeProjSelection
		End if 
	End if 
Else 
	QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3=PRJ_DEProjectFileNo_l)
	If (Records in selection:C76([PRJ_DesignContracts:123])=1)
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]DC_OLDDesignContractID_l:2=[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
		If (Records in selection:C76([PRJ_ProjectFile:117])=1)
			PRJ_DEProjectFileNo_l:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
			[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
			PRJ_LoadProjectFileData
			PRJ_SetEntryCheckBoxes
		Else 
			
			<>SelectionOption_txt:="DesignContract"
			<>ProjectProcess_l:=Current process:C322
			<>PRJ_SelectedData_txt:=String:C10(PRJ_DEProjectFileNo_l)
			PRJ_StartOrResumeProjSelection
		End if 
	Else 
		<>SelectionOption_txt:="DesignContract"
		<>ProjectProcess_l:=Current process:C322
		<>PRJ_SelectedData_txt:=String:C10(PRJ_DEProjectFileNo_l)
		PRJ_StartOrResumeProjSelection
		
	End if 
	
End if 

//End PRJ_ControlSelectFileNumber