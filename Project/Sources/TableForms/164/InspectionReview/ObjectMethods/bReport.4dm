If (False:C215)
	//[LSS_Inspection];"InspectionReview".bReport
	
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 19:00:21)
	Mods_2022_06
	//  // code to enable sending a quick report to excel
	//  // added help tip "Quick Report editor ; click on arrow for more options."
	
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		QR REPORT:C197(Current form table:C627->; Char:C90(1))
		//USE NAMED SELECTION("InventorySet")
	: (Form event code:C388=On Alternative Click:K2:36)
		C_TEXT:C284($text)
		$text:="Quick Report Editor;Built Reports;Generate Quick report to Excel"
		C_LONGINT:C283($selectedItem)
		$selectedItem:=Pop up menu:C542($text)
		Case of 
			: ($selectedItem=1)
				QR REPORT:C197(Current form table:C627->; Char:C90(1))
				//USE NAMED SELECTION("InventorySet")
			: ($selectedItem=2)
				C_TEXT:C284($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
				$func_txt:="AncillaryInspRevRpt"
				
				READ ONLY:C145([Templates:86])
				READ ONLY:C145([zSpecialReports:106])
				QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1=$func_txt)
				If (Records in selection:C76([zSpecialReports:106])=0)
					ALERT:C41("No Preloaded reports found!")
				Else 
					$Title_txt:="Select a Report"
					$Okbtn_txt:=""  //use the default
					$IconName_txt:="OSX report"
					
					TMPL_Do_Template_Choise($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
				End if 
				
			: ($selectedItem=3)
				QR_RunReportToExcel(Current form table:C627)
				
		End case 
		
		
End case 