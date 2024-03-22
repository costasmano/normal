If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/08/07, 14:19:44
	// ----------------------------------------------------
	// Method: Form Method: ProjisUpdate
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		PRJ_LoadPage_0
		C_TEXT:C284(PRJ_ProjExpeditorShort_txt)
		PRJ_RoadwayOver_txt:=Replace string:C233(PRJ_RoadwayOver_txt; "  "; "")
		PRJ_ProjExpeditorShort_txt:=Substring:C12([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; 1; (Position:C15(":"; [PRJ_ProjectFile:117]PF_ProjectExpediter_s:6)-1))
		PRJ_ProjExpeditorShort_txt:=PRJ_ProjExpeditorShort_txt+Substring:C12([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; (Length:C16([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6)-3))
		If ([PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43#"")
			PRJ_PrintEWO_txt:=[PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43
		Else 
			PRJ_PrintEWO_txt:=[PRJ_ProjectFile:117]PF_EWO_s:4
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(PRJ_PrintEWO_txt; vPageNum)
		C_DATE:C307(vDate)
	: (Form event code:C388=On Header:K2:17)
End case 
