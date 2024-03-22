//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_SMTP_AddHeader
// User name (OS): charlesmiller
// Date and time: 11/19/08, 11:37:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
//$1 smpt id
//$2 is descirption of header
//$3 is value of the header
If (False:C215)
	
End if 
C_BOOLEAN:C305($0)
C_LONGINT:C283($1; $SmtpId_l)
$SmtpId_l:=$1
C_BOOLEAN:C305($0)
$0:=True:C214
C_TEXT:C284($2; $3)

If ($3#"")
	
	If (Not:C34(mail_ErrorCheck("SMTP_AddHeader"; SMTP_AddHeader($SmtpId_l; $2; $3; 0))))
		$0:=False:C215
	End if 
End if 

//End ut_SMTP_AddHeader