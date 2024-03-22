//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlReviewerChange
// User name (OS): cjmiller
// Date and time: 01/27/06, 13:49:11
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 poionter to field
//$2 text of message
//$3 if it exists is hourly rate 
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //03/15/07, 12:37:25  `Change name from Reviewers to StructReviewers
End if 
C_POINTER:C301($1; $ReviewID_ptr)
$ReviewID_ptr:=$1
C_TEXT:C284($2; $ConfirmMessage_txt)
$ConfirmMessage_txt:=$2
If (Count parameters:C259=3)
	C_POINTER:C301($3; $Rate_ptr)
	$Rate_ptr:=$3
End if 
Case of 
	: ($ReviewID_ptr->=0)
		$ReviewID_ptr->:=PRJ_StructReviewersID_al{PRJ_StructReviewers_atxt}
		PRJ_Reviewer_txt:=PRJ_StructReviewers_atxt{PRJ_StructReviewers_atxt}
	: (PRJ_Reviewer_txt=PRJ_StructReviewers_atxt{PRJ_StructReviewers_atxt})  //no change
	: ($ReviewID_ptr->#PRJ_StructReviewersID_al{PRJ_StructReviewers_atxt})
		CONFIRM:C162($ConfirmMessage_txt+Char:C90(13)+PRJ_Reviewer_txt+" to "+Char:C90(13)+PRJ_StructReviewers_atxt{PRJ_StructReviewers_atxt}; "Yes"; "No")
		If (OK=1)
			PRJ_Reviewer_txt:=PRJ_StructReviewers_atxt{PRJ_StructReviewers_atxt}
			$ReviewID_ptr->:=PRJ_StructReviewersID_al{PRJ_StructReviewers_atxt}
			PRJ_StructReviewers_atxt:=Find in array:C230(PRJ_StructReviewers_atxt; PRJ_Reviewer_txt)
		End if 
		
End case 
If (False:C215)
	If (Count parameters:C259=3)
		//QUERY([Personnel];[Personnel]Person ID=$ReviewID_ptr->)
		//$Rate_ptr->:=[Personnel]
	End if 
End if 
//End PRJ_ControlReviewerChange
