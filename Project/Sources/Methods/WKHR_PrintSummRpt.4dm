//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/07, 12:03:10
	// ----------------------------------------------------
	// Method: WKHR_PrintSummRpt
	// Description
	// Print a summary report of work hours
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
COPY NAMED SELECTION:C331([Work_Estimate:103]; "TEMPWORKESTSELE")
QUERY SELECTION:C341([Work_Estimate:103]; [Work_Estimate:103]AddendumNo:29=0)
ORDER BY:C49([Work_Estimate:103]; [Work_Estimate:103]Consultant:6; >; [Work_Estimate:103]ContractNo:3; >; [Work_Estimate:103]AssignNo:16; >)
WKHR_InitVars
WKHR_InitSummaryVars
BREAK LEVEL:C302(1)
ACCUMULATE:C303([Work_Estimate:103]Cat1Rate:7)
FORM SET OUTPUT:C54([Work_Estimate:103]; "Summary")
PRINT SELECTION:C60([Work_Estimate:103])
FORM SET OUTPUT:C54([Work_Estimate:103]; "List")
USE NAMED SELECTION:C332("TEMPWORKESTSELE")
CLEAR NAMED SELECTION:C333("TEMPWORKESTSELE")