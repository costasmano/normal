// ----------------------------------------------------
// Object Method: Button2
// User name (OS): cjmiller
// Date and time: 04/26/07, 11:28:00
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
QR GET DESTINATION:C756(Report_Area_l; $ReportType_l)
Case of 
	: ($ReportType_l=qr printer:K14903:1)
		OBJECT SET TITLE:C194(*; "Button2"; "Set To Print")
		QR SET DESTINATION:C745(Report_Area_l; qr text file:K14903:2)
		OBJECT SET TITLE:C194(*; "Button3"; "Generate")
	: ($ReportType_l=qr text file:K14903:2)
		OBJECT SET TITLE:C194(*; "Button2"; "Set To Export")
		QR SET DESTINATION:C745(Report_Area_l; qr printer:K14903:1)
		OBJECT SET TITLE:C194(*; "Button3"; "Print")
	Else 
		C_LONGINT:C283($ReportType_l)
		QR SET DESTINATION:C745(Report_Area_l; qr printer:K14903:1)
		OBJECT SET TITLE:C194(*; "Button2"; "Set To Export")
		OBJECT SET TITLE:C194(*; "Button3"; "Print")
End case 
//End Object Method: Button2