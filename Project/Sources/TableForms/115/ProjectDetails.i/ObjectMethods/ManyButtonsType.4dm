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
	Mods_2006_CJMv2  //10/19/06, 12:08:22`add double click to to button to move directly to type study page
	Mods_2007_CJMv2  //05/03/07, 15:36:46`Add button to control page movement
	Mods_2007_CJMv3  //Add button to hide detail area
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		RELATE ONE:C42([PRJ_ProjectDetails:115])
		$PRJ_NumberofRecords_l:=Records in selection:C76([PRJ_TypeStudy:121])
		If ($PRJ_NumberofRecords_l>0)
			PRJ_Detail_s:="Go To Type Study"
			PRJ_SetPage0Detail(True:C214)
			
			
			ARRAY TEXT:C222(PRJ_Detail_atxt; 0)
			ARRAY TEXT:C222(PRJ_DetailHead_atxt; 0)
			
			ARRAY TEXT:C222(PRJ_Detail_atxt; $PRJ_NumberofRecords_l*9)
			ARRAY TEXT:C222(PRJ_DetailHead_atxt; $PRJ_NumberofRecords_l*9)
			C_LONGINT:C283($Increment_l; $PRJ_NumberofRecords_l)
			$Increment_l:=1
			$PRJ_NumberofRecords_l:=Records in selection:C76([PRJ_TypeStudy:121])
			C_LONGINT:C283($Loop_l)
			For ($Loop_l; 1; $PRJ_NumberofRecords_l)
				GOTO SELECTED RECORD:C245([PRJ_TypeStudy:121]; $Loop_l)
				PRJ_DetailHead_atxt{$Increment_l}:="Type-> "
				PRJ_Detail_atxt{$Increment_l}:=[PRJ_TypeStudy:121]TYP_StudyType_s:3
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Source-> "
				PRJ_Detail_atxt{$Increment_l}:=[PRJ_TypeStudy:121]TYP_Source_s:6
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Received-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_TypeStudy:121]TYP_Received_d:5; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Approved-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_TypeStudy:121]TYP_Approved_d:10; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Received from Geo-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_TypeStudy:121]TYP_RecFromGeotech_d:9; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Received from Hydro-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_TypeStudy:121]TYP_RecFromHydro_d:8; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Comments to DE-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_TypeStudy:121]TYP_CommentsToDE_d:11; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Distribution-> "
				PRJ_Detail_atxt{$Increment_l}:=String:C10([PRJ_TypeStudy:121]TYP_Distribution_d:7; 7)
				$Increment_l:=$Increment_l+1
				PRJ_DetailHead_atxt{$Increment_l}:="Structure Type-> "
				PRJ_Detail_atxt{$Increment_l}:=[PRJ_TypeStudy:121]TYP_StructureType_s:4
				If ($Loop_l=$PRJ_NumberofRecords_l)
				Else 
					$Increment_l:=PRJ_SummaryAddDivider($Increment_l)
					
				End if 
			End for 
		Else 
			PRJ_SetPage0Detail(False:C215)
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		PRJProjectTabs_as:=4
		PRJ_ControlPageMovement
End case 
//End Object Method: PRJ_Button_l