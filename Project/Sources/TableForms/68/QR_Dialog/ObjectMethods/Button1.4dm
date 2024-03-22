// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 04/26/07, 11:04:18
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
QR EXECUTE COMMAND:C791(Report_Area_l; qr cmd new:K14900:18)
OBJECT SET TITLE:C194(*; "Button2"; "Set To Print")
QR SET DESTINATION:C745(Report_Area_l; qr printer:K14903:1)

//End Object Method: Button1