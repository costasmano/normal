If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/07, 12:05:55
	// ----------------------------------------------------
	// Method: Form Method: Summary
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		WKHR_SummarizeEstimate("INITVARS")
		
		WKHR_SummarizeEstimate("TOTALASSIGN")
		SET QUERY DESTINATION:C396(Into set:K19:2; "WKHR_RELATEDADDENDUMSET")
		QUERY:C277([Work_Estimate:103]; [Work_Estimate:103]ContractNo:3=[Work_Estimate:103]ContractNo:3; *)
		QUERY:C277([Work_Estimate:103];  & ; [Work_Estimate:103]AssignNo:16=[Work_Estimate:103]AssignNo:16; *)
		QUERY:C277([Work_Estimate:103];  & ; [Work_Estimate:103]WkHrEstApproved:18=BMS Approved; *)
		QUERY:C277([Work_Estimate:103];  & ; [Work_Estimate:103]AddendumNo:29>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (Records in set:C195("WKHR_RELATEDADDENDUMSET")>0)
			CUT NAMED SELECTION:C334([Work_Estimate:103]; "WKHR_WORKHOURLIST")
			USE SET:C118("WKHR_RELATEDADDENDUMSET")
			C_LONGINT:C283($i)
			FIRST RECORD:C50([Work_Estimate:103])
			For ($i; 1; Records in selection:C76([Work_Estimate:103]))
				WKHR_SummarizeEstimate("TOTALASSIGN")
				NEXT RECORD:C51([Work_Estimate:103])
			End for 
			USE NAMED SELECTION:C332("WKHR_WORKHOURLIST")
		End if 
		CLEAR SET:C117("WKHR_RELATEDADDENDUMSET")
		WKHR_SummarizeEstimate("ACCUMULATE")
		
	: (Form event code:C388=On Printing Break:K2:19)
		WKHR_SummarizeEstimate("AVERAGECONS")
		
	: (Form event code:C388=On Printing Footer:K2:20)
		WKHR_SummarizeEstimate("AVERAGETOTAL")
		
End case 