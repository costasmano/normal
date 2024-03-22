//%attributes = {"invisible":true}
// ut_SendEmail
// Parameters
//$1 to text
//$2 from text
//$3 CC text
//$4 bcc text
//$5 mail body text
//$6 Subject tex t
//$7 priority boolean
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): charlesmiller
	// Date and time: 11/19/08, 11:06:24
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/20/10 08:34:40)
	Mods_2010_10
	//  `Use method ut_GetSysParameter for the SMTP server
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: Costas Manousakis-(Designer)-(2023-10-03 10:32:25)
	Mods_2023_10
	//  `added headers in email when priority = true
	// Modified by: Costas Manousakis-(Designer)-(2023-10-04 18:32:25)
	Mods_2023_10
	//  `added attachments and priority headers
End if 
C_LONGINT:C283($SmtpId_l; $Error_l)
C_BOOLEAN:C305($0; $SentOK_b; $Priority_b; $OK_b)
$Priority_b:=False:C215
C_TEXT:C284($1; $2; $3; $4; $5; $6; $To_txt; $From_txt; $ToCC_txt; $Tobcc_txt; $Body_txt; $Subject_txt; $SMTPServer_txt; $Priority_txt; $XPriority_txt; $Importance_txt)
$Priority_txt:=""
$XPriority_txt:=""
$Importance_txt:=""

C_TEXT:C284($1; $2; $3; $4; $5; $6)
$To_txt:=$1
$From_txt:=$2
$ToCC_txt:=$3
$Tobcc_txt:=$4
$Body_txt:=$5
$Subject_txt:=$6

If (Count parameters:C259=7)  // we have just a priority
	C_BOOLEAN:C305($7; $Priority_b)
	$Priority_b:=$7
	If ($Priority_b)
		$Priority_txt:="Urgent"
		$XPriority_txt:="1"
		$Importance_txt:="High"
		$Subject_txt:="ATTENTION !! "+$Subject_txt
	End if 
	
End if 

$SMTPServer_txt:=ut_GetSysParameter("MAIL_BRGSTATSMTP"; "eot-mail.mhd.root.eot.gov")

$SentOK_b:=False:C215  //A flag to indicate if we make it through all of the calls
//$Error_l:=IT_MacTCPInit 
If ($Error_l=0)
	//Case of 
	//: (Not(mail_ErrorCheck("SMTP_New"; SMTP_New($SmtpId_l))))  //Creates a new message envelope assigned to $SmtpId_l
	//: (Not(mail_ErrorCheck("SMTP_Host"; SMTP_Host($SmtpId_l; $SMTPServer_txt; 0))))  //point to a smtp server that will handle our mail delivery
	//: (Not(mail_ErrorCheck("SMTP_From"; SMTP_From($SmtpId_l; $From_txt; 0))))  //
	//: (Not(mail_ErrorCheck("SMTP_ReplyTo"; SMTP_ReplyTo($SmtpId_l; $From_txt; 0))))  //reply to… 
	//: (Not(mail_ErrorCheck("SMTP_To"; SMTP_To($SmtpId_l; $To_txt; 0))))  //primary recipient{s} of the message
	//: (Not(mail_ErrorCheck("SMTP_Cc"; SMTP_Cc($SmtpId_l; $ToCC_txt; 0))))  //people who should get copies of the message
	//: (Not(mail_ErrorCheck("SMTP_Bcc"; SMTP_Bcc($SmtpId_l; $Tobcc_txt; 0))))  //people who will get the message w/o the others knowing it
	//: (Not(mail_ErrorCheck("SMTP_Subject"; SMTP_Subject($SmtpId_l; $Subject_txt; 0))))  //the topic 
	//: (Not(ut_SMTP_AddHeader($SmtpId_l; "X-Priority"; $XPriority_txt)))
	//: (Not(ut_SMTP_AddHeader($SmtpId_l; "Priority"; $Priority_txt)))
	//: (Not(ut_SMTP_AddHeader($SmtpId_l; "Importance"; $Importance_txt)))
	//: (Not(mail_ErrorCheck("SMTP_Comments"; SMTP_Comments($SmtpId_l; "Sent via 4D INTERNET Tools"; 0))))  //extra junk to put in header, recipient not likely to see this
	//: (Not(mail_ErrorCheck("SMTP_Body"; SMTP_Body($SmtpId_l; $Body_txt; 0))))
	//: (Not(SMTPAttachments($SmtpId_l)))
	//: (Not(mail_ErrorCheck("SMTP_Send"; SMTP_Send($SmtpId_l))))  //were done, so let's send it...
	//Else 
	//$SentOK_b:=True  //message was composed and mailed successfully
	
	//End case 
	
	//If ($SmtpId_l#0)  //If a Message Envelope was created we should clear it now
	//$OK_b:=mail_ErrorCheck("SMTP_Clear"; SMTP_Clear($SmtpId_l))  //clear our message from memory and free up space
	//End if 
	C_OBJECT:C1216($server; $email; $status; $transporter)
	
	
	$server:=New object:C1471
	$server.host:=$SMTPServer_txt  //Mandatory
	$server.port:=25
	$server.user:=AuthUserName_txt
	$server.password:=AuthPassword_txt
	
	
	$transporter:=SMTP New transporter:C1608($server)
	
	$email:=New object:C1471
	$email.from:=$From_txt
	$email.to:=$To_txt
	$email.cc:=$ToCC_txt
	$email.bcc:=$Tobcc_txt
	$email.subject:=$Subject_txt
	$email.textBody:=$Body_txt
	
	If ($Priority_b)
		$email.headers:=New collection:C1472
		$email.headers.push(New object:C1471("name"; "Priority"; "value"; $Priority_txt))
		$email.headers.push(New object:C1471("name"; "X-Priority"; "value"; $XPriority_txt))
		$email.headers.push(New object:C1471("name"; "Importance"; "value"; $Importance_txt))
	End if 
	
	If (Size of array:C274(MAILAttachments_atxt)>0)
		$email.attachments:=New collection:C1472
		C_LONGINT:C283($attch_L)
		For ($attch_L; 1; Size of array:C274(MAILAttachments_atxt))
			$email.attachments.push(MAIL New attachment:C1644(MAILAttachments_atxt{$attch_L}))
		End for 
		
	End if 
	
	$status:=$transporter.send($email)
	
	If (Not:C34($status.success))
		// check if running headless
		
		If (Get application info:C1599.headless | Get application info:C1599.launchedAsService)
			// don't show alert if headless or running as service
		Else 
			ALERT:C41("An error occurred sending the mail: "+$status.statusText)
		End if 
		
	Else 
		$SentOK_b:=True:C214
	End if 
End if 
$0:=$SentOK_b

//End ut_SendEmail