
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 15:33:34
//----------------------------------------------------
//Method: Object Method: LSS_InspectionApproval.vbAccept
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
ACCEPT:C269

//End Object Method: LSS_InspectionApproval.vbAccept

