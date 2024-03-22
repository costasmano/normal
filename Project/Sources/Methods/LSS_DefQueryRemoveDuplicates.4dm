//%attributes = {"invisible":true}
//Method: LSS_DefQueryRemoveDuplicates
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/14/19, 15:33:40
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
End if 
//
ARRAY LONGINT:C221($InspectionRecordNumbers_aL; 0)
C_TEXT:C284($ThisElementID_txt)
C_LONGINT:C283($ElementInspLoop_L; $InnerLoop_L; $ArraySize_L; $Progress_L)
$Progress_L:=-9
If (Size of array:C274(v_164_002_atxt)>9)
	$Progress_L:=Progress New
End if 
C_LONGINT:C283($Loop_l; $ElementInspLoop_L)
For ($Loop_l; 1; Size of array:C274(v_164_002_atxt))
	If ($Progress_L>0)
		Progress SET TITLE($progress_L; "Searching for Duplicate element entries for structure ID "+v_164_002_atxt{$Loop_l})
		Progress SET PROGRESS($progress_L; $Loop_l/Size of array:C274(v_164_002_atxt))
		
	End if 
	ARRAY LONGINT:C221($ElementRecordNumbers_aL; 0)
	If (Size of array:C274(InspectionRecs_AL{$Loop_L})<1)
		
	Else 
		CREATE SELECTION FROM ARRAY:C640([LSS_Inspection:164]; InspectionRecs_AL{$Loop_L})
		SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $InspID_atxt; [LSS_Inspection:164]LSS_InspectionDate_d:4; $Insp_ad)
		SET QUERY DESTINATION:C396(Into set:K19:2; "CompareSet")
		QUERY WITH ARRAY:C644([LSS_ElementInspection:163]LSS_InspectionId_s:3; $InspID_atxt)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		USE SET:C118("CompareSet")
		
		ARRAY LONGINT:C221($ElementID_AL; 0)
		ARRAY TEXT:C222($ElementID_atxt; 0)
		ARRAY TEXT:C222($ElementInspID_atxt; 0)
		SELECTION TO ARRAY:C260([LSS_ElementInspection:163]LSS_ElementId_L:2; $ElementID_AL; \
			[LSS_ElementInspection:163]LSS_InspectionId_s:3; $ElementInspID_atxt; \
			[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; $ElementID_atxt)
		ARRAY DATE:C224($ElementInsp_ad; 0)
		INTERSECTION:C121("CompareSet"; "InterimSet"; "CompareSet")
		If (Records in set:C195("CompareSet")>0)
			USE SET:C118("CompareSet")
			ARRAY DATE:C224($ElementInsp_ad; Size of array:C274($ElementID_atxt))
			C_LONGINT:C283($Pos_L)
			For ($ElementInspLoop_L; Size of array:C274($ElementID_AL); 1; -1)
				$Pos_L:=Find in array:C230($InspID_atxt; $ElementInspID_atxt{$ElementInspLoop_L})
				If ($Pos_L>0)
					$ElementInsp_ad{$ElementInspLoop_L}:=$Insp_ad{$Pos_L}
				Else 
					
					DELETE FROM ARRAY:C228($ElementID_AL; $ElementInspLoop_L; 1)
					DELETE FROM ARRAY:C228($ElementInspID_atxt; $ElementInspLoop_L; 1)
					DELETE FROM ARRAY:C228($ElementID_atxt; $ElementInspLoop_L; 1)
					DELETE FROM ARRAY:C228($ElementInsp_ad; $ElementInspLoop_L; 1)
					
				End if 
			End for 
			C_TEXT:C284($Compare_txt)
			ARRAY TEXT:C222($ElementCompare_atxt; 0)
			ARRAY TEXT:C222($ElementCompare_atxt; Size of array:C274($ElementInsp_ad))
			
			MULTI SORT ARRAY:C718($ElementInsp_ad; <; $ElementInspID_atxt; >; $ElementID_AL; >; $ElementID_atxt; $ElementCompare_atxt)
			For ($ElementInspLoop_L; 1; Size of array:C274($ElementID_AL))
				$ElementCompare_atxt{$ElementInspLoop_L}:=$ElementID_atxt{$ElementInspLoop_L}+"-"+String:C10($ElementID_AL{$ElementInspLoop_L})
			End for 
			CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "RemoveMeSet")
			For ($ElementInspLoop_L; 1; Records in selection:C76([LSS_ElementInspection:163]))
				GOTO SELECTED RECORD:C245([LSS_ElementInspection:163]; $ElementInspLoop_L)
				$Pos_L:=Find in array:C230($ElementID_AL; [LSS_ElementInspection:163]LSS_ElementId_L:2)
				If ($Pos_L>0)
					$Compare_txt:=[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1+"-"+String:C10([LSS_ElementInspection:163]LSS_ElementId_L:2)
					If ($Compare_txt=$ElementCompare_atxt{$Pos_L})
					Else 
						ADD TO SET:C119([LSS_ElementInspection:163]; "RemoveMeSet")
						
					End if 
				End if 
				
			End for 
			DIFFERENCE:C122("InterimSet"; "RemoveMeSet"; "InterimSet")
			
		End if 
	End if 
End for 
If ($Progress_L>0)
	Progress QUIT($Progress_L)
End if 
//End LSS_DefQueryRemoveDuplicates