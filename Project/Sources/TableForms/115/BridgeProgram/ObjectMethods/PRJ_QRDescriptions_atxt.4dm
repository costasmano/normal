If (False:C215)
	//Object Method: PRJ_QRDescriptions_atxt 
	// Mods_2007_CM12_5301 10/02/07
	Mods_2009_03  //CJM  r001   `03/06/09, 12:44:33`Upgrade from open form window to open window
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (PRJ_QRDescriptions_atxt>1)
			C_LONGINT:C283(Report_DefaultTableNumber_l; Report_SortList_l; Report_FieldsList_l; Report_Area_l)
			Report_DefaultTableNumber_l:=Table:C252(->[PRJ_ProjectDetails:115])
			If (PRJ_QRDescriptions_atxt=2)
				QR REPORT:C197([PRJ_ProjectDetails:115]; Char:C90(1); True:C214; True:C214; True:C214)
			Else 
				QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=PRJ_QuickReports_atxt{PRJ_QRDescriptions_atxt})
				
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
		PRJ_QRDescriptions_atxt:=0
		
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(PRJ_QRDescriptions_atxt; 0)
		ARRAY TEXT:C222(PRJ_QuickReports_atxt; 0)
		QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1="BridgeProgram")
		ORDER BY:C49([zSpecialReports:106]; [zSpecialReports:106]SubCategory:5; >; [zSpecialReports:106]ReportName:2; >)
		SELECTION TO ARRAY:C260([zSpecialReports:106]ReportName:2; PRJ_QRDescriptions_atxt; [zSpecialReports:106]MethodName:3; PRJ_QuickReports_atxt)
		Report_SetUp
		INSERT IN ARRAY:C227(PRJ_QRDescriptions_atxt; 0; 2)
		PRJ_QRDescriptions_atxt{1}:="Select Option"
		PRJ_QRDescriptions_atxt{2}:="Custom Quick Report"
		INSERT IN ARRAY:C227(PRJ_QuickReports_atxt; 0; 2)
		PRJ_QuickReports_atxt{1}:=""
		PRJ_QuickReports_atxt{2}:=""
		Case of 
			: (<>PL_LPlatfrm=Windows:K25:3)
				OBJECT MOVE:C664(Self:C308->; 0; 0; -10; 0)
			Else 
				
		End case 
		
	: (Form event code:C388=On Data Change:K2:15)
		
End case 
