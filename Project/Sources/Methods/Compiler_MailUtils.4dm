//%attributes = {"invisible":true}
//Method: Compiler_MailUtils
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/10/13, 08:09:27
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(11/18/15 17:50:04)
	Mods_2015_11
	//  `added MAIL_scriptOutlook
	// Modified by: Costas Manousakis-(Designer)-(11/7/16 17:11:11)
	Mods_2016_11
	//  `added $0 param to MAIL_scriptOutlook
	// Modified by: Costas Manousakis-(Designer)-(11/9/16 16:12:41)
	Mods_2016_11
	//  `added MAIL_ParseAddress
End if 
//
ARRAY TEXT:C222(MAILAttachments_atxt; 0)
ARRAY TEXT:C222(MailBody_atxt; 0)
ARRAY TEXT:C222(MAILHeaderTypes_atxt; 0)
ARRAY TEXT:C222(MAILHeaderValues_atxt; 0)

C_BOOLEAN:C305(<>SHOWERRORS)
C_BOOLEAN:C305(bMailPriority_b)
C_TEXT:C284(<>pref_SMTP)
C_TEXT:C284(AuthPassword_txt)
C_TEXT:C284(AuthUserName_txt)
C_TEXT:C284(tbCCBuilt)
C_TEXT:C284(tCCBuilt_txt)
C_TEXT:C284(tFromEmailAddress)
C_TEXT:C284(tMailNote)
C_TEXT:C284(tSubject)
C_TEXT:C284(tToBuilt_txt)
C_TEXT:C284(vErrorMsg)

If (False:C215)
	
	C_BOOLEAN:C305(mail_ErrorCheck; $0)
	C_TEXT:C284(mail_ErrorCheck; $1)
	C_REAL:C285(mail_ErrorCheck; $2)
	
	C_BOOLEAN:C305(SMTPAuth; $0)
	C_LONGINT:C283(SMTPAuth; $1)
	
	C_BOOLEAN:C305(SMTPAttachments; $0)
	C_LONGINT:C283(SMTPAttachments; $1)
	
	C_BOOLEAN:C305(SMTPAddHeaders; $0)
	C_LONGINT:C283(SMTPAddHeaders; $1)
	
	C_BOOLEAN:C305(mail_testSend; $0)
	
	C_BOOLEAN:C305(mail_ValidateEmail; $0)
	C_TEXT:C284(mail_ValidateEmail; $1)
	C_POINTER:C301(mail_ValidateEmail; $2)
	C_POINTER:C301(mail_ValidateEmail; $3)
	
	C_BOOLEAN:C305(ut_SendEmail; $0)
	C_TEXT:C284(ut_SendEmail; $1)
	C_TEXT:C284(ut_SendEmail; $2)
	C_TEXT:C284(ut_SendEmail; $3)
	C_TEXT:C284(ut_SendEmail; $4)
	C_TEXT:C284(ut_SendEmail; $5)
	C_TEXT:C284(ut_SendEmail; $6)
	C_BOOLEAN:C305(ut_SendEmail; $7)
	
	C_BOOLEAN:C305(ut_SMTP_AddHeader; $0)
	C_LONGINT:C283(ut_SMTP_AddHeader; $1)
	C_TEXT:C284(ut_SMTP_AddHeader; $2)
	C_TEXT:C284(ut_SMTP_AddHeader; $3)
	
	C_BOOLEAN:C305(ut_ControlSendMail; $0)
	C_TEXT:C284(ut_ControlSendMail; $1)
	
	C_TEXT:C284(MAIL_scriptOutlook; $0)
	C_POINTER:C301(MAIL_scriptOutlook; $1)
	C_POINTER:C301(MAIL_scriptOutlook; $2)
	C_TEXT:C284(MAIL_scriptOutlook; $3)
	C_TEXT:C284(MAIL_scriptOutlook; $4)
	C_POINTER:C301(MAIL_scriptOutlook; $5)
	
	C_TEXT:C284(MAIL_ParseAddress; $1)
	C_POINTER:C301(MAIL_ParseAddress; $2)
	C_POINTER:C301(MAIL_ParseAddress; $3)
	
End if 

//End Compiler_MailUtils