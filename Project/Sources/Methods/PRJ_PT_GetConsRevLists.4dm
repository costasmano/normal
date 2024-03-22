//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/11/07, 16:21:42
	// ----------------------------------------------------
	// Method: PRJ_PT_GetConsRevLists
	// Description
	// Assemble the Consultant Review personnel arrays
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_TimeTracking
	Mods_2006_CJMv2  //Make array names uniform
	// Modified by: costasmanousakis-(Designer)-(6/9/11 09:20:37)
	Mods_2011_06
	//  `Adjusted logic to get personnel from various lists and include Design access
End if 
ARRAY LONGINT:C221(PRJ_ConsultantReviewersID_al; 0)
ARRAY TEXT:C222(PRJ_ConsultantReviewers_atxt; 0)
C_BOOLEAN:C305($CReview_b; $BPreserv_b; $BInHouse_b)
$CReview_b:=((GRP_4DUIDinGroup(<>CurrentUser_UID; "Consultant Review")=1) | User in group:C338(Current user:C182; "Design Access Group"))
$BPreserv_b:=((GRP_4DUIDinGroup(<>CurrentUser_UID; "BridgePreservation")=1) | User in group:C338(Current user:C182; "Design Access Group"))
$BInHouse_b:=((GRP_4DUIDinGroup(<>CurrentUser_UID; "BridgeInHouseDes")=1) | User in group:C338(Current user:C182; "Design Access Group"))
ARRAY LONGINT:C221($ConsultantReviewersID_al; 0)
ARRAY TEXT:C222($ConsultantReviewers_atxt; 0)
C_LONGINT:C283($loop_L; $Found_L)
If ($CReview_b)
	PRJ_FillPersonnelDropDowns(->$ConsultantReviewersID_al; ->$ConsultantReviewers_atxt; "Consultant Review")
	For ($loop_L; 1; Size of array:C274($ConsultantReviewersID_al))
		$Found_L:=Find in array:C230(PRJ_ConsultantReviewersID_al; $ConsultantReviewersID_al{$loop_L})
		If ($Found_L>0)
		Else 
			APPEND TO ARRAY:C911(PRJ_ConsultantReviewersID_al; $ConsultantReviewersID_al{$loop_L})
			APPEND TO ARRAY:C911(PRJ_ConsultantReviewers_atxt; $ConsultantReviewers_atxt{$loop_L})
		End if 
		
	End for 
	
End if 

If ($BPreserv_b)
	PRJ_FillPersonnelDropDowns(->$ConsultantReviewersID_al; ->$ConsultantReviewers_atxt; "BridgePreservation")
	For ($loop_L; 1; Size of array:C274($ConsultantReviewersID_al))
		$Found_L:=Find in array:C230(PRJ_ConsultantReviewersID_al; $ConsultantReviewersID_al{$loop_L})
		If ($Found_L>0)
		Else 
			APPEND TO ARRAY:C911(PRJ_ConsultantReviewersID_al; $ConsultantReviewersID_al{$loop_L})
			APPEND TO ARRAY:C911(PRJ_ConsultantReviewers_atxt; $ConsultantReviewers_atxt{$loop_L})
		End if 
	End for 
End if 

If ($BInHouse_b)
	PRJ_FillPersonnelDropDowns(->$ConsultantReviewersID_al; ->$ConsultantReviewers_atxt; "BridgeInHouseDes")
	For ($loop_L; 1; Size of array:C274($ConsultantReviewersID_al))
		$Found_L:=Find in array:C230(PRJ_ConsultantReviewersID_al; $ConsultantReviewersID_al{$loop_L})
		If ($Found_L>0)
		Else 
			APPEND TO ARRAY:C911(PRJ_ConsultantReviewersID_al; $ConsultantReviewersID_al{$loop_L})
			APPEND TO ARRAY:C911(PRJ_ConsultantReviewers_atxt; $ConsultantReviewers_atxt{$loop_L})
		End if 
	End for 
End if 
SORT ARRAY:C229(PRJ_ConsultantReviewers_atxt; PRJ_ConsultantReviewersID_al)
If (False:C215)
	Case of 
		: (GRP_4DUIDinGroup(<>CurrentUser_UID; "Consultant Review")=1)
			PRJ_FillPersonnelDropDowns(->PRJ_ConsultantReviewersID_al; ->PRJ_ConsultantReviewers_atxt; "Consultant Review")
		: (GRP_4DUIDinGroup(<>CurrentUser_UID; "BridgePreservation")=1)
			PRJ_FillPersonnelDropDowns(->PRJ_ConsultantReviewersID_al; ->PRJ_ConsultantReviewers_atxt; "BridgePreservation")
		: (GRP_4DUIDinGroup(<>CurrentUser_UID; "BridgeInHouseDes")=1)
			PRJ_FillPersonnelDropDowns(->PRJ_ConsultantReviewersID_al; ->PRJ_ConsultantReviewers_atxt; "BridgeInHouseDes")
	End case 
End if 