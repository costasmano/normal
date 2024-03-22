//%attributes = {"invisible":true}
//Method: Mail_SendTINRevuNotif
//Description
// send email notifications for TIN inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/18/17, 12:35:04
	// ----------------------------------------------------
	//Created : 
	Mods_2017_09
	
	C_BOOLEAN:C305(Mail_SendTINRevuNotif; $0)
	// Modified by: Costas Manousakis-(Designer)-(10/11/17 14:42:15)
	Mods_2017_10
	//  `use new field [NTI_TunnelInfo]NTI_InspResp - method NTI_GroupSuffix
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: Costas Manousakis-(Designer)-(2/11/20 16:19:21)
	Mods_2020_02_bug
	//  `use the <>EmailMethod variable to choose how to send emails
	Mods_2020_05_bug
	//  `use at least 3 chars from the consultant name when searching addresses
	// Modified by: manousakisc-(Designer)-(10/11/2023 13:04:24)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
End if 
//

C_BOOLEAN:C305($0; $SentOK; $OK; <>SHOWERRORS; bMailPriority_b)

C_LONGINT:C283($err; $smtp_id)
C_TEXT:C284(<>pref_SMTP; $Prevpref_SMTP_txt; tFromEmailAddress; $tToBuilt; $tCCBuilt; $tbCCBuilt; tSubject; tMailNote; AuthUserName_txt)
//$err:=IT_MacTCPInit 
C_LONGINT:C283(vApproveLvl)  //process var 1 or 2

If (<>pref_SMTP="")
	ut_setPrefSMTPServer
End if 

