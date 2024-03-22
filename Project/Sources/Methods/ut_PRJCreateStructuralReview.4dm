//%attributes = {"invisible":true}
// ----------------------------------------------------
//ut_PRJCreateStructuralReview
// User name (OS): cjmiller
// Date and time: 04/28/06, 14:58:11
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //05/09/07, 11:01:59`Add reviewer id
End if 
C_LONGINT:C283($1; $2; $NumberOfReviews_l; $ReviewColumn_l; $PRJ_utReviewerID_L)
C_TEXT:C284($3; $4; $StructureReviewAll_txt; $StructureReviewCol_txt; $StructureReviewApproval_txt)
$ReviewColumn_l:=$1
$NumberOfReviews_l:=$2
$StructureReviewAll_txt:=$3
$StructureReviewCol_txt:=$4
$StructureReviewApproval_txt:=""
If (Count parameters:C259>4)
	C_TEXT:C284($5)
	$StructureReviewApproval_txt:=$5
End if 
If (Count parameters:C259>5)
	C_LONGINT:C283($6)
	$PRJ_utReviewerID_L:=$6
End if 

CREATE RECORD:C68([PRJ_StructuralReview:119])
[PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3:=$NumberOfReviews_l
[PRJ_StructuralReview:119]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
[PRJ_StructuralReview:119]RV_ReviewID_l:2:=$PRJ_utReviewerID_L
If ($ReviewColumn_l=1)
	//Lets get receive date
	If ($StructureReviewAll_txt#"")
		[PRJ_StructuralReview:119]SR_Received_d:7:=ut_PRJReturnEarliestDate($StructureReviewAll_txt)
	End if 
	//lets get to de date
	If ($StructureReviewCol_txt#"")
		[PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4:=ut_PRJReturnEarliestDate($StructureReviewCol_txt)
	End if 
	//[PRJ_StructuralReview]SR_Comments_txt:="Review Column is "+String($ReviewColumn_l)+Char(Carriage return )
	[PRJ_StructuralReview:119]SR_Comments_txt:5:=[PRJ_StructuralReview:119]SR_Comments_txt:5+"To DE is  "+$StructureReviewCol_txt+Char:C90(Carriage return:K15:38)
	[PRJ_StructuralReview:119]SR_Comments_txt:5:=[PRJ_StructuralReview:119]SR_Comments_txt:5+"Approval is  "+$StructureReviewApproval_txt+Char:C90(Carriage return:K15:38)
	
Else 
	If ($StructureReviewCol_txt#"")
		[PRJ_StructuralReview:119]SR_Received_d:7:=ut_PRJReturnEarliestDate($StructureReviewCol_txt)
	End if 
	If ($ReviewColumn_l=$NumberOfReviews_l)
		//[PRJ_StructuralReview]SR_Comments_txt:="Review Column is "+String($ReviewColumn_l)+Char(Carriage return )
		[PRJ_StructuralReview:119]SR_Comments_txt:5:=[PRJ_StructuralReview:119]SR_Comments_txt:5+"Review is  "+$StructureReviewCol_txt+Char:C90(Carriage return:K15:38)
		
	Else 
		[PRJ_StructuralReview:119]SR_Comments_txt:5:="from your review "+String:C10($ReviewColumn_l)+" "
		[PRJ_StructuralReview:119]SR_Comments_txt:5:="to review #  "+String:C10($NumberOfReviews_l)+Char:C90(Carriage return:K15:38)
		[PRJ_StructuralReview:119]SR_Comments_txt:5:=[PRJ_StructuralReview:119]SR_Comments_txt:5+"Review is  "+$StructureReviewCol_txt+Char:C90(Carriage return:K15:38)
		
	End if 
	If ($StructureReviewApproval_txt#"")
		[PRJ_StructuralReview:119]SR_Comments_txt:5:=[PRJ_StructuralReview:119]SR_Comments_txt:5+"Approval is  "+$StructureReviewApproval_txt+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	End if 
End if 
SAVE RECORD:C53([PRJ_StructuralReview:119])
UNLOAD RECORD:C212([PRJ_StructuralReview:119])
//End method  ut_PRJCreateStructuralReview