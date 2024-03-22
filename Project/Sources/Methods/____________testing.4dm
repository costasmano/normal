//%attributes = {}

//C_TEXT($AmtFrmt_txt; $TblHeadr_txt; $Cellright_txt; $CellCenter_txt; $FontDef_txt)

//$MailEnd_txt:=ut_GetSysParameter("MAIL_WK_INVNOTIF_END"; "<BR>If you have any questions, please contact <vMyName> at <vmyPhone>.<BR>")

//tSubject:="Review of Work Hour proposal for Assignment "+String([Work_Estimate]AssignNo)+" for Contract "+[Work_Estimate]ContractNo

//tMailNote:="<HTML><BODY>"+$FontDef_txt
//tMailNote:=tMailNote+$MailEnd_txt
//tMailNote:=tMailNote+"<BR>"+"----------------------------------"+"<BR>"
//tMailNote:=tMailNote+"E-mail sent from 4D process executed by user "+Current user+" on "+String(Current date(*); Internal date short)+"<BR>"
//tMailNote:=tMailNote+"</FONT></BODY></HTML>"


////$email:=New object
////$email.from:="noreply.mail@4d.com"

//////Originating addresses
////$email.to:="yosf.naciri@gmail.com"

////$email.subject:="Hello world"

////$email.textBody:="Test mail \r\n This is just a test e-mail \r\n Please ignore it"

////$smtp:=New object
////$smtp.host:="smtp-relay.sendinblue.com"
////$smtp.port:=587
////$smtp.user:="naciri.yosf@gmail.com"
////$smtp.password:="3jUQJcV6MtA1C5Ib"
////$smtpTransporter:=SMTP New transporter($smtp)

////$status:=$smtpTransporter.send($email)

//C_OBJECT($server; $email;$status)

////////////////////////////////////////////////////////////////
//$server:=New object
//$server.host:="smtp-relay.sendinblue.com"  //Mandatory
//$server.port:=25
//$server.user:="naciri.yosf@gmail.com"
//$server.password:="3jUQJcV6MtA1C5Ib"


//$transporter:=SMTP New transporter($server)

//$email:=New object
//$email.from:="noreply.mail@4d.com"
//$email.to:="naciri.yosf@gmail.com"
//$email.subject:="Hello world"
//$email.htmlBody:=tMailNote

//$status:=$transporter.send($email)
//If (Not($status.success))
//ALERT("An error occurred sending the mail: "+$status.statusText)
//End if 

