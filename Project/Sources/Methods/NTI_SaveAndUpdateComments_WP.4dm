//%attributes = {"invisible":true}
//Method: NTI_SaveAndUpdateComments_WP
//Description
// handles the dropdown for selecting comment types
// Parameters
// $1 : $FromDropDown_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/24/21, 14:11:01
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_BOOLEAN:C305(NTI_SaveAndUpdateComments_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-12-30 12:30:32)
	Mods_2021_12_bug
	//  `fixes for saving changes in comments other than general remarks
End if 
//

C_BOOLEAN:C305($FromDropDown_B)
$FromDropDown_B:=False:C215
C_LONGINT:C283($mod_L)

If (Count parameters:C259=1)
	C_BOOLEAN:C305($1)
	$FromDropDown_B:=$1
End if 
C_POINTER:C301($WPArea_ptr)
$WPArea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE GeneralRemarks_WP")
C_BOOLEAN:C305($WPareamod_b)
C_LONGINT:C283($Count_L)
$WPareamod_b:=OB Get:C1224($WPArea_ptr->; "Modified"; Is boolean:K8:9)

If ($WPareamod_b)
	//if modified - cleanup area 
	WP_CleanupComments($WPArea_ptr)
	// check if there is anything left in the area
	C_OBJECT:C1216($body_o)
	$body_o:=WP Text range:C1341($WPArea_ptr->; wk start text:K81:165; wk end text:K81:164)
	$Count_L:=$body_o.end-$body_o.start
End if 


If ($WPareamod_b) & (Not:C34(Read only state:C362([TIN_Inspections:184])))  // if there are changes in the WP area and not in RO mode
	
	If (TINInspCommentTypes_atxt{0}="GENERAL REMARKS")
		
		INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE GeneralRemarks_WP"; "fieldptr"; ->[TIN_Inspections:184]Comments:23; "formEvent"; On Losing Focus:K2:8; "changeStack"; 1))
		
	Else 
		//one of the other comments 
		C_BOOLEAN:C305($RecordLoadedOK_b; $recordValid_b)
		$RecordLoadedOK_b:=False:C215
		$recordValid_b:=False:C215
		//find the comments record
		InitChangeStack(3)
		QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]InspectionID:1=[TIN_Inspections:184]InspectionID:2; *)
		QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]CommentType_s:8=TINInspCommentTypes_atxt{0})
		
		Case of 
			: (Records in selection:C76([TIN_Insp_Comments:188])=1)
				//load it for editing
				If (ut_LoadRecordInteractive(->[TIN_Insp_Comments:188]))
					$RecordLoadedOK_b:=True:C214
				End if 
			: (Records in selection:C76([TIN_Insp_Comments:188])=0)
				//no record found - create one
				//record not found - create it 
				CREATE RECORD:C68([TIN_Insp_Comments:188])
				[TIN_Insp_Comments:188]InspectionID:1:=[TIN_Inspections:184]InspectionID:2
				Inc_Sequence("TIN_Insp_Comments"; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3)
				LogNewRecord(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_Comments:188]InspectionID:1; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3; 2; "TIN_Insp_Comments")
				[TIN_Insp_Comments:188]ISOCreatedDate_s:4:=ISODateTime(Current date:C33; Current time:C178)
				[TIN_Insp_Comments:188]CreatedBy_s:5:=Current user:C182
				[TIN_Insp_Comments:188]CommentType_s:8:=TINInspCommentTypes_atxt{0}
				PushChange(3; ->[TIN_Insp_Comments:188]ISOCreatedDate_s:4)
				PushChange(3; ->[TIN_Insp_Comments:188]CreatedBy_s:5)
				PushChange(3; ->[TIN_Insp_Comments:188]CommentType_s:8)
				$RecordLoadedOK_b:=True:C214
			Else 
				//multiple records exist for this comment type !  Error!
				ALERT:C41("Data Error for this inspection report!\n"+\
					"Please notify administrator! Include the date and type of report!")
				
		End case 
		
		If ($RecordLoadedOK_b)
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE GeneralRemarks_WP"; "fieldptr"; ->[TIN_Insp_Comments:188]Comment_blb:9; "formEvent"; On Losing Focus:K2:8; "changeStack"; 3))
			FlushGrpChgs(3; ->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_Comments:188]InspectionID:1; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3; 2)
			SAVE RECORD:C53([TIN_Insp_Comments:188])
		Else 
			ALERT:C41("Changes will not be saved!")
		End if 
		
	End if 
	
End if 


If ($FromDropDown_B)
	If (TINInspCommentTypes_atxt{TINInspCommentTypes_atxt}="GENERAL REMARKS")
		INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE GeneralRemarks_WP"; "fieldptr"; ->[TIN_Inspections:184]Comments:23; "formEvent"; On Load:K2:1; "changeStack"; 1))
		
	Else 
		QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]InspectionID:1=[TIN_Inspections:184]InspectionID:2; *)
		QUERY:C277([TIN_Insp_Comments:188];  & ; [TIN_Insp_Comments:188]CommentType_s:8=TINInspCommentTypes_atxt{TINInspCommentTypes_atxt})
		
		If (Read only state:C362([TIN_Inspections:184]))
			//if are RO - just load the comments
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE GeneralRemarks_WP"; "fieldptr"; ->[TIN_Insp_Comments:188]Comment_blb:9; "formEvent"; On Load:K2:1; "changeStack"; 3))
			
		Else 
			// RW mode - try to load the comments record in RW
			If (ut_LoadRecord(->[TIN_Insp_Comments:188]; 5))
				INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE GeneralRemarks_WP"; "fieldptr"; ->[TIN_Insp_Comments:188]Comment_blb:9; "formEvent"; On Load:K2:1; "changeStack"; 3))
			Else 
				ALERT:C41("Could not load required "+TINInspCommentTypes_atxt{TINInspCommentTypes_atxt}+" record for editing.")
			End if 
			
		End if 
		
		
	End if 
	
End if 

//End NTI_SaveAndUpdateComments_WP