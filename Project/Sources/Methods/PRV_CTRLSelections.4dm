//%attributes = {"invisible":true}
// Method: PRV_CTRLSelections
// Description
// 
// Parameters
// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT")
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/04/12, 11:24:58
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="LOADALL")
		PRV_CTRLSelections("STR25")
		PRV_CTRLSelections("HWY25")
		PRV_CTRLSelections("STR90")
		PRV_CTRLSelections("HWY75")
		PRV_CTRLSelections("FINALPSE")
		PRV_CTRLSelections("FINALPSEASST")
		PRV_CTRLSelections("ROW")
		PRV_CTRLSelections("ENV")
		PRV_CTRLSelections("TRA")
		PRV_CTRLSelections("CONSTR")
		PRV_CTRLSelections("OTHER")
		PRV_CTRLSelections("FHWA")
		PRV_CTRLSelections("BRIDGES")
		PRV_CTRLSelections("ADDENDUMS")
		PRV_CTRLSelections("INVOICES")
		PRV_CTRLSelections("PUBMTGS")
		PRV_CTRLSelections("CSLTMTGS")
		
	: ($Task_txt="INVOICES")
		QUERY:C277([Invoice_Maintenance:95]; [Invoice_Maintenance:95]AssignID_L:20=[Contract_Assignment_Maintenance:101]AssignID:3)
		//QUERY([Invoice_Maintenance];[Invoice_Maintenance]ContractNo=[Contract_Assignment_Maintenance]ContractNo;*)
		//QUERY([Invoice_Maintenance]; & ;[Invoice_Maintenance]AssignNo=[Contract_Assignment_Maintenance]AssignNo;*)
		
		ORDER BY:C49([Invoice_Maintenance:95]; [Invoice_Maintenance:95]InvoiceNo:2; <)
		
	: ($Task_txt="ADDENDUMS")
		QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AssignID:3=[Contract_Assignment_Maintenance:101]AssignID:3)
		ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2; <)
		
	: ($Task_txt="STR25")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="STR25")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVStrucRev25")
		
	: ($Task_txt="HWY25")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="HWY25")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVHWYRev25")
		
	: ($Task_txt="STR90")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="STR90")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVStrucRev90")
		
	: ($Task_txt="HWY75")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="HWY75")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVHWYRev75")
		
	: ($Task_txt="FINALPSE")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="FINALPSE")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVFinalPSE")
		
	: ($Task_txt="FINALPSEASST")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="FINALPSEASST")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVFinalPSEAsstLdr")
		
	: ($Task_txt="ROW")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="ROW")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVROW_Rev")
		
	: ($Task_txt="ENV")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="ENV")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRV_EnvRev")
		
	: ($Task_txt="TRA")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="TRA")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVTrafficRev")
		
	: ($Task_txt="CONSTR")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="CONSTR")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVConstrRev")
		
	: ($Task_txt="OTHER")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="OTHER")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVOtherRev")
		
	: ($Task_txt="FHWA")
		QUERY:C277([Preservation_Reviews:145]; [Preservation_Reviews:145]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Reviews:145];  & ; [Preservation_Reviews:145]ReviewTYpe_s:3="FHWA")
		ORDER BY:C49([Preservation_Reviews:145]; [Preservation_Reviews:145]Received_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Reviews:145]; "PRVFHWARev")
		
	: ($Task_txt="BRIDGES")
		QUERY:C277([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignID:13=[Contract_Assignment_Maintenance:101]AssignID:3)
		ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]District:8; >; [Contract_Project_Maintenance:100]BridgeNo:4; >; [Contract_Project_Maintenance:100]BIN:5; >)
		
	: ($Task_txt="PUBMTGS")
		QUERY:C277([Preservation_Meetings:148]; [Preservation_Meetings:148]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Meetings:148]; [Preservation_Meetings:148]MeetingType_s:3="PUBLIC")
		ORDER BY:C49([Preservation_Meetings:148]; [Preservation_Meetings:148]MeetingDate_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Meetings:148]; "PRVPUBMTGS")
		
	: ($Task_txt="CSLTMTGS")
		QUERY:C277([Preservation_Meetings:148]; [Preservation_Meetings:148]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3; *)
		QUERY:C277([Preservation_Meetings:148]; [Preservation_Meetings:148]MeetingType_s:3="CSLT")
		ORDER BY:C49([Preservation_Meetings:148]; [Preservation_Meetings:148]MeetingDate_d:4; <)
		CUT NAMED SELECTION:C334([Preservation_Meetings:148]; "PRVCSLTMTGS")
		
	: ($Task_txt="INSPECT")
		READ ONLY:C145([Bridge MHD NBIS:1])
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)
		INSP_UpdateInspList
		
	: ($Task_txt="CLEARALL")
		CLEAR NAMED SELECTION:C333("PRVStrucRev25")
		CLEAR NAMED SELECTION:C333("PRVHWYRev25")
		CLEAR NAMED SELECTION:C333("PRVStrucRev90")
		CLEAR NAMED SELECTION:C333("PRVHWYRev75")
		CLEAR NAMED SELECTION:C333("PRVFinalPSE")
		CLEAR NAMED SELECTION:C333("PRVFinalPSEAsstLdr")
		CLEAR NAMED SELECTION:C333("PRVROW_Rev")
		CLEAR NAMED SELECTION:C333("PRV_EnvRev")
		CLEAR NAMED SELECTION:C333("PRVTrafficRev")
		CLEAR NAMED SELECTION:C333("PRVConstrRev")
		CLEAR NAMED SELECTION:C333("PRVOtherRev")
		CLEAR NAMED SELECTION:C333("PRVFHWARev")
		CLEAR NAMED SELECTION:C333("PRVPUBMTGS")
		CLEAR NAMED SELECTION:C333("PRVCSLTMTGS")
		
End case 