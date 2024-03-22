//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/04/06, 21:40:09
	// ----------------------------------------------------
	// Method: mail_testSend
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy4
	// Modified by: costasmanousakis-(Designer)-(5/29/2007 15:08:55)
	Mods_2007_CM10a
	// Modified by: costasmanousakis-(Designer)-(10/24/11 08:45:13)
	Mods_2011_10
	//  `Use method ut_setPrefSMTPServer
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: manousakisc-(Designer)-(10/11/2023 13:04:24)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
End if 

C_LONGINT:C283($err; $smtp_id)
C_TEXT:C284(<>pref_SMTP; tFromEmailAddress; $tToBuilt; $tCCBuilt; $tbCCBuilt; tSubject; tMailNote; AuthUserName_txt)
C_BOOLEAN:C305($SentOK; $OK; <>SHOWERRORS; bMailPriority_b)
ARRAY TEXT:C222(MailBody_atxt; 0)
//$err:=IT_MacTCPInit 
If (<>pref_SMTP="")
	ut_setPrefSMTPServer
End if 
tFromEmailAddress:="Manousakis Costas (MHD) <costas.manousakis@MHD.state.ma.us>"
$tToBuilt:="costas.manousakis@MHD.state.ma.us, mohammed.nabulsi@MHD.state.ma.us"
//$tToBuilt:="costas.manousakis@MHD.state.ma.us"
$tCCBuilt:=""
$tbCCBuilt:=""
tSubject:="External Transfer Check Rpt"
tMailNote:=tMailNote+Char:C90(13)+"----------------------------------"+Char:C90(13)
tMailNote:=tMailNote+"Automated e-mail sent from 4D process executed by user "+Current user:C182+Char:C90(13)
tMailNote:=tMailNote+" on workstation "+Current machine:C483+Char:C90(13)+"----------------------------------"
AuthUserName_txt:=""  //no authorization
$SentOK:=False:C215  //A flag to indicate if we make it through all of the calls
<>SHOWERRORS:=True:C214
C_TEXT:C284($Priority_txt; $XPriority_txt; $Importance_txt)
If (bMailPriority_b)
	$Priority_txt:="Urgent"
	$XPriority_txt:="1"
	$Importance_txt:="High"
	tSubject:="ATTENTION !! "+tSubject
Else 
	$Priority_txt:=""
	$XPriority_txt:=""
	$Importance_txt:=""
End if 

C_OBJECT:C1216($server; $email; $status; $transporter)

$server:=New object:C1471
$server.host:=<>pref_SMTP  //Mandatory
$server.port:=25
$server.user:=AuthUserName_txt
$server.password:=AuthPassword_txt

$transporter:=SMTP New transporter:C1608($server)

$email:=New object:C1471
$email.from:=tFromEmailAddress
$email.to:=$tToBuilt
$email.cc:=$tCCBuilt
$email.bcc:=$tbCCBuilt
$email.subject:=tSubject
$email.textBody:=tMailNote

$status:=$transporter.send($email)

If (Not:C34($status.success))
	// check if running headless
	
	//start of changes Mods_2023_10 10/11/2023
	If (Get application info:C1599.headless | Get application info:C1599.launchedAsService)
		// don't show alert if headless or running as service
	Else 
		ALERT:C41("An error occurred sending the mail: "+$status.statusText)
	End if 
	//end of changes Mods_2023_10 10/11/2023
	
Else 
	$SentOK:=True:C214
End if 

tFromEmailAddress:=""
$tToBuilt:=""
$tCCBuilt:=""
$tbCCBuilt:=""
tSubject:=""
tMailNote:=""
AuthUserName_txt:=""

$0:=$SentOK