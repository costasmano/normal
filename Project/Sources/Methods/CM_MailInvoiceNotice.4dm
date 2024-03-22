//%attributes = {"invisible":true}
// Method: CM_MailInvoiceNotice
// Description
// Send Notification of invoice processing in maintenance contracts
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/14/07, 11:18:42
	// ----------------------------------------------------
	// Method: CM_MailInvoiceNotice
	// Description
	// Send Notification of invoice processing
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(5/29/2007 15:08:23)
	Mods_2007_CM10a
	// Modified by: costasmanousakis-(Designer)-(6/5/2007 08:56:50)
	Mods_2007_CM10a
	// Modified by: costasmanousakis-(Designer)-(6/19/2007 08:35:38)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/25/08 10:16:53)
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(3/19/09 09:28:03)
	Mods_2009_CM_5404
	//Include Cost recovery
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(6/14/11 17:04:11)
	Mods_2011_06
	//  `Use method ut_GetSysParameter and global variables defined in  PERS_GetMyInfo
	// Modified by: costasmanousakis-(Designer)-(10/24/11 11:00:22)
	Mods_2011_10
	//  `Use method ut_setPrefSMTPServer
	// Modified by: Costas Manousakis-(Designer)-(11/30/16 12:11:18)
	Mods_2016_11
	//  `change the variable $FontDef_txt to use &quot; instead of variable <>sQu
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: Costas Manousakis-(Designer)-(2/11/20 16:46:01)
	Mods_2020_02_bug
	//  `use the <>EmailMethod variable to choose how to send emails
	// Modified by: Costas Manousakis-(Designer)-(5/5/20 16:37:04)
	Mods_2020_05_bug
	//  `use at least 3 chars from the consultant name when searching addresses
	// Modified by: manousakisc-(Designer)-(10/11/2023 13:04:24)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
End if 

C_LONGINT:C283($err; $smtp_id; $i)
C_TEXT:C284(<>pref_SMTP; tFromEmailAddress; $tToBuilt; $tCCBuilt; $tbCCBuilt; tSubject; tMailNote; AuthUserName_txt; $MailBody_txt; $MailEnd_txt; $MyName_txt; $MyPhone_txt)
C_BOOLEAN:C305($0; $SentOK; $OK; <>SHOWERRORS; bMailPriority_b)
//$err:=IT_MacTCPInit 

If (<>pref_SMTP="")
	ut_setPrefSMTPServer
End if 

$MailBody_txt:=""
$MailEnd_txt:=""
$MyName_txt:=<>PERS_MyName_txt
$MyPhone_txt:=<>PERS_MyPhone_txt

$tCCBuilt:=ut_GetSysParameter("MAIL_CM_INVNOTIF_CC")

