//%attributes = {"invisible":true}
//G_PrintReviewCmnts 
//Print the Review comments for the current inspection.
If (False:C215)
	// ----------------------------------------------------
	// G_PrintReviewCmnts
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:11:46
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 16:11:55 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:22:24)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(5/16/13 13:15:54)
	Mods_2013_05
	//  `adjust titles for MBTA
End if 

C_TEXT:C284(vRemarks)
vRemarks:=""
If (Length:C16([Inspections:27]InspRevCmts:170)>0)
	
	If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
		vRemarks:="QC ENGINEER COMMENTS:"+<>sCR+[Inspections:27]InspRevCmts:170+<>sCR+<>sCR
	Else 
		vRemarks:="DBIE COMMENTS:"+<>sCR+[Inspections:27]InspRevCmts:170+<>sCR+<>sCR
	End if 
	
End if 
If (Length:C16([Inspections:27]InspApprCmts:169)>0)
	If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
		vRemarks:=vRemarks+"QA ENGINEER COMMENTS:"+<>sCR+[Inspections:27]InspApprCmts:169
	Else 
		vRemarks:=vRemarks+"AREA ENGINEER COMMENTS:"+<>sCR+[Inspections:27]InspApprCmts:169
	End if 
End if 
If (vRemarks#"")
	G_PrintOptions
	//PAGE SETUP([Inspections];"Routine Remarks")
	//SET PRINT PREVIEW(True)
	FORM SET OUTPUT:C54([Inspections:27]; "Routine Remarks")
	PRINT RECORD:C71([Inspections:27]; *)
	FORM SET OUTPUT:C54([Inspections:27]; "InspectionReview")
Else 
	ALERT:C41("No Review Comments available!!!")
End if 
//End G_PrintReviewCmnts
