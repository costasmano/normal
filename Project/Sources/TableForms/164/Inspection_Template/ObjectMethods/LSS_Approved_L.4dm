
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 15:23:18
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory];"Input".LSS_Approved_L
//Description [LSS_Inspection];"Inspection_Template".LSS_Approved_L
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
End if 

C_BOOLEAN:C305($UpdateAllowed_B)
$UpdateAllowed_B:=(LSS_AllowInspectionEdit_B) & (Not:C34(Read only state:C362([LSS_Inspection:164]))) & ([LSS_Inspection:164]LSS_Approved_L:43=BMS Rejected)

If ($UpdateAllowed_B)
	
	LSS_Page_l:=2
	C_LONGINT:C283($Width_L; $Height_L)
	FORM GET PROPERTIES:C674("LSS_InspectionApproval"; $Width_L; $Height_L)
	ut_OpenNewWindow($Width_l; $Height_l; 14; Plain window:K34:13; "Reject Notes"; "ut_CloseCancel")
	
	DIALOG:C40("LSS_InspectionApproval")
	CLOSE WINDOW:C154
Else 
	
	ut_MessageDia([LSS_Inspection:164]LSS_ApprovalComments_txt:49; "Reject Notes")
	
End if 

//End Object Method: [LSS_Inventory].Input.LSS_Approved_L

