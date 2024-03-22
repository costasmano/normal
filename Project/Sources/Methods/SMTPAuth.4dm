//%attributes = {"invisible":true}
// ----------------------------------------------------
// SMTPAuth
// User name (OS): cjmiller
// Date and time: 05/09/05, 10:35:31
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	Mods_2006_CMy4
	// Modified by: costasmanousakis-(Designer)-(5/29/2007 15:09:16)
	Mods_2007_CM10a
	Mods_2010_02  //r001 CJ Miller`02/11/10, 15:27:03      `Remove port change SMTPPORT_L to 1313
End if 
C_LONGINT:C283($1; $smtp_id)
$smtp_id:=$1
C_BOOLEAN:C305($0)
$0:=True:C214

If (AuthUserName_txt#"")
	
	If (Not:C34(mail_ErrorCheck("SMTP_Auth"; SMTP_Auth($smtp_id; AuthUserName_txt; AuthPassword_txt; 0))))
		$0:=False:C215
	End if 
End if 

//End SMTPAuth