//%attributes = {"invisible":true}
// Method: Mail_BridgeStatusRpt
// Description
// To generate a PDf of today's Bridge status report and mail it
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/01/06, 15:10:34
	// ----------------------------------------------------
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/10/2006 09:08:21)
	Mods_2006_CM06A
	// Modified by: costasmanousakis-(Designer)-(5/29/2007 15:08:43)
	Mods_2007_CM10a
	// Modified by: costasmanousakis-(Designer)-(11/2/09 14:00:01)
	Mods_2009_10("MASSDOT")
	//create and mail two reports; one normal the other using the legacy owner
	// Modified by: costasmanousakis-(Designer)-(8/2/10 11:39:28)
	Mods_2010_08
	//  `Changed call to prt_substdrep with 1st param=longint
	Mods_2011_04  //r002 CJ Miller`04/12/11, 11:59:39      `Change from
	//Get indexed string to substring of date;5 to get 3 character month
	Mods_2011_05  //r002 CJ Miller`05/20/11, 12:01:57      `Change directory where reports are stored to the users documents folder
	// Modified by: costasmanousakis-(Designer)-(10/24/11 08:45:13)
	Mods_2011_10
	//  `Use method ut_setPrefSMTPServer
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: Costas Manousakis-(Designer)-(9/3/20 10:22:20)
	Mods_2020_09_bug
	//  `change the message folder name to include the server IP and port number
	// Modified by: Costas Manousakis-(Designer)-(2023-10-03 10:36:20)
	Mods_2023_10
	//  `use .push for Attachments ; add Attachments as plain attachments, no cid; added header for Disposition-Notification-To
	// Modified by: manousakisc-(Designer)-(10/11/2023 13:04:24)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
	
End if 
C_BOOLEAN:C305($0)
C_TEXT:C284(<>pref_SMTP; $Prevpref_SMTP_txt; tFromEmailAddress; $tToBuilt; $tCCBuilt; $tbCCBuilt; tSubject; tMailNote; AuthUserName_txt)
C_BOOLEAN:C305($SentOK; $OK; <>SHOWERRORS; $PrevShowErr_b; bMailPriority_b)
C_LONGINT:C283($err; $smtp_id)
C_TEXT:C284(MailAttachment; $Filename; $ReportDate_txt; MailAttachment2; $ReportMonth_txt)
C_DATE:C307($SearchDate_d)
$SearchDate_d:=Current date:C33(*)
G_InitCondRepVars
READ ONLY:C145([Status Report:69])
QUERY:C277([Status Report:69]; [Status Report:69]Date_Created:1=$SearchDate_d)
QUERY SELECTION:C341([Status Report:69]; [Status Report:69]Owner:2="Designer")
QUERY SELECTION:C341([Status Report:69]; [Status Report:69]Comments:135="Report generated by Server@")
//TRACE
LOAD RECORD:C52([Status Report:69])
$ReportDate_txt:=String:C10(Day of:C23([Status Report:69]Date_Created:1); "00")+"-"

$ReportMonth_txt:=Substring:C12(String:C10([Status Report:69]Date_Created:1; Internal date long:K1:5); 1; 3)
$ReportDate_txt:=$ReportDate_txt+$ReportMonth_txt+"-"
$ReportDate_txt:=$ReportDate_txt+String:C10(Year of:C25([Status Report:69]Date_Created:1))
$Filename:="Bridge Status "+$ReportDate_txt+".pdf"
C_OBJECT:C1216($serverinfo_o)
$serverinfo_o:=SYSUTIL_GetServerInfo
C_TEXT:C284($messageDir_txt)
$messageDir_txt:="Monthly_Reports_"+Replace string:C233(OB Get:C1224($serverinfo_o; "ServerIP"; Is text:K8:3); "."; "_")+"_"+OB Get:C1224($serverinfo_o; "ServerPort"; Is text:K8:3)
C_TEXT:C284($Path_txt)
$Path_txt:=ut_ReturnUserDocFolder($messageDir_txt)
MailAttachment:=$Path_txt+$Filename
SET PRINT OPTION:C733(9; 3; MailAttachment)  //print to pdf
prt_substdrep(1; True:C214)  //print the new HI report in batch mode...

