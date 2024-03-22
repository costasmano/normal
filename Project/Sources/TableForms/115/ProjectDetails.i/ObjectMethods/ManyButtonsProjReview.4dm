// ----------------------------------------------------
// Object Method: PRJ_Button_l
// User name (OS): cjmiller
// Date and time: 03/30/06, 10:02:39
// ----------------------------------------------------
// Description
// This method will set up the many records on the summary page
//It will set a variable to identify which table we are in
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //10/19/06, 12:08:22`add double click to to button to move directly to structurtal review page
	Mods_2007_CJMv2  //05/03/07, 15:36:46`Add button to control page movement
	Mods_2007_CJMv3  //Add button to hide detail area
	Mods_2007_CJM_v5302  //r006 `11/06/07, 11:02:29
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($PRJ_NumberofRecords_l; $Loop_l)
		RELATE ONE:C42([PRJ_ProjectDetails:115])
		$PRJ_NumberofRecords_l:=Records in selection:C76([PRJ_StructuralReview:119])
		If ($PRJ_NumberofRecords_l>0)
			PRJ_Detail_s:="Go To Structural Review"
			PRJ_SetPage0Detail(True:C214)
			
			
			ARRAY TEXT:C222(PRJ_Detail_atxt; 0)
			ARRAY TEXT:C222(PRJ_DetailHead_atxt; 0)
			
			ARRAY TEXT:C222(PRJ_Detail_atxt; $PRJ_NumberofRecords_l*11)
			ARRAY TEXT:C222(PRJ_DetailHead_atxt; $PRJ_NumberofRecords_l*11)
			C_LONGINT:C283($Increment_l)
			$Increment_l:=1
			ORDER BY:C49([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3; <)
			For ($Loop_l; 1; Records in selection:C76([PRJ_StructuralReview:119]))
				GOTO SELECTED RECORD:C245([PRJ_StructuralReview:119]; $Loop_l)
				PRJ_DetailHead_atxt{$Increment_l}:="Review #-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Received-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_StructuralReview:119]SR_Received_d:7; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Assigned-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_StructuralReview:119]SR_Assigned_d:6; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Comments to DE-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Comments-> "
				PRJ_Detail_atxt{$Increment_l}:=Substring:C12([PRJ_StructuralReview:119]SR_Comments_txt:5; 1; 100)
				
				If ($Loop_l=$PRJ_NumberofRecords_l)
				Else 
					$Increment_l:=PRJ_SummaryAddDivider($Increment_l)
					
				End if 
			End for 
		Else 
			PRJ_SetPage0Detail(False:C215)
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		PRJProjectTabs_as:=6
		PRJ_ControlPageMovement
End case 
//End Object Method: PRJ_Button_l