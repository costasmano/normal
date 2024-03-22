//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/09/16, 12:37:05
//----------------------------------------------------
//Method: LSS_ExportInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug  // 
	//Modified by: administrator (2/9/16 12:37:15)
	
	Mods_2018_09  //Make sure an inspection recoird is selected
End if 
C_BOOLEAN:C305($vExport_B)
C_TEXT:C284($Description_txt)
C_LONGINT:C283($LBCol_L; $LBRow_L)
LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; $LBRow_L)
If ($LBRow_L>0)
	GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $LBRow_L)
	
	Begin SQL
		select 
		[LSS_refInspectionType].[LSS_Description_txt] 
		from
		[LSS_refInspectionType], [LSS_Inspection]
		where
		[LSS_refInspectionType].[LSS_InspectionTypeId_s] = [LSS_Inspection].[LSS_InspectionTypeId_s]
		into
		:$Description_txt;
		
		
	End SQL
	CONFIRM:C162("Export current inspection (Type "+$Description_txt+" for structure "+[LSS_Inventory:165]LSS_StructureNumber_s:6+" date "+String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4)+") ?")
	$vExport_B:=(OK=1)
	If ($vExport_B)
		C_TEXT:C284($TargetDir_txt; $ExportFile_txt; $ExportLine_txt)
		$ExportFile_txt:="Insp_"+[LSS_Inventory:165]LSS_StructureNumber_s:6+"_"+$Description_txt+"_"+String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4)+".export"
		$ExportFile_txt:=Replace string:C233($ExportFile_txt; "/"; "_")
		$TargetDir_txt:=Select folder:C670("Select folder for Export file")
		SET CHANNEL:C77(10; $TargetDir_txt+$ExportFile_txt)  //Open a channel for a document
		$ExportLine_txt:="LSS_Inspection"
		SEND VARIABLE:C80($ExportLine_txt)
		$ExportLine_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
		SEND VARIABLE:C80($ExportLine_txt)
		$ExportLine_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
		SEND VARIABLE:C80($ExportLine_txt)
		SEND RECORD:C78([LSS_Inspection:164])
		
		QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_Accessibility:159])
		
		QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_DMeter:161])
		
		QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_ElementInspection:163])
		
		QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_Photos:166])
		
		QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_SignPanel:172])
		
		QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_TowerDistance:174])
		
		QUERY:C277([LSS_TeamMembers:173]; [LSS_TeamMembers:173]LSS_InspectionId_s:1=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_TeamMembers:173])
		
		QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_UT:175])
		C_LONGINT:C283($Loop_L)
		For ($Loop_L; 1; Records in selection:C76([LSS_UT:175]))
			GOTO SELECTED RECORD:C245([LSS_UT:175]; $Loop_L)
			QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=[LSS_UT:175]LSS_UTId_s:1)
			LSS_SendRecords(->[LSS_UtResult:176])
		End for 
		
		QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		LSS_SendRecords(->[LSS_VerticalClearance:177])
		
		SET CHANNEL:C77(11)  //close file
		ALERT:C41("Created Export file "+$ExportFile_txt)
	End if 
Else 
	ALERT:C41("You must select an LSS inspection record to export")
End if 
//End LSS_ExportInspection