QUERY:C277([Status Report:69]; [Status Report:69]Date_Created:1=$SearchDate_d)
QUERY SELECTION:C341([Status Report:69]; [Status Report:69]Owner:2="Designer")
QUERY SELECTION:C341([Status Report:69]; [Status Report:69]Comments:135="Legacy Owner Report Generated By Server@")
LOAD RECORD:C52([Status Report:69])
$ReportDate_txt:=String:C10(Day of:C23([Status Report:69]Date_Created:1); "00")+"-"
$ReportMonth_txt:=Substring:C12(String:C10([Status Report:69]Date_Created:1; Internal date long:K1:5); 1; 3)
$ReportDate_txt:=$ReportDate_txt+$ReportMonth_txt+"-"
$ReportDate_txt:=$ReportDate_txt+String:C10(Year of:C25([Status Report:69]Date_Created:1))
$Filename:="Bridge Status (MHD) "+$ReportDate_txt+".pdf"
MailAttachment2:=$Path_txt+$Filename
SET PRINT OPTION:C733(9; 3; MailAttachment2)  //print to pdf
prt_substdrep(2; True:C214)  //print the old HI report in batch mode...

//$err:=IT_MacTCPInit 
//TRACE
READ ONLY:C145([Parameters:107])
$Prevpref_SMTP_txt:=<>pref_SMTP
If (<>pref_SMTP="")
	ut_setPrefSMTPServer
End if 
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MAIL_BRGSTATFROM")
If (Records in selection:C76([Parameters:107])=1)
	tFromEmailAddress:=[Parameters:107]Description:2
Else 
	tFromEmailAddress:="Manousakis Costas (MHD) <costas.manousakis@MHD.state.ma.us>"
End if 
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MAIL_BRGSTATLIST")
If (Records in selection:C76([Parameters:107])=1)
	$tToBuilt:=[Parameters:107]Description:2
Else 
	$tToBuilt:="costas.manousakis@MHD.state.ma.us"
End if 
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MAIL_BRGSTATCC")
If (Records in selection:C76([Parameters:107])=1)
	$tCCBuilt:=[Parameters:107]Description:2
Else 
	$tCCBuilt:="costas.manousakis@MHD.state.ma.us"
End if 
$tbCCBuilt:=""
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MAIL_BRGSTATSUBJ")
If (Records in selection:C76([Parameters:107])=1)
	tSubject:=Replace string:C233([Parameters:107]Description:2; "<V_REPORT_DATE>"; $ReportDate_txt)
Else 
	tSubject:="Bridge Status "+$ReportDate_txt
End if 
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MAIL_BRGSTATBODY")
If (Records in selection:C76([Parameters:107])=1)
	tMailNote:=Replace string:C233([Parameters:107]Description:2; "<V_REPORT_DATE>"; $ReportDate_txt)
Else 
	tMailNote:=Char:C90(13)+Char:C90(13)+"Attached please find the Bridge Status Report for "+$ReportDate_txt+"."
	tMailNote:=tMailNote+Char:C90(13)+Char:C90(13)+(30*"-")+Char:C90(13)
	tMailNote:=tMailNote+"Automated e-mail sent by the MHD BMS system."+Char:C90(13)
	tMailNote:=tMailNote+(30*"-")
End if 
AuthUserName_txt:=""  //no authorization
$SentOK:=False:C215  //A flag to indicate if we make it through all of the calls
$PrevShowErr_b:=<>SHOWERRORS
<>SHOWERRORS:=False:C215  //Set to 

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

$email.attachments:=New collection:C1472()

//$email.attachments.push(MAIL New attachment(MailAttachment; ""; "4D"))
//$email.attachments.push(MAIL New attachment(MailAttachment2; ""; "4D"))
$email.attachments.push(MAIL New attachment:C1644(MailAttachment))  //leave as attachments - not inline
$email.attachments.push(MAIL New attachment:C1644(MailAttachment2))
$email.headers:=New collection:C1472()
//need to strip from tFromEmailAddress only the email
C_BOOLEAN:C305($embedaddress_b)
ARRAY LONGINT:C221($pos_aL; 0)
ARRAY LONGINT:C221($len_aL; 0)
C_TEXT:C284($notifyEmail_txt)
$embedaddress_b:=Match regex:C1019("<(.*)@(.*)>"; tFromEmailAddress; 1; $pos_aL; $len_aL)
If ($embedaddress_b)
	$notifyEmail_txt:=Substring:C12(tFromEmailAddress; $pos_aL{1}; $len_aL{1})+"@"+Substring:C12(tFromEmailAddress; $pos_aL{2}; $len_aL{2})
Else 
	$notifyEmail_txt:=tFromEmailAddress
End if 
$email.headers.push(New object:C1471("name"; "Disposition-Notification-To"; "value"; $notifyEmail_txt))

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

<>SHOWERRORS:=$PrevShowErr_b  //reset the previous settings
<>pref_SMTP:=$Prevpref_SMTP_txt
tFromEmailAddress:=""  //clear text vars
tSubject:=""
tMailNote:=""
MailAttachment:=""
$tToBuilt:=""
$tCCBuilt:=""
$tbCCBuilt:=""
$Filename:=""
$Prevpref_SMTP_txt:=""
$ReportDate_txt:=""

$0:=$SentOK