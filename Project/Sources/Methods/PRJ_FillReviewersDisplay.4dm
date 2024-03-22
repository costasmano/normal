//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_FillReviewersDisplay
// User name (OS): cjmiller
// Date and time: 01/27/06, 13:32:18
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 pointer to table
//$2 longint value to search with

// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //03/15/07, 12:37:25  `Change name from Reviewers to StructReviewers
	// Modified by: costasmanousakis-(Designer)-(8/23/2007 14:41:28)
	Mods_2007_CM12_5301
End if 
C_POINTER:C301($1; $Table_ptr)
C_LONGINT:C283($2; $ReviewerID_l)
$Table_ptr:=$1
$ReviewerID_l:=$2
PRJ_Reviewer_txt:=""
PRJ_StructReviewersID_al:=0
PRJ_StructReviewers_atxt:=0
PRJ_StructReviewersID_al:=Find in array:C230(PRJ_StructReviewersID_al; $ReviewerID_l)
If (PRJ_StructReviewersID_al<1)
	PRJ_Reviewer_txt:="None Selected"
	If (Record number:C243($Table_ptr->)=New record:K29:1)
	End if 
Else 
	PRJ_StructReviewers_atxt:=PRJ_StructReviewersID_al
	PRJ_Reviewer_txt:=PRJ_StructReviewers_atxt{PRJ_StructReviewers_atxt}
End if 

//End PRJ_FillReviewersDisplay