Case of 
	: ((<>PERS_MyEmail_txt#"") & ($tCCBuilt#""))
		tFromEmailAddress:=<>PERS_MyEmail_txt
		$tCCBuilt:=tFromEmailAddress+","+$tCCBuilt
	: (<>PERS_MyEmail_txt#"")
		tFromEmailAddress:=<>PERS_MyEmail_txt
		$tCCBuilt:=tFromEmailAddress
	: ($tCCBuilt#"")
		tFromEmailAddress:="MassDOT Invoice Process <donotreply@dot.state.ma.us>"
		
End case 

$MailBody_txt:="Notification of Invoice being processed on <vProcessDate>"
$MailBody_txt:=$MailBody_txt+" for Contract <vContractNo>, Assignment(s) <vAssignList>."+"<BR>"+"<BR>"
$MailBody_txt:=ut_GetSysParameter("MAIL_CM_INVNOTIF_BD"; $MailBody_txt)
$MailEnd_txt:="<BR>If you have any questions, please contact <vMyName> at <vmyPhone>.<BR>"
$MailEnd_txt:=ut_GetSysParameter("MAIL_CM_INVNOTIF_END"; $MailEnd_txt)
$MailEnd_txt:=Replace string:C233($MailEnd_txt; "<vMyName>"; $MyName_txt)
$MailEnd_txt:=Replace string:C233($MailEnd_txt; "<vmyPhone>"; $MyPhone_txt)

$tToBuilt:=""
C_TEXT:C284($msg; $CancelMsg_txt)
$CancelMsg_txt:="Don't Send Email"
$msg:=<>sCR+"Multiple addresses can be entered separated by comma"
READ ONLY:C145([Conslt Address:77])
QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=(Substring:C12([Contract_Maintenance:97]ConsultantName:3; 1; \
MaxNum((Length:C16([Contract_Maintenance:97]ConsultantName:3)\2); 3))\
+"@"))
QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Design:21=True:C214)
QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Email:18#"")
If (Records in selection:C76([Conslt Address:77])>=1)
	ARRAY TEXT:C222(arr_ConsEmails_txt; 0)  // **Replaced old _ o _ARRAY STRING length 80
	SELECTION TO ARRAY:C260([Conslt Address:77]Email:18; arr_ConsEmails_txt)
	If (arr_ConsEmails_txt{1}#$tToBuilt)
		If ($tToBuilt#"")
			$tToBuilt:=arr_ConsEmails_txt{1}+","+$tToBuilt
		Else 
			$tToBuilt:=arr_ConsEmails_txt{1}
		End if 
	End if 
	
	If (Size of array:C274(arr_ConsEmails_txt)>1)
		$msg:="Verify the e-mail address for "+[Contract_Maintenance:97]ConsultantName:3+". You can also select an email address from the dropdown."+$msg
		$tToBuilt:=ut_Request($msg; ->arr_ConsEmails_txt; $tToBuilt; ""; $CancelMsg_txt)
	Else 
		$msg:="Verify the e-mail address for "+[Contract_Maintenance:97]ConsultantName:3+"."+$msg
		$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
	End if 
	ARRAY TEXT:C222(arr_ConsEmails_txt; 0)  // **Replaced old _ o _ARRAY STRING length 80
Else 
	$msg:="Enter the e-mail address for "+[Contract_Maintenance:97]ConsultantName:3+"."+$msg
	$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
End if 
If (OK=1)
	$tbCCBuilt:=""
	C_TEXT:C284($AssgnList_txt)
	QUERY:C277([Invoice_AssignNo_Maintenance:94]; [Invoice_AssignNo_Maintenance:94]InvoiceID:1=[Invoice_Maintenance:95]InvoiceID:1)
	SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]AssignNo:2; $InvAssgnNo_aL; [Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3; $InvTotLFDes_ar)
	SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4; $InvTotLFCon_ar; [Invoice_AssignNo_Maintenance:94]DirectExpense:5; $InvDirExp_ar)
	SORT ARRAY:C229($InvAssgnNo_aL; $InvTotLFDes_ar; $InvTotLFCon_ar; $InvDirExp_ar)
	If (Size of array:C274($InvAssgnNo_aL)>0)
		$AssgnList_txt:=String:C10($InvAssgnNo_aL{1})
		For ($i; 2; Size of array:C274($InvAssgnNo_aL))
			$AssgnList_txt:=$AssgnList_txt+","+String:C10($InvAssgnNo_aL{$i})
		End for 
	End if 
	C_TEXT:C284($AmtFrmt_txt; $TblHeadr_txt; $Cellright_txt; $CellCenter_txt; $FontDef_txt)
	$AmtFrmt_txt:="$###,###,##0.00"
	$Cellright_txt:="<TD align=right> &nbsp &nbsp "
	$FontDef_txt:="<FONT FACE=&quot;Tahoma&quot; SIZE=2>"
	$TblHeadr_txt:="<TABLE border=0 cellpadding=0 cellspacing=5>"+$FontDef_txt
	tSubject:="Approval of "+[Contract_Maintenance:97]ConsultantName:3+" Invoice No. "+String:C10([Invoice_Maintenance:95]InvoiceNo:2)+" for Contract "+[Contract_Maintenance:97]ContractNo:1
	tMailNote:=Replace string:C233($MailBody_txt; "<vContractNo>"; [Contract_Maintenance:97]ContractNo:1)
	tMailNote:=Replace string:C233(tMailNote; "<vAssignList>"; $AssgnList_txt)
	tMailNote:=Replace string:C233(tMailNote; "<vConsltName>"; [Contract_Maintenance:97]ConsultantName:3)
	tMailNote:=Replace string:C233(tMailNote; "<vProcessDate>"; String:C10([Invoice_Maintenance:95]DateProcessFoward:9))
	tMailNote:=Replace string:C233(tMailNote; "<vInvoiceNo>"; String:C10([Invoice_Maintenance:95]InvoiceNo:2))
	tMailNote:="<HTML><BODY>"+$FontDef_txt+tMailNote+$TblHeadr_txt
	
	tMailNote:=tMailNote+"<TR><TD><B><U>Invoice Summary</B></U></TD></TR>"
	If ([Invoice_Maintenance:95]Retainage:16>=0)
		tMailNote:=tMailNote+"<TR><TD>Dates of service</TD></TR>"
		tMailNote:=tMailNote+"<TR><TD>From</TD>"+$Cellright_txt+String:C10([Invoice_Maintenance:95]DateServiceFrom:5)+"</TD></TR>"
		tMailNote:=tMailNote+"<TR><TD>To</TD>"+$Cellright_txt+String:C10([Invoice_Maintenance:95]DateServiceTo:6)+"</TD></TR>"
		tMailNote:=tMailNote+"<TR><TD>Total Limiting Fee Design</TD>"+$Cellright_txt+String:C10([Invoice_Maintenance:95]TotalLimFeeDes:8; $AmtFrmt_txt)+"</TD></TR>"
		tMailNote:=tMailNote+"<TR><TD>Total Limiting Fee Construction</TD>"+$Cellright_txt+String:C10([Invoice_Maintenance:95]TotalLimFeeConstr:14; $AmtFrmt_txt)+"</TD></TR>"
		tMailNote:=tMailNote+"<TR><TD>Total Direct Expenses</TD>"+$Cellright_txt+String:C10([Invoice_Maintenance:95]DirectExpenses:15; $AmtFrmt_txt)+"</TD></TR>"
		tMailNote:=tMailNote+"<TR><TD>Total Amount</TD>"+$Cellright_txt+String:C10([Invoice_Maintenance:95]TotalAmount:11; $AmtFrmt_txt)+"</TD></TR>"
	Else 
		
	End if 
	tMailNote:=tMailNote+"<TR><TD>Retainage</TD>"+$Cellright_txt+String:C10(Abs:C99([Invoice_Maintenance:95]Retainage:16); $AmtFrmt_txt)+"</TD></TR>"
	If ([Invoice_Maintenance:95]CostRecovery:17>0)
		tMailNote:=tMailNote+"<TR><TD>Cost Recovery</TD>"+$Cellright_txt+String:C10(Abs:C99([Invoice_Maintenance:95]CostRecovery:17); $AmtFrmt_txt)+"</TD></TR>"
	End if 
	tMailNote:=tMailNote+"<TR><TD>Total Invoice Approved for Payment</TD>"+$Cellright_txt+String:C10(([Invoice_Maintenance:95]TotalAmount:11-[Invoice_Maintenance:95]Retainage:16-[Invoice_Maintenance:95]CostRecovery:17); $AmtFrmt_txt)+"</TD></TR>"
	tMailNote:=tMailNote+"</TABLE>"
	If (Size of array:C274($InvAssgnNo_aL)>0)
		tMailNote:=tMailNote+"<BR><U>"+"Breakdown by Assignment"+"</U><BR>"
		tMailNote:=tMailNote+$TblHeadr_txt+"<tr><td align=center>Assignment<BR>No</td>"
		tMailNote:=tMailNote+$Cellright_txt+"Limiting Fee<BR>Design</td>"
		tMailNote:=tMailNote+$Cellright_txt+"Limiting Fee<BR>Construction</td>"
		tMailNote:=tMailNote+$Cellright_txt+"Direct<BR>&nbsp &nbsp Expenses</td>"
		tMailNote:=tMailNote+$Cellright_txt+"Assignment<BR>Total</td></tr>"
		For ($i; 1; Size of array:C274($InvAssgnNo_aL))
			tMailNote:=tMailNote+"<TR><td align=center>"+String:C10($InvAssgnNo_aL{$i})+"</TD>"
			tMailNote:=tMailNote+$Cellright_txt+String:C10($InvTotLFDes_ar{$i}; $AmtFrmt_txt)+"</TD>"
			tMailNote:=tMailNote+$Cellright_txt+String:C10($InvTotLFCon_ar{$i}; $AmtFrmt_txt)+"</TD>"
			tMailNote:=tMailNote+$Cellright_txt+String:C10($InvDirExp_ar{$i}; $AmtFrmt_txt)+"</TD>"
			tMailNote:=tMailNote+$Cellright_txt+String:C10(($InvDirExp_ar{$i}+$InvTotLFCon_ar{$i}+$InvTotLFDes_ar{$i}); $AmtFrmt_txt)+"</TD></TR>"
		End for 
		tMailNote:=tMailNote+"</table>"
	End if 
	tMailNote:=tMailNote+$MailEnd_txt
	tMailNote:=tMailNote+"<BR>"+"----------------------------------"+"<BR>"
	tMailNote:=tMailNote+"E-mail sent from 4D process executed by user "+Current user:C182+" on "+String:C10(Current date:C33(*); Internal date short:K1:7)+"<BR>"
	tMailNote:=tMailNote+"</FONT></BODY></HTML>"
	AuthUserName_txt:=""  //no authorization
	$SentOK:=False:C215  //A flag to indicate if we make it through all of the calls
	<>SHOWERRORS:=True:C214
	
	If (<>EmailMethod#"Outlook")
		
		SHORT_MESSAGE("Sending automatic email....")
		
		C_OBJECT:C1216($server; $email; $status; $transporter)
		
		$server:=New object:C1471
		$server.host:=<>pref_SMTP  //Mandatory
		$server.port:=25
		$server.user:=AuthUserName_txt
		$server.password:=AuthPassword_txt
		
		
		$transporter:=SMTP New transporter:C1608($server)
		
		$email:=New object:C1471
		$email.from:=tFromEmailAddress
		$email.to:=tToBuilt_txt
		$email.cc:=tCCBuilt_txt
		$email.bcc:=tbCCBuilt
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
		
		
		CLOSE WINDOW:C154
		
	End if 
	
	If (Not:C34($SentOK))
		C_TEXT:C284(tToBuilt_txt; tCCBuilt_txt; vTextMsg; $res_txt)
		ARRAY TEXT:C222($To_atxt; 0)
		ARRAY TEXT:C222($CC_atxt; 0)
		ut_TextToArray($tToBuilt; ->$To_atxt; ",")
		ut_TextToArray($tCCBuilt; ->$CC_atxt; ",")
		
		SHORT_MESSAGE("Attempting to send email using Outlook")
		$res_txt:=MAIL_scriptOutlook(->$To_atxt; ->$CC_atxt; tSubject; tMailNote)
		CLOSE WINDOW:C154
		
		If ($res_txt#"")
			tToBuilt_txt:=$tToBuilt
			tCCBuilt_txt:=$tCCBuilt
			vTextMsg:="Error Sending Emai!  Contents of the email are below. You can copy and paste these contents to your email client to send manually."
			C_LONGINT:C283($emailWin_L)
			$emailWin_L:=Open form window:C675("EmailDialog"; Plain form window:K39:10)
			DIALOG:C40("EmailDialog")
			CLOSE WINDOW:C154
			
		End if 
		
	End if 
	
Else 
	$SentOK:=True:C214  //User Canceled - so no errors
End if 
READ WRITE:C146([Conslt Address:77])

tFromEmailAddress:=""
$tToBuilt:=""
$tCCBuilt:=""
$tbCCBuilt:=""
tSubject:=""
tMailNote:=""
$MailBody_txt:=""

$0:=$SentOK