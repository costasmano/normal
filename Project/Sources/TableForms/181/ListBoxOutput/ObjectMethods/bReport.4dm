//Method: [NTI_TunnelInfo];"ListBoxOutput".bReport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/25/18, 11:14:36
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 18:06:32)
	Mods_2022_06
	//  `added option to Generate a Quick report to Excel
End if 
//
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($ReportOptions_txt)
		$ReportOptions_txt:="Quick report;NTIED Report;Generate a Quick report to Excel"
		C_LONGINT:C283($Choice_L)
		$Choice_L:=Pop up menu:C542($ReportOptions_txt)
		Case of 
			: ($Choice_L=1)
				QR REPORT:C197(Current form table:C627->; Char:C90(1))
			: ($Choice_L=2)
				CONFIRM:C162("Print NTIED Report on "+String:C10(Records in set:C195("UserSet"))+" selected records, or "+String:C10(Records in selection:C76([NTI_TunnelInfo:181]))+" Displayed records"; "Selected"; "Displayed")
				If (OK=1)
					USE SET:C118("UserSet")
					TIN_PrintNTIEDReports
					USE NAMED SELECTION:C332("NTI_TunnelInfoSet")
					
				Else 
					
					TIN_PrintNTIEDReports
					
				End if 
				
			: ($Choice_L=3)
				QR_RunReportToExcel(Current form table:C627)
		End case 
		
End case 
//End [NTI_TunnelInfo].ListBoxOutput.bReport