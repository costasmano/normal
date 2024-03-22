//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/07, 11:01:38
	// ----------------------------------------------------
	// Method: WKHR_MailReviewNotice
	// Description
	// Mail a notice of approval or rejection of a work hour proposal
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/24/11 08:45:13)
	Mods_2011_10
	//  `Use method ut_setPrefSMTPServer
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: manousakisc-(Designer)-(10/11/2023 11:15:38)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
End if 
C_LONGINT:C283($err; $smtp_id)
C_TEXT:C284(<>pref_SMTP; $Prevpref_SMTP_txt; tFromEmailAddress; $tToBuilt; $tCCBuilt; $tbCCBuilt; tSubject; tMailNote; AuthUserName_txt; $MailCmmts_txt; $MailBody_txt; $MailEnd_txt; $MyPhone_txt)
C_BOOLEAN:C305($0; $SentOK; $OK; <>SHOWERRORS; bMailPriority_b)
//$err:=IT_MacTCPInit 

$Prevpref_SMTP_txt:=<>pref_SMTP

If (<>pref_SMTP="")
	ut_setPrefSMTPServer
End if 
$tCCBuilt:=ut_GetSysParameter("MAIL_WK_INVNOTIF_CC")

tFromEmailAddress:="MHD Work Hour Review <donotreply@MHD.state.ma.us>"
If (<>PERS_MyEmail_txt#"")
	tFromEmailAddress:=<>PERS_MyEmail_txt
	$tCCBuilt:=tFromEmailAddress+","+$tCCBuilt
End if 

$MailBody_txt:="Notification of Work Hour Estimate Review"+"<BR><BR>"
$MailBody_txt:=$MailBody_txt+"The Work Hour Estimate for Contract <vContractNo>, Assignment <vAssignNo> "
$MailBody_txt:=$MailBody_txt+" was <vApproveReject> on <vProcessDate><vComments>"+"<BR><BR>"

$MailBody_txt:=ut_GetSysParameter("MAIL_WK_INVNOTIF_BD"; $MailBody_txt)
$MailEnd_txt:=ut_GetSysParameter("MAIL_WK_INVNOTIF_END"; "<BR>If you have any questions, please contact <vMyName> at <vmyPhone>.<BR>")
$MailCmmts_txt:=ut_GetSysParameter("MAIL_WK_INVNOTIF_CMT"; " with the following comments :<BR><BR>")

$MailEnd_txt:=Replace string:C233($MailEnd_txt; "<vMyName>"; <>PERS_MyName_txt)
$MailEnd_txt:=Replace string:C233($MailEnd_txt; "<vmyPhone>"; <>PERS_MyPhone_txt)

$tToBuilt:=ut_GetConsEmail([Work_Estimate:103]Consultant:6; "DESIGN")

If ((OK=1) & ($tToBuilt#""))
	$tbCCBuilt:=""
	C_TEXT:C284($AssgnList_txt; $ApproveReject_txt)
	Case of 
		: ([Work_Estimate:103]WkHrEstApproved:18=2)
			$ApproveReject_txt:="Approved"
		: ([Work_Estimate:103]WkHrEstApproved:18=1)
			$ApproveReject_txt:="Rejected"
	End case 
	
	C_TEXT:C284($AmtFrmt_txt; $TblHeadr_txt; $Cellright_txt; $CellCenter_txt; $FontDef_txt)
	$AmtFrmt_txt:="$###,###,##0.00"
	$Cellright_txt:="<TD align=right> &nbsp &nbsp "
	$FontDef_txt:="<FONT FACE="+<>sQU+"Tahoma"+<>sQU+" SIZE=2>"
	tSubject:="Review of Work Hour proposal for Assignment "+String:C10([Work_Estimate:103]AssignNo:16)+" for Contract "+[Work_Estimate:103]ContractNo:3
	tMailNote:=Replace string:C233($MailBody_txt; "<vContractNo>"; [Work_Estimate:103]ContractNo:3)
	tMailNote:=Replace string:C233(tMailNote; "<vProcessDate>"; String:C10([Work_Estimate:103]ApprovedDate:19))
	tMailNote:=Replace string:C233(tMailNote; "<vAssignNo>"; String:C10([Work_Estimate:103]AssignNo:16))
	If ([Work_Estimate:103]WkHrEstApproved:18=BMS Approved)
		tMailNote:=Replace string:C233(tMailNote; "<vApproveReject>"; "approved")
	Else 
		tMailNote:=Replace string:C233(tMailNote; "<vApproveReject>"; "rejected")
	End if 
	If ([Work_Estimate:103]ApproveCmts:30#"")
		tMailNote:=Replace string:C233(tMailNote; "<vComments>"; $MailCmmts_txt+[Work_Estimate:103]ApproveCmts:30)
	Else 
		tMailNote:=Replace string:C233(tMailNote; "<vComments>"; ".")
	End if 
	tMailNote:="<HTML><BODY>"+$FontDef_txt+tMailNote
	tMailNote:=tMailNote+$MailEnd_txt
	tMailNote:=tMailNote+"<BR>"+"----------------------------------"+"<BR>"
	tMailNote:=tMailNote+"E-mail sent from 4D process executed by user "+Current user:C182+" on "+String:C10(Current date:C33(*); Internal date short:K1:7)+"<BR>"
	tMailNote:=tMailNote+"</FONT></BODY></HTML>"
	AuthUserName_txt:=""  //no authorization
	$SentOK:=False:C215  //A flag to indicate if we make it through all of the calls
	<>SHOWERRORS:=True:C214
	
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
	$email.htmlBody:=tMailNote
	
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
	
Else 
	
End if 
READ WRITE:C146([Conslt Address:77])

<>pref_SMTP:=$Prevpref_SMTP_txt
tFromEmailAddress:=""
$tToBuilt:=""
$tCCBuilt:=""
$tbCCBuilt:=""
tSubject:=""
tMailNote:=""
$MailBody_txt:=""
$Prevpref_SMTP_txt:=""

$0:=$SentOK