//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/10/16, 12:14:51
//----------------------------------------------------
//Method: LSS_ReceiveRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_03_bug  // 
	//Modified by: administrator (3/10/16 12:14:52)
End if 
C_BOOLEAN:C305($Complete_B; $1; $CreateNewIDs_B)
$CreateNewIDs_B:=$1
ARRAY TEXT:C222($OriginalUTIds_atxt; 0)
ARRAY TEXT:C222($NewUTIds_atxt; 0)

Repeat 
	C_LONGINT:C283($Loop_L; $Number_L; $Count_L; $Pos_L)
	RECEIVE VARIABLE:C81($Number_L)
	
	If (OK=1)
		C_POINTER:C301($Table_ptr)
		$Table_ptr:=Table:C252($Number_L)
		RECEIVE VARIABLE:C81($Count_L)
		For ($Loop_L; 1; $Count_L)
			RECEIVE RECORD:C79($Table_ptr->)
			
			If ($CreateNewIDs_B)
				C_LONGINT:C283($Key_L)
				Case of 
					: (Table name:C256($Number_L)="LSS_Accessibility")
						[LSS_Accessibility:159]LSS_InspectionId_s:3:=[LSS_Inspection:164]LSS_InspectionId_s:1
						Inc_Sequence("LSS_AccessibilityId_s"; ->$Key_L)
						[LSS_Accessibility:159]LSS_AccessibilityId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
					: (Table name:C256($Number_L)="LSS_DMeter")
						[LSS_DMeter:161]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
						Inc_Sequence("LSS_DMeterId_s"; ->$Key_L)
						[LSS_DMeter:161]LSS_DMeterId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
					: (Table name:C256($Number_L)="LSS_ElementInspection")
						[LSS_ElementInspection:163]LSS_InspectionId_s:3:=[LSS_Inspection:164]LSS_InspectionId_s:1
						Inc_Sequence("LSS_ElementInspectionId_s"; ->$Key_L)
						[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
					: (Table name:C256($Number_L)="LSS_Photos")
						[LSS_Photos:166]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
						Inc_Sequence("LSS_PhotoId_s"; ->$Key_L)
						[LSS_Photos:166]LSS_PhotoId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
					: (Table name:C256($Number_L)="LSS_SignPanel")
						[LSS_SignPanel:172]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
						Inc_Sequence("LSS_SignPanelId_s"; ->$Key_L)
						[LSS_SignPanel:172]LSS_SignPanelId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
					: (Table name:C256($Number_L)="LSS_TowerDistance")
						[LSS_TowerDistance:174]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
						Inc_Sequence("LSS_TowerDistanceId_s"; ->$Key_L)
						[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
					: (Table name:C256($Number_L)="LSS_TeamMembers")
						[LSS_TeamMembers:173]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1
						
					: (Table name:C256($Number_L)="LSS_UT")
						[LSS_UT:175]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
						APPEND TO ARRAY:C911($OriginalUTIds_atxt; [LSS_UT:175]LSS_UTId_s:1)
						Inc_Sequence("LSS_UTId_s"; ->$Key_L)
						[LSS_UT:175]LSS_UTId_s:1:=String:C10($Key_L; <>KeyMask_s)
						APPEND TO ARRAY:C911($NewUTIds_atxt; [LSS_UT:175]LSS_UTId_s:1)
					: (Table name:C256($Number_L)="LSS_UtResult")
						$Pos_L:=Find in array:C230($OriginalUTIds_atxt; [LSS_UtResult:176]LSS_UTId_s:2)
						[LSS_UtResult:176]LSS_UTId_s:2:=$NewUTIds_atxt{$Pos_L}
						Inc_Sequence("LSS_UTResultId_s"; ->$Key_L)
						[LSS_UtResult:176]LSS_UTResultId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
					: (Table name:C256($Number_L)="LSS_VerticalClearance")
						[LSS_VerticalClearance:177]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
						Inc_Sequence("LSS_VerticalClearanceId_s"; ->$Key_L)
						[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
						
				End case 
				
			End if 
			SAVE RECORD:C53($Table_ptr->)
		End for 
	End if 
	$Complete_B:=(OK=0)
Until ($Complete_B)

//End LSS_ReceiveRecords