tFromEmailAddress:="MADOT Insp Review <donotreply@DOT.state.ma.us>"
$tCCBuilt:=""
If (<>PERS_MyEmail_txt#"")
	tFromEmailAddress:=<>PERS_MyEmail_txt
	$tCCBuilt:=tFromEmailAddress
End if 
C_TEXT:C284($TmLdrName_txt; $TmLdrEmail_txt; $TmLdrEmployer_txt)
$tToBuilt:=""
$TmLdrName_txt:=""
$TmLdrEmail_txt:=""
$TmLdrEmployer_txt:=""
PERS_GetInfo([TIN_Inspections:184]TeamLeader:11; "FIRSTLAST"; ->$TmLdrName_txt; "EMAIL"; ->$TmLdrEmail_txt; "EMPLOYER"; ->$TmLdrEmployer_txt)
$TmLdrName_txt:=$TmLdrName_txt+" from: "+$TmLdrEmployer_txt
$tToBuilt:=$TmLdrEmail_txt
C_TEXT:C284($InspDBIE_Email_txt; $DBIEName_txt; $GroupDBIE_Email_txt)
$InspDBIE_Email_txt:=""  //email of dbie on insp report
$GroupDBIE_Email_txt:=""  //email of dbie from personnel groups
C_LONGINT:C283($InspDBIE_i; $BridgeDBIE_i)
ARRAY TEXT:C222($ccEmails_atxt; 0)
APPEND TO ARRAY:C911($ccEmails_atxt; <>PERS_MyEmail_txt)
PERS_GetInfo([TIN_Inspections:184]DistrTnlInspEng:22; "EMAIL"; ->$InspDBIE_Email_txt)
APPEND TO ARRAY:C911($ccEmails_atxt; $InspDBIE_Email_txt)
PERS_GetInfo([TIN_Inspections:184]DistrInspEng:12; "EMAIL"; ->$InspDBIE_Email_txt)
APPEND TO ARRAY:C911($ccEmails_atxt; $InspDBIE_Email_txt)

C_TEXT:C284($InspResp_txt)
$InspResp_txt:=NTI_GroupSuffix

$InspDBIE_i:=GRP_GetGroupRepID("TunnelEng"+$InspResp_txt)
PERS_GetInfo($InspDBIE_i; "EMAIL"; ->$InspDBIE_Email_txt)
APPEND TO ARRAY:C911($ccEmails_atxt; $InspDBIE_Email_txt)
$InspDBIE_i:=GRP_GetGroupRepID("TunnelInspEng"+$InspResp_txt)
PERS_GetInfo($InspDBIE_i; "EMAIL"; ->$InspDBIE_Email_txt)
APPEND TO ARRAY:C911($ccEmails_atxt; $InspDBIE_Email_txt)
PERS_GetInfo([TIN_Inspections:184]ProjManager:14; "EMAIL"; ->$InspDBIE_Email_txt)
APPEND TO ARRAY:C911($ccEmails_atxt; $InspDBIE_Email_txt)


ARRAY LONGINT:C221($ccIds_AL; 0)
ARRAY TEXT:C222($ccNames_atxt; 0)
C_TEXT:C284($CCgroupName_txt)
Case of 
	: (vApproveLvl=1)
		$CCgroupName_txt:="DTIEReviewNotifCC"
	: (vApproveLvl=2)
		$CCgroupName_txt:="TunnelReviewNotifCC"
End case 

$CCgroupName_txt:=$CCgroupName_txt+$InspResp_txt
GRP_GetMembersOfGrps(->$ccIds_AL; ->$ccNames_atxt; ""; $CCgroupName_txt)
If (Size of array:C274($ccIds_AL)>0)
	C_BOOLEAN:C305($RoStatePersonnel_b)
	$RoStatePersonnel_b:=Read only state:C362([Personnel:42])
	READ ONLY:C145([Personnel:42])
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ccIds_AL))
		QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$ccIds_AL{$loop_L})
		If (Records in selection:C76([Personnel:42])=1)
			LOAD RECORD:C52([Personnel:42])
			If ([Personnel:42]EmailAddress_s:14#"")
				APPEND TO ARRAY:C911($ccEmails_atxt; [Personnel:42]EmailAddress_s:14)
			End if 
		End if 
	End for 
	
	If (Not:C34($RoStatePersonnel_b))
		READ WRITE:C146([Personnel:42])
	End if 
End if 

//remove duplicates or blanks in cc list
For ($loop_L; Size of array:C274($ccEmails_atxt); 1; -1)
	
	If ($ccEmails_atxt{$loop_L}="")
		DELETE FROM ARRAY:C228($ccEmails_atxt; $loop_L)
	Else 
		$dupcheck_L:=Find in array:C230($ccEmails_atxt; $ccEmails_atxt{$loop_L})
		If ($dupcheck_L<$loop_L)
			DELETE FROM ARRAY:C228($ccEmails_atxt; $loop_L)
		End if 
	End if 
	
End for 
//build the cc list in one string
$tCCBuilt:=""
If (Size of array:C274($ccEmails_atxt)>0)
	$tCCBuilt:=$ccEmails_atxt{1}
	For ($loop_L; 2; Size of array:C274($ccEmails_atxt))
		$tCCBuilt:=$tCCBuilt+","+$ccEmails_atxt{$loop_L}
	End for 
	
End if 

C_LONGINT:C283($loop_L; $dupcheck_L)
C_TEXT:C284($msg; $CancelMsg_txt)
$CancelMsg_txt:="Don't Send Email"
$msg:=<>sCR+"Multiple addresses can be entered separated by comma"
Case of 
	: ([TIN_Inspections:184]Agency:13="Mass. Highway@") | ([TIN_Inspections:184]Agency:13="MHD Underwater@")
		If ($tToBuilt#"")
			$msg:="Verify the e-mail address for "+$TmLdrName_txt+"."+$msg
		Else 
			$msg:="Please Enter the e-mail address for "+$TmLdrName_txt+"."+$msg
		End if 
		
		$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
		$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
		
	Else 
		ARRAY TEXT:C222($arr_ConsEmails_txt; 0)
		
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=(Substring:C12([TIN_Inspections:184]Agency:13; 1; \
			MaxNum((Length:C16([TIN_Inspections:184]Agency:13)\2); 3))\
			+"@"))
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Insp:20=True:C214)
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Email:18#"")
		If (Records in selection:C76([Conslt Address:77])>=1)
			SELECTION TO ARRAY:C260([Conslt Address:77]Email:18; $arr_ConsEmails_txt)
			If ($arr_ConsEmails_txt{1}#$tToBuilt)  //in case the contact is the team leader
				If ($tToBuilt#"")
					$tToBuilt:=$arr_ConsEmails_txt{1}+","+$tToBuilt
				Else 
					$tToBuilt:=$arr_ConsEmails_txt{1}
				End if 
			End if 
			
			If (Size of array:C274($arr_ConsEmails_txt)>1)
				$msg:="Verify the e-mail address for "+[TIN_Inspections:184]Agency:13+". You can also select an email address from the dropdown."+$msg
				$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
				$tToBuilt:=ut_Request($msg; ->$arr_ConsEmails_txt; $tToBuilt; ""; $CancelMsg_txt)
			Else 
				$msg:="Verify the e-mail address for "+[TIN_Inspections:184]Agency:13+"."+$msg
				$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
				$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
			End if 
			ARRAY TEXT:C222($arr_ConsEmails_txt; 0)
		Else 
			$msg:="Enter the e-mail address for "+[TIN_Inspections:184]Agency:13+"."+$msg
			$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
			$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
		End if 
		
End case 

If (OK=1)
	
	$tbCCBuilt:=""
	tSubject:="Notification for Inspection, TIN "+[TIN_Inspections:184]NTI_i1_S:1+",  "+String:C10([TIN_Inspections:184]InspDate:3; Internal date short:K1:7)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	tMailNote:="Inspection for TIN:"+[TIN_Inspections:184]NTI_i1_S:1+" inspected on "+String:C10([TIN_Inspections:184]InspDate:3; Internal date short:K1:7)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	If (vbReject=1)
		If (vtRevComments#"")
			tMailNote:=tMailNote+" was Rejected with the following comments : "+Char:C90(13)
			tMailNote:=tMailNote+vtRevComments+Char:C90(13)
		Else 
			tMailNote:=tMailNote+" was Rejected with no comments"+Char:C90(13)
		End if 
	Else 
		tMailNote:=tMailNote+" was Approved."+Char:C90(13)
	End if 
	tMailNote:=tMailNote+Char:C90(13)+"----------------------------------"+Char:C90(13)
	tMailNote:=tMailNote+"E-mail sent from 4D process executed by user "+<>PERS_MyFullName_txt+" on "+String:C10(Current date:C33(*); Internal date short:K1:7)+Char:C90(13)
	AuthUserName_txt:=""  //no authorization
	$SentOK:=False:C215  //A flag to indicate if we make it through all of the calls
	<>SHOWERRORS:=True:C214
	
	If (<>EmailMethod#"Outlook")
		
		SHORT_MESSAGE("Sending email...")
		
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
		
		CLOSE WINDOW:C154
		
	End if 
	
	If (Not:C34($SentOK))
		C_TEXT:C284(tToBuilt_txt; tCCBuilt_txt; vTextMsg; $res_txt)
		ARRAY TEXT:C222($To_atxt; 0)
		ARRAY TEXT:C222($CC_atxt; 0)
		ut_TextToArray($tToBuilt; ->$To_atxt; ",")
		ut_TextToArray($tCCBuilt; ->$CC_atxt; ",")
		$res_txt:=MAIL_scriptOutlook(->$To_atxt; ->$CC_atxt; tSubject; tMailNote)
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
	
End if 

tFromEmailAddress:=""
$tToBuilt:=""
$tCCBuilt:=""
$tbCCBuilt:=""
tSubject:=""
tMailNote:=""

$0:=$SentOK
//End Mail_SendTINRevuNotif