If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(9/7/16 17:36:55)
	Mods_2016_09
	//  `added
End if 

C_TEXT:C284(vRemarks)
vRemarks:=""
If (Length:C16([TIN_Inspections:184]InspReviewComments:17)>0)
	vRemarks:="DTIE COMMENTS:"+<>sCR+[TIN_Inspections:184]InspReviewComments:17+<>sCR+<>sCR
	
End if 
If (Length:C16([TIN_Inspections:184]InspApproveComments:16)>0)
	vRemarks:=vRemarks+"TUNNEL ENGINEER COMMENTS:"+<>sCR+[TIN_Inspections:184]InspApproveComments:16
	
End if 
If (vRemarks#"")
	G_PrintOptions
	//_O_PAGE SETUP([TIN_Inspections]; "ReviewComments")
	FORM SET OUTPUT:C54([TIN_Inspections:184]; "ReviewComments")
	PRINT RECORD:C71([TIN_Inspections:184]; *)
	FORM SET OUTPUT:C54([TIN_Inspections:184]; "Output")
Else 
	ALERT:C41("No Review Comments available!!!")
End if 
