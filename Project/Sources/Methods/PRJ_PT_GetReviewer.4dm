//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/22/07, 19:44:25
	// ----------------------------------------------------
	// Method: PRJ_PT_GetReviewer
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 

C_TEXT:C284(PRJ_Reviewer_txt)
C_LONGINT:C283($PersIndx_L)
$PersIndx_L:=Find in array:C230(aPeople_ID; [PRJ_ProjectTimeTracking:124]Person ID:3)
If ($PersIndx_L>0)
	PRJ_Reviewer_txt:=aPeople{$PersIndx_L}
Else 
	PRJ_Reviewer_txt:="Unknown Reviewer"
End if 
