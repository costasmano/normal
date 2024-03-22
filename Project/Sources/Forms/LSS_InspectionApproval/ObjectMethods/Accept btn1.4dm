//Method: Object Method: "LSS_InspectionApproval".Accept btn1
If (False:C215)
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 11/10/15, 15:33:34
	//----------------------------------------------------
	//Description
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	// Modified by: Costas Manousakis-(Designer)-(9/18/20 18:11:47)
	Mods_2020_09_bug
	//  `save any comments if they were entered in the review dialog. Call Reference #747
End if 

vtRevComments:=f_TrimStr(vtRevComments; True:C214; True:C214)  //trim leading/trailing spaces/tabs etc
If (vtRevComments#"")
	If ([LSS_Inspection:164]LSS_ApprovalComments_txt:49="")
		[LSS_Inspection:164]LSS_ApprovalComments_txt:49:="Comments upon Approval : "+<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
	Else 
		[LSS_Inspection:164]LSS_ApprovalComments_txt:49:="Comments upon Approval : "+<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments+Char:C90(13)+Char:C90(13)+[LSS_Inspection:164]LSS_ApprovalComments_txt:49  //copy comments
	End if 
End if 
[LSS_Inspection:164]LSS_Approved_L:43:=BMS Approved
[LSS_Inspection:164]LSS_ApprovedDate_d:44:=Current date:C33(*)
LSS_InspectionRecSave
LSS_SendAcceptRejectEmail
VALIDATE TRANSACTION:C240
ACCEPT:C269

//End Object Method: "LSS_InspectionApproval".Accept btn1