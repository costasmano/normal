//%attributes = {"invisible":true}
// Method: Mail_SendInspRevuNotif
// Description
//  ` Send and email notification of an inspection review action
//  ` from DBIE to consultant
//  `  ` Email will be sent to team leader
//  `  ` For cons inspecions to the inspection contact of the consultant.  All inspection contacts will be available to be used if needed
//  ` the current user will be CC'd to receive the email.
//  ` The DBIE will be picked from the inspection report and from the current DBIE list 
//  ` he is not the sender or the team leader

// Parameters
// $0 : $SentOK : Boolean
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/21/06, 
	// ----------------------------------------------------
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(1/25/2007 14:24:12)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(1/27/2007 19:23:44)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(2/2/2007 12:33:22)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(5/29/2007 15:08:10)
	Mods_2007_CM10a
	// Modified by: costasmanousakis-(Designer)-(10/17/11 16:45:44)
	Mods_2011_10
	//  `Will now be able to send emails to Mass DOT team leaders, also notfy the DBIE
	// Modified by: costasmanousakis-(Designer)-(10/24/11 09:47:16)
	Mods_2011_10
	//  `Use global var ◊PERS_MyEmail_txt and method ut_setPrefSMTPServer
	// Modified by: costasmanousakis-(Designer)-(11/25/11 18:22:18)
	Mods_2011_11
	//  `For DBIE email add the DBIE Email to the cc list; if the curr user is not the DBIE. 
	//  `use method PERS_GetInfo to get personnel information.
	// Modified by: costasmanousakis-(Designer)-(12/5/11 18:20:50)
	Mods_2011_12
	//  `Clean up logic on selecting the DBIE who will be ccd upon review
	// Modified by: Costas Manousakis-(Designer)-(10/25/13 13:51:50)
	Mods_2013_10
	//  `Added ability to include more people in the cc of the notification. Use groups in the pers_groups table
	//  `named "DBIEReviewNotifCC" or "AreaReviewNotifCC" by inspection responsibility.
	//  `Dive (DV@), Tunnel (T@) or Rail (RR@) inspections are excluded for now.
	//  `Added to the message displayed the CC list;
	//  `Don't set Conslt Address table to RW if it was not RW before
	// Modified by: Costas Manousakis-(Designer)-(11/13/15 12:50:06)
	Mods_2015_11
	//  `If the email was not sent ok, show a window with the contents so that they can be copied to an email client.
	// Modified by: Costas Manousakis-(Designer)-(11/7/16 16:37:07)
	Mods_2016_11
	//  `added code instead of bringing up EmailDailog, try to script outlook  and then open dialog if there is error.
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: Costas Manousakis-(Designer)-(1/9/20 15:23:54)
	Mods_2020_01_bug
	//  `use the <>EmailMethod variable to choose how to send emails
	Mods_2020_05_bug
	//  `use at least 3 chars from the consultant name when searching addresses
	// Modified by: Costas Manousakis-(Designer)-(3/8/21 13:31:36)
	Mods_2021_03
	//  `enabled use of [Inspections]ConsQCEngrID field.
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return correct type
	// Modified by: manousakisc-(Designer)-(10/11/2023 13:04:24)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
End if 

C_LONGINT:C283($err; $smtp_id)
C_TEXT:C284(<>pref_SMTP; $Prevpref_SMTP_txt; tFromEmailAddress; $tToBuilt; $tCCBuilt; $tbCCBuilt; tSubject; tMailNote; AuthUserName_txt)
C_BOOLEAN:C305($0; $SentOK; $OK; <>SHOWERRORS; bMailPriority_b)
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
PERS_GetInfo([Inspections:27]TeamLeader:4; "FIRSTLAST"; ->$TmLdrName_txt; "EMAIL"; ->$TmLdrEmail_txt; "EMPLOYER"; ->$TmLdrEmployer_txt)
$TmLdrName_txt:=$TmLdrName_txt+" from: "+$TmLdrEmployer_txt
$tToBuilt:=$TmLdrEmail_txt
C_TEXT:C284($InspDBIE_Email_txt; $DBIEName_txt; $GroupDBIE_Email_txt)
$InspDBIE_Email_txt:=""  //email of dbie on insp report
$GroupDBIE_Email_txt:=""  //email of dbie from personnel groups
C_LONGINT:C283($InspDBIE_i; $BridgeDBIE_i)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
$InspDBIE_i:=[Inspections:27]DBrInspEngr:3
$BridgeDBIE_i:=-1
C_LONGINT:C283($Rowfound_L)
If ($InspDBIE_i#<>CurrentUser_PID)  //get the email of the DBIE on the inspetion form
	PERS_GetInfo($InspDBIE_i; "EMAIL"; ->$InspDBIE_Email_txt)
End if 
If ([Inspections:27]Insp Type:6#"DV@")
	$Rowfound_L:=Find in array:C230(<>INSP_DBIEResp_atxt; [Bridge MHD NBIS:1]InspResp:173)
	If ($Rowfound_L>0)
		$BridgeDBIE_i:=GRP_GetGroupRepID(<>INSP_DBIEGroups_atxt{$Rowfound_L})
	End if 
	If (($BridgeDBIE_i#$InspDBIE_i) & ($BridgeDBIE_i>0))
		PERS_GetInfo($BridgeDBIE_i; "EMAIL"; ->$GroupDBIE_Email_txt)
	End if 
	
	If (GRP_UserInGroup(<>INSP_DBIEGroups_atxt{$Rowfound_L}; $InspDBIE_i)=0)
		//if the SBIE is not ActiveDBIE - he does not get cc'd. he will if he is doing the review anyway.
		$InspDBIE_Email_txt:=""
	End if 
Else 
	//Special case for Dive inspections look in the UWInspEngineer pers_group to send emails
	$BridgeDBIE_i:=GRP_GetGroupRepID("UWInspEngineer")
	If (($BridgeDBIE_i#$InspDBIE_i) & ($BridgeDBIE_i>0))
		PERS_GetInfo($BridgeDBIE_i; "EMAIL"; ->$GroupDBIE_Email_txt)
	End if 
End if 

Case of 
	: ($GroupDBIE_Email_txt="") & ($InspDBIE_Email_txt="")
	: ($GroupDBIE_Email_txt="")
		$tCCBuilt:=$tCCBuilt+","+$InspDBIE_Email_txt
	: ($InspDBIE_Email_txt="")
		$tCCBuilt:=$tCCBuilt+","+$GroupDBIE_Email_txt
	Else 
		$tCCBuilt:=$tCCBuilt+","+$GroupDBIE_Email_txt+","+$InspDBIE_Email_txt
End case 

//Add Additional CCs depending on whether it is a DBIE review or an Area Review
//exclude Dive, Tunnel, Rail inspections for now
If (([Inspections:27]Insp Type:6#"DV@") & ([Inspections:27]Insp Type:6#"T@") & ([Inspections:27]Insp Type:6#"RR@"))
	ARRAY LONGINT:C221($ccIds_AL; 0)
	ARRAY TEXT:C222($ccNames_atxt; 0)
	C_TEXT:C284($CCgroupName_txt)
	Case of 
		: (vApproveLvl=1)
			$CCgroupName_txt:="DBIEReviewNotifCC"
		: (vApproveLvl=2)
			$CCgroupName_txt:="AreaReviewNotifCC"
	End case 
	
	$CCgroupName_txt:=$CCgroupName_txt+[Bridge MHD NBIS:1]InspResp:173
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
					If ($tCCBuilt#"")
						$tCCBuilt:=$tCCBuilt+","+[Personnel:42]EmailAddress_s:14
					Else 
						$tCCBuilt:=[Personnel:42]EmailAddress_s:14
					End if 
				End if 
			End if 
		End for 
		
		If (Not:C34($RoStatePersonnel_b))
			READ WRITE:C146([Personnel:42])
		End if 
	End if 
End if 

C_TEXT:C284($ConsQCEmail_txt; $Employer; $AgencyPrjMgrEmail_txt)
$ConsQCEmail_txt:=""
$AgencyPrjMgrEmail_txt:=""

C_TEXT:C284($msg; $CancelMsg_txt)
$CancelMsg_txt:="Don't Send Email"
$msg:=<>sCR+"Multiple addresses can be entered separated by comma"
Case of 
	: ([Inspections:27]Agency:156="Mass. Highway@") | ([Inspections:27]Agency:156="MHD Underwater@")
		If ($tToBuilt#"")
			$msg:="Verify the e-mail address for "+$TmLdrName_txt+"."+$msg
		Else 
			$msg:="Please Enter the e-mail address for "+$TmLdrName_txt+"."+$msg
		End if 
		$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
		$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
		
	Else 
		
		C_OBJECT:C1216($param_o)
		C_LONGINT:C283($PrjMgr_L)
		OB SET:C1220($param_o; "agency"; [Inspections:27]Agency:156; "structure"; "BIN")
		ARRAY TEXT:C222(arr_ConsEmails_txt; 0)
		If ([Inspections:27]ConsQCEngrID:205>0)
			//there is a Cons Qc engr assigned
			If ([Inspections:27]ConsQCEngrID:205#[Inspections:27]TeamLeader:4)
				
				PERS_GetInfo([Inspections:27]ConsQCEngrID:205; "EMAIL"; ->$ConsQCEmail_txt; "EMPLOYER"; ->$Employer)
				//check if QC employer is same as agency
				If ($Employer#[Inspections:27]Agency:156)
					//QC from different company - probably a case of a sub - get proj mgr 
					INSP_GetConsProjMgr($param_o)
					$PrjMgr_L:=OB Get:C1224($param_o; "mgrID"; Is longint:K8:6)
					If ($PrjMgr_L#0)
						$AgencyPrjMgrEmail_txt:=OB Get:C1224($param_o; "mgrEmail"; Is text:K8:3)
					End if 
				End if 
			Else 
				//TL same as QC - check if TL is from inspection agency
				PERS_GetInfo([Inspections:27]TeamLeader:4; "EMPLOYER"; ->$Employer)
				If ($Employer#[Inspections:27]Agency:156)
					//TL is from different company - get the Proj manager from the inspection agency
					INSP_GetConsProjMgr($param_o)
					$PrjMgr_L:=OB Get:C1224($param_o; "mgrID"; Is longint:K8:6)
					If ($PrjMgr_L#0)
						$ConsQCEmail_txt:=OB Get:C1224($param_o; "mgrEmail"; Is text:K8:3)
					End if 
				End if 
			End if 
			
		Else 
			// no QC - get the one for the inspection agency
			INSP_GetConsProjMgr($param_o)
			$PrjMgr_L:=OB Get:C1224($param_o; "mgrID"; Is longint:K8:6)
			If (($PrjMgr_L#0) & ($PrjMgr_L#[Inspections:27]TeamLeader:4))  //should not be the TL
				$ConsQCEmail_txt:=OB Get:C1224($param_o; "mgrEmail"; Is text:K8:3)
			End if 
		End if 
		
		//get emails from [Conslt Address]
		C_BOOLEAN:C305($ROStateConsAddrs_b)
		$ROStateConsAddrs_b:=Read only state:C362([Conslt Address:77])
		READ ONLY:C145([Conslt Address:77])
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=(Substring:C12([Inspections:27]Agency:156; 1; \
			MaxNum((Length:C16([Inspections:27]Agency:156)\2); 3))\
			+"@"))
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Insp:20=True:C214; *)
		QUERY SELECTION:C341([Conslt Address:77];  & ; [Conslt Address:77]Email:18#"")
		DISTINCT VALUES:C339([Conslt Address:77]Email:18; arr_ConsEmails_txt)
		
		If (Not:C34($ROStateConsAddrs_b))
			READ WRITE:C146([Conslt Address:77])
		End if 
		
		// check if the TL is in the list
		C_LONGINT:C283($dup_index_L)
		$dup_index_L:=Find in array:C230(arr_ConsEmails_txt; $tToBuilt)
		
		If ($dup_index_L>0)
			DELETE FROM ARRAY:C228(arr_ConsEmails_txt; $dup_index_L; 1)
		End if 
		// check if the QC engr in inspection record is in the list
		If ($ConsQCEmail_txt#"")
			$dup_index_L:=Find in array:C230(arr_ConsEmails_txt; $ConsQCEmail_txt)
			If ($dup_index_L>0)
				DELETE FROM ARRAY:C228(arr_ConsEmails_txt; $dup_index_L; 1)
			End if 
		End if 
		If ($AgencyPrjMgrEmail_txt#"")
			$dup_index_L:=Find in array:C230(arr_ConsEmails_txt; $AgencyPrjMgrEmail_txt)
			If ($dup_index_L>0)
				DELETE FROM ARRAY:C228(arr_ConsEmails_txt; $dup_index_L; 1)
			End if 
		End if 
		
		If ($ConsQCEmail_txt="") & ($AgencyPrjMgrEmail_txt="")
			//blank QC from insp report - get the first one if there is one
			If (Size of array:C274(arr_ConsEmails_txt)>0)
				$ConsQCEmail_txt:=arr_ConsEmails_txt{1}
				DELETE FROM ARRAY:C228(arr_ConsEmails_txt; 1; 1)
			End if 
		Else 
			//we have at least one - combine them
			If ($ConsQCEmail_txt#"")
				$ConsQCEmail_txt:=$ConsQCEmail_txt+","+$AgencyPrjMgrEmail_txt
			Else 
				$ConsQCEmail_txt:=$AgencyPrjMgrEmail_txt
			End if 
			
		End if 
		
		Case of 
			: ($ConsQCEmail_txt="") & (Size of array:C274(arr_ConsEmails_txt)=0)
				// got nothing so far
				$msg:="Enter the e-mail address for "+[Inspections:27]Agency:156+"."+$msg
				$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
				$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
				
			: ($ConsQCEmail_txt="") & (Size of array:C274(arr_ConsEmails_txt)>0)
				//this should not happen since we'll get the first element from arr_ConsEmails_txt
				
			: ($ConsQCEmail_txt#"") & (Size of array:C274(arr_ConsEmails_txt)=0)
				$msg:="Verify the e-mail address for "+[Inspections:27]Agency:156+"."+$msg
				$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
				$tToBuilt:=$tToBuilt+","+$ConsQCEmail_txt
				$tToBuilt:=ut_Request($msg; ->tFromEmailAddress; $tToBuilt; ""; $CancelMsg_txt)  //need a pointer to something not an array
				
			: ($ConsQCEmail_txt#"") & (Size of array:C274(arr_ConsEmails_txt)>0)
				$msg:="Verify the e-mail address for "+[Inspections:27]Agency:156+". You can also select an email address from the dropdown."+$msg
				$msg:=$msg+Char:C90(13)+"Email will also be sent to :"+$tCCBuilt
				$tToBuilt:=$tToBuilt+","+$ConsQCEmail_txt
				$tToBuilt:=ut_Request($msg; ->arr_ConsEmails_txt; $tToBuilt; ""; $CancelMsg_txt)
				
		End case 
		ARRAY TEXT:C222(arr_ConsEmails_txt; 0)
		
End case 

If (OK=1)
	
	$tbCCBuilt:=""
	tSubject:="Notification for "+[Inspection Type:31]Description:2+" Inspection, BIN "+[Inspections:27]BIN:1+",  "+String:C10([Inspections:27]Insp Date:78; Internal date short:K1:7)
	If (Is record loaded:C669([Bridge MHD NBIS:1]))
		UNLOAD RECORD:C212([Bridge MHD NBIS:1])
	End if 
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	READ ONLY:C145([Bridge MHD NBIS:1])
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	tMailNote:=G_Insp_SetTitle+" for BIN:"+[Inspections:27]BIN:1+"-BDEPT:"+[Bridge MHD NBIS:1]BDEPT:1+" inspected on "+String:C10([Inspections:27]Insp Date:78; Internal date short:K1:7)
	READ WRITE:C146([Bridge MHD NBIS:1])
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
		//Case of 
		//: (Not(mail_ErrorCheck("SMTP_New"; SMTP_New($smtp_id))))  //Creates a new message envelope assigned to $smtp_id
		//: (Not(SMTPAuth($smtp_id)))  //authorize if need be
		//: (Not(mail_ErrorCheck("SMTP_Host"; SMTP_Host($smtp_id; <>pref_SMTP; 0))))  //point to a smtp server that will handle our mail delivery
		//: (Not(mail_ErrorCheck("SMTP_From"; SMTP_From($smtp_id; tFromEmailAddress; 0))))  //
		//: (Not(mail_ErrorCheck("SMTP_ReplyTo"; SMTP_ReplyTo($smtp_id; tFromEmailAddress; 0))))  //reply to… 
		//: (Not(mail_ErrorCheck("SMTP_To"; SMTP_To($smtp_id; $tToBuilt; 0))))  //primary recipient{s} of the message
		//: (Not(mail_ErrorCheck("SMTP_Cc"; SMTP_Cc($smtp_id; $tCCBuilt; 0))))  //people who should get copies of the message
		//: (Not(mail_ErrorCheck("SMTP_Bcc"; SMTP_Bcc($smtp_id; $tbCCBuilt; 0))))  //people who will get the message w/o the others knowing it
		//: (Not(mail_ErrorCheck("SMTP_Subject"; SMTP_Subject($smtp_id; tSubject; 0))))  //the topic 
		//: (Not(mail_ErrorCheck("SMTP_Comments"; SMTP_Comments($smtp_id; "Sent via 4D INTERNET Tools from MHD BMS"; 0))))  //extra junk to put in header, recipient not likely to see this
		//: (Not(mail_ErrorCheck("SMTP_Body"; SMTP_Body($smtp_id; tMailNote; 0))))
		//: (Not(mail_ErrorCheck("SMTP_Send"; SMTP_Send($smtp_id))))  //were done, so let's send it...
		//Else 
		//$SentOK:=True  //message was composed and mailed successfully
		
		//End case 
		
		//If ($smtp_id#0)  //If a Message Envelope was created we should clear it now
		//$OK:=mail_ErrorCheck("SMTP_Clear"; SMTP_Clear($smtp_id))  //clear our message from memory and free up space
		//End if 
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
			
			If (Get application info:C1599.headless | Get application info:C1599.launchedAsService)
				// don't show alert if headless or running as service
			Else 
				ALERT:C41("An error occurred sending the mail: "+$status.statusText)
			End if 
		Else 
			$SentOK:=True:C214
		End if 
		
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