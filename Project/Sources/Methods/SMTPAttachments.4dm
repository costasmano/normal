//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: SMTPAttachments
// This method controls addition of attachments. It assumes an array named MAILAttachments_atxt is declared. If 0 size no attachment
// Parameters
// $0 : SentStatus_b
// ----------------------------------------------------
If (False:C215)
	// User name (OS): charlesmiller
	// Date and time: 02/11/10, 11:11:42
	// ----------------------------------------------------
	// Description
	Mods_2010_02  //r001 CJ Miller`02/11/10, 11:11:44      `
	// Modified by: Costas Manousakis-(Designer)-(1/27/20 11:04:54)
	Mods_2020_01
	//  `if array MAILAttachments_atxt is not declared, declare it.
End if 
C_BOOLEAN:C305($0; $Status_b)

$Status_b:=True:C214
C_LONGINT:C283($Loop_l; $SMTPID_l; $1)
$SMTPID_l:=$1
If (Type:C295(MAILAttachments_atxt)#Text array:K8:16)
	ARRAY TEXT:C222(MAILAttachments_atxt; 0)
End if 
For ($Loop_l; 1; Size of array:C274(MAILAttachments_atxt))
	If (Not:C34(mail_ErrorCheck("SMTP_Attachment"; SMTP_Attachment($SMTPID_l; MAILAttachments_atxt{$Loop_l}; 2; 0))))  //encode base64=2
		$Status_b:=False:C215
		$Loop_l:=Size of array:C274(MAILAttachments_atxt)+1
	End if 
End for 
$0:=$Status_b
//End Method: SMTPAttachments