//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: SMTPAddHeaders
// User name (OS): charlesmiller
// Date and time: 02/11/10, 11:18:28
// ----------------------------------------------------
// Description
// This method controls addition of mail headers. It assumes an array named MAILHeaderTypes_atxt is declared. If 0 size no headers
//It also needs array named MAILHeaderValues_atxt
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_02  //r001 CJ Miller`02/11/10, 11:18:30      ``Add methods to control sending of email
End if 
C_BOOLEAN:C305($0; $Status_b)

$Status_b:=True:C214
C_LONGINT:C283($Loop_l; $SMTPID_l; $1)
$SMTPID_l:=$1

For ($Loop_l; 1; Size of array:C274(MAILHeaderTypes_atxt))
	
	If (Not:C34(mail_ErrorCheck("SMTP_AddHeader"; SMTP_AddHeader($SMTPID_l; MAILHeaderTypes_atxt{$Loop_l}; MAILHeaderValues_atxt{$Loop_l}; 0))))
		$Status_b:=False:C215
		$Loop_l:=Size of array:C274(MAILHeaderTypes_atxt)+1
	End if 
End for 
$0:=$Status_b

//End Method: SMTPAddHeaders