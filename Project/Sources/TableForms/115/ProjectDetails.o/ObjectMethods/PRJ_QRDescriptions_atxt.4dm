// ----------------------------------------------------
// Object Method: PRJ_QRDescriptions_atxt
// User name (OS): cjmiller
// Date and time: 03/22/07, 15:59:06
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/06/09, 12:48:07`Upgrade from open form window to open window
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		C_LONGINT:C283(Report_DefaultTableNumber_l; Report_SortList_l; Report_FieldsList_l; Report_Area_l)
		Report_DefaultTableNumber_l:=Table:C252(->[PRJ_ProjectDetails:115])
		If (PRJ_QRDescriptions_atxt>1)
			If (PRJ_QRDescriptions_atxt=2)
				QR REPORT:C197([PRJ_ProjectDetails:115]; Char:C90(1); True:C214; True:C214; True:C214)
			Else 
				QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=PRJ_QuickReports_atxt{PRJ_QRDescriptions_atxt})
				//GET FORM PROPERTIES([zDialogs];"QR_Dialog";$Width_l;$Height_l)
				C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
				C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
				C_TEXT:C284($Title_txt)
				FORM GET PROPERTIES:C674([zDialogs:68]; "QR_Dialog"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
				$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
				//$win:=Open form window([zDialogs];"QR_Dialog";Regular window )
				DIALOG:C40([zDialogs:68]; "QR_Dialog")
				CLOSE WINDOW:C154($Win_l)
			End if 
		End if 
		PRJ_QuickReports_atxt:=1
	: (Form event code:C388=On Load:K2:1)
		Report_SetUp
		QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1="ProjectDetails.o")
		ORDER BY:C49([zSpecialReports:106]; [zSpecialReports:106]SubCategory:5; >; [zSpecialReports:106]ReportName:2; >)
		SELECTION TO ARRAY:C260([zSpecialReports:106]ReportName:2; PRJ_QRDescriptions_atxt; [zSpecialReports:106]MethodName:3; PRJ_QuickReports_atxt)
		
		
		INSERT IN ARRAY:C227(PRJ_QRDescriptions_atxt; 0; 2)
		PRJ_QRDescriptions_atxt{1}:="Select Quick Report"
		
		PRJ_QRDescriptions_atxt{2}:="Custom"
		
		PRJ_QRDescriptions_atxt:=1
		INSERT IN ARRAY:C227(PRJ_QuickReports_atxt; 0; 2)
		PRJ_QuickReports_atxt{1}:=""
		
		PRJ_QuickReports_atxt{2}:=""
		
		PRJ_QuickReports_atxt:=1
End case 
//End Object Method: PRJ_QuickReports_atxt