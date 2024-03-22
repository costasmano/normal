If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 11/08/05, 14:03:21
	// ----------------------------------------------------
	// Method: Form Method: SpecialReportSelect
	// Description
	// 
	//
	// Parameters
	//
	//
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(3/27/2007 10:03:13)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(12/23/10 09:58:06)
	Mods_2010_12
	//  `Save the selected item no in a process variable
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(atSR_MethodNames; 0)
		ARRAY TEXT:C222(atSR_ReportNames; 0)
		//set up the title for printing display
		Case of 
			: (vsPurpose="Interoffice Memo")
				vsSpecialReportTitle:="Select a Memo"
				
			: (vsPurpose="Letter to Town")
				vsSpecialReportTitle:="Select a Letter"
				
			: (vsPurpose="Request")
				vsSpecialReportTitle:="Select a Request"
				
			Else   //this case should never happen
				vsSpecialReportTitle:="Select a Report"
		End case 
		
		QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1=vsPurpose)
		If (Records in selection:C76([zSpecialReports:106])>0)
			//fill up the arrays for later use in G_LoadSpecialReports
			SELECTION TO ARRAY:C260([zSpecialReports:106]ReportName:2; atSR_ReportNames)
			SELECTION TO ARRAY:C260([zSpecialReports:106]MethodName:3; atSR_MethodNames)
			
			SELECTION TO ARRAY:C260([zSpecialReports:106]ReportName:2; atSpecialReports)
			SORT ARRAY:C229(atSpecialReports)
			C_LONGINT:C283(SpecialReports_HL)
			SpecialReports_HL:=ut_ArrayToHL(->atSR_ReportNames)  //MODSFORHL
			SORT LIST:C391(SpecialReports_HL)
			
		End if 
		SpecialReportSelected_L:=0
		
	: (Form event code:C388=On Clicked:K2:4)
		SpecialReportSelected_L:=Selected list items:C379(SpecialReports_HL)
		
End case 
//End of method