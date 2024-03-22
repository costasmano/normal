
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 15:42:57
//----------------------------------------------------
//Method: Object Method: LSS_InspectionApproval.vbReject
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
End if 
If ([LSS_Inspection:164]LSS_ApprovalComments_txt:49="")
	[LSS_Inspection:164]LSS_ApprovalComments_txt:49:=<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
Else 
	[LSS_Inspection:164]LSS_ApprovalComments_txt:49:=<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments+<>sCR+<>sCR+[LSS_Inspection:164]LSS_ApprovalComments_txt:49  //copy comments
End if 
[LSS_Inspection:164]LSS_Approved_L:43:=BMS Rejected
[LSS_Inspection:164]LSS_ApprovedDate_d:44:=!00-00-00!
[LSS_Inspection:164]LSS_Complete_b:39:=False:C215
[LSS_Inspection:164]LSS_CompleteDate_d:40:=!00-00-00!
LSS_InspectionRecSave
LSS_SendAcceptRejectEmail

VALIDATE TRANSACTION:C240
ACCEPT:C269

//End Object Method: LSS_InspectionApproval.vbReject

