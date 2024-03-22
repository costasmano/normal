// ----------------------------------------------------
// Form Method: QR_Dialog
// User name (OS): cjmiller
// Date and time: 04/19/07
// ----------------------------------------------------
// Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	Mods_2007_CJMv2  //04/26/07, 11:53:28
	// Modified by: costasmanousakis-(Designer)-(9/26/2007 10:37:13)
	Mods_2007_CM12_5301  //Assign table AFTER loading template
	// Modified by: Costas Manousakis-(Designer)-(2022-06-07 14:14:51)
	Mods_2022_06
	//  `initialize report area on load
	//  `delete the delete column and Header buttons on the form.
	//  `enable contextual menus on the report area
	//  // disable on Load event on the Report_area_l object on the form
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		QR NEW AREA:C1320(->Report_Area_l)
		If (Records in selection:C76([Templates:86])=1)
			QR BLOB TO REPORT:C771(Report_Area_l; [Templates:86]Template_:3)
		End if 
		QR SET REPORT TABLE:C757(Report_Area_l; Report_DefaultTableNumber_l)
		REDRAW WINDOW:C456
		Report_Gen_BuildFieldsList(->Report_FieldsList_l)
		C_LONGINT:C283($ReportType_l)
		QR GET DESTINATION:C756(Report_Area_l; $ReportType_l)
		Case of 
			: ($ReportType_l=qr printer:K14903:1)
				OBJECT SET TITLE:C194(*; "Button2"; "Set To Export")
				OBJECT SET TITLE:C194(*; "Button3"; "Print")
			: ($ReportType_l=qr text file:K14903:2)
				OBJECT SET TITLE:C194(*; "Button2"; "Set To Print")
				OBJECT SET TITLE:C194(*; "Button3"; "Generate")
			Else 
				C_LONGINT:C283($ReportType_l)
				QR SET DESTINATION:C745(Report_Area_l; qr printer:K14903:1)
				OBJECT SET TITLE:C194(*; "Button2"; "Set To Export")
				OBJECT SET TITLE:C194(*; "Button3"; "Print")
		End case 
		QR SET AREA PROPERTY:C796(Report_Area_l; qr view contextual menus:K14905:7; 1)
		//QR ON COMMAND(Report_Area_l;"QR_HandleCommand")
		
		
	: (Form event code:C388=On Outside Call:K2:11)
		C_LONGINT:C283($ReportType_l)
		QR GET DESTINATION:C756(Report_Area_l; $ReportType_l)
		Case of 
			: ($ReportType_l=qr printer:K14903:1)
				OBJECT SET TITLE:C194(*; "Button2"; "Set To Export")
				OBJECT SET TITLE:C194(*; "Button3"; "Print")
			: ($ReportType_l=qr text file:K14903:2)
				OBJECT SET TITLE:C194(*; "Button2"; "Set To Print")
				OBJECT SET TITLE:C194(*; "Button3"; "Generate")
			Else 
				C_LONGINT:C283($ReportType_l)
				QR SET DESTINATION:C745(Report_Area_l; qr printer:K14903:1)
				OBJECT SET TITLE:C194(*; "Button2"; "Set To Export")
				OBJECT SET TITLE:C194(*; "Button3"; "Print")
		End case 
		
End case 
//End Form Method: QR_Dialog