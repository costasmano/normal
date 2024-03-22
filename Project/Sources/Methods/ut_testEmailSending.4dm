//%attributes = {"invisible":true}
//Method: ut_testEmailSending
//Description
//  ` Perform a test of sending email.  Can change the SMTP server.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/17/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_04
	// Modified by: Costas Manousakis-(Designer)-(11/2/15 10:18:46)
	Mods_2015_11
	//  `Added option for timeout ; include some information in the bosy of the msg; display the message body before sending.
	// Modified by: Costas Manousakis-(Designer)-(2022-04-19 17:40:33)
	Mods_2022_04
	//  `added creating Outlook email if set in preferences.
End if 
//
ut_ControlSendMail("INIT")
tFromEmailAddress:=Request:C163("Enter From email address"; <>PERS_MyEmail_txt)
tToBuilt_txt:=Request:C163("Enter To email address"; <>PERS_MyEmail_txt)
tCCBuilt_txt:=Request:C163("Enter CC email"; "")
tSubject:=Request:C163("Enter subject"; "Test Email")
tMailNote:=Request:C163("Enter Mail content"; "Did you get this?")
C_TEXT:C284($CurrSmtp_txt)
$CurrSmtp_txt:=<>pref_SMTP
<>pref_SMTP:=Request:C163("Specify email server"; <>pref_SMTP)
C_LONGINT:C283($err_L; $Timeout_L; $SetTimeout_L)
$err_L:=IT_GetTimeOut($Timeout_L)
C_TEXT:C284($user_txt; $myIP_txt; $mySub_txt)
$err_L:=IT_MyTCPAddr($myIP_txt; $mySub_txt)
$user_txt:=Request:C163("Enter new time out"; String:C10($Timeout_L))
$err_L:=IT_SetTimeOut(Num:C11($user_txt))
$err_L:=IT_GetTimeOut($SetTimeout_L)
tMailNote:=tMailNote+Char:C90(13)+"from : "+tFromEmailAddress
tMailNote:=tMailNote+Char:C90(13)+"to : "+tToBuilt_txt
tMailNote:=tMailNote+Char:C90(13)+"CC : "+tCCBuilt_txt
tMailNote:=tMailNote+Char:C90(13)+"SMTP : "+<>pref_SMTP
tMailNote:=tMailNote+Char:C90(13)+"Req Timeout : "+$user_txt
tMailNote:=tMailNote+Char:C90(13)+"Set Timeout : "+String:C10($SetTimeout_L)
tMailNote:=tMailNote+Char:C90(13)+"My IP : "+$myIP_txt
tMailNote:=tMailNote+Char:C90(13)+"Subnet : "+$mySub_txt

C_BOOLEAN:C305($oldShowErr_b)
$oldShowErr_b:=<>SHOWERRORS
<>SHOWERRORS:=True:C214
ut_BigAlert("Message sent :"+Char:C90(13)+tMailNote)

If (<>EmailMethod#"Outlook")
	SHORT_MESSAGE("Sending email...")
	If (ut_ControlSendMail)
		CLOSE WINDOW:C154
		ALERT:C41("Mail was sent OK")
	Else 
		CLOSE WINDOW:C154
		ALERT:C41("Error sending the email!")
	End if 
	
Else 
	ALERT:C41("Creating Outlook email")
	C_TEXT:C284(tToBuilt_txt; tCCBuilt_txt; vTextMsg; $res_txt)
	ARRAY TEXT:C222($To_atxt; 0)
	ARRAY TEXT:C222($CC_atxt; 0)
	ut_TextToArray(tToBuilt_txt; ->$To_atxt; ",")
	ut_TextToArray(tCCBuilt_txt; ->$CC_atxt; ",")
	$res_txt:=MAIL_scriptOutlook(->$To_atxt; ->$CC_atxt; tSubject; tMailNote)
	If ($res_txt#"")
		ALERT:C41("Error received creating Outlook email:/r"+$res_txt)
	End if 
	
End if 

<>pref_SMTP:=$CurrSmtp_txt
<>SHOWERRORS:=$oldShowErr_b
$err_L:=IT_SetTimeOut($Timeout_L)

//End ut_testEmailSending