//%attributes = {"invisible":true}
//Method: LSS_SendAcceptRejectEmail
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 11/12/15, 15:45:19
	//----------------------------------------------------
	Mods_2015_11  // Add ability to approve or reject  LSS inspections
	//Modified by: administrator (11/12/15 16:57:01)
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: Costas Manousakis-(Designer)-(2/11/20 16:12:14)
	Mods_2020_02_bug
	//  `use the <>EmailMethod variable to choose how to send emails
	// Modified by: Costas Manousakis-(Designer)-(9/18/20 18:10:33)
	Mods_2020_09_bug
	//  `Send comments that might have been entered in the review dialog upon approval. Call Reference #747
	// Modified by: manousakisc-(Designer)-(10/11/2023 13:04:24)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
End if 

C_LONGINT:C283($error_L; $smtp_id)
//$error_L:=IT_MacTCPInit 
If (<>pref_SMTP="")
	ut_setPrefSMTPServer
End if 
C_TEXT:C284($PersonLoggedInName_txt; $PersonLoggedInEmail_txt; $PersonLoggedInEmployer_txt; $tCCBuilt; $Email_txt; $tToBuilt)
C_TEXT:C284($InspectionType_txt; $InspectionTypeID_txt)
C_BOOLEAN:C305($SentOK; $OK)
C_TEXT:C284($tToBuilt; $tbCCBuilt)

tFromEmailAddress:="MADOT Insp Review <donotreply@DOT.state.ma.us>"
PERS_GetInfo(<>CurrentUser_PID; "FIRSTLAST"; ->$PersonLoggedInName_txt; "EMAIL"; ->$PersonLoggedInEmail_txt; "EMPLOYER"; ->$PersonLoggedInEmployer_txt)

$PersonLoggedInName_txt:=$PersonLoggedInName_txt+" from: "+$PersonLoggedInEmployer_txt

$tCCBuilt:=""
$tToBuilt:=""
If (<>PERS_MyEmail_txt#"")
	tFromEmailAddress:=<>PERS_MyEmail_txt
	$tCCBuilt:=tFromEmailAddress
End if 
//$tToBuilt:=$PersonLoggedInName_txt
If ([LSS_Inspection:164]LSS_DistHWYEngineerId_L:5#<>CurrentUser_PID)  //get the email of the DistHWY rep on the inspetion form
	PERS_GetInfo([LSS_Inspection:164]LSS_DistHWYEngineerId_L:5; "EMAIL"; ->$Email_txt)
	If ($Email_txt#"")
		If ($tCCBuilt="")
			$tCCBuilt:=$Email_txt
		Else 
			$tCCBuilt:=$tCCBuilt+","+$Email_txt
		End if 
	End if 
End if 

If ([LSS_Inspection:164]LSS_TeamLeaderId_L:8#0)
	If ([LSS_Inspection:164]LSS_TeamLeaderId_L:8#<>CurrentUser_PID)
		PERS_GetInfo([LSS_Inspection:164]LSS_TeamLeaderId_L:8; "EMAIL"; ->$Email_txt)
		If ($Email_txt#"")
			If ($tToBuilt="")
				$tToBuilt:=$Email_txt
			Else 
				$tToBuilt:=$tToBuilt+","+$Email_txt
			End if 
		End if 
	End if 
End if 

If ([LSS_Inspection:164]LSS_ProjectManagerId_L:9#0)
	If ([LSS_Inspection:164]LSS_ProjectManagerId_L:9#<>CurrentUser_PID)
		PERS_GetInfo([LSS_Inspection:164]LSS_ProjectManagerId_L:9; "EMAIL"; ->$Email_txt)
		If ($Email_txt#"")
			If ($tToBuilt="")
				$tToBuilt:=$Email_txt
			Else 
				$tToBuilt:=$tToBuilt+","+$Email_txt
			End if 
			
		End if 
	End if 
End if 
$InspectionTypeID_txt:=[LSS_Inspection:164]LSS_InspectionTypeId_s:3

Begin SQL
	select [LSS_refInspectionType].[LSS_Description_txt]
	from [LSS_refInspectionType]
	where 
	[LSS_refInspectionType].[LSS_InspectionTypeId_s] = :$InspectionTypeID_txt
	into
	:$InspectionType_txt
End SQL
C_TEXT:C284(tMailNote)

Case of 
	: (Substring:C12($InspectionTypeID_txt; 1; 2)="IT")
		tMailNote:=$InspectionType_txt+" ITS Inspection"
		
	: (Substring:C12($InspectionTypeID_txt; 1; 2)="HS")
		tMailNote:=$InspectionType_txt+" HIGHWAY SIGN Inspection"
	: (Substring:C12($InspectionTypeID_txt; 1; 2)="LI")
		tMailNote:=$InspectionType_txt+" OVERHEAD LIGHT Inspection"
	: (Substring:C12($InspectionTypeID_txt; 1; 2)="SI")
		tMailNote:=$InspectionType_txt+" SIGNAL Inspection"
		
End case 

tMailNote:=tMailNote+" for Ancillary Structure : "+[LSS_Inventory:165]LSS_StructureNumber_s:6+" inspected on "+String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4; Internal date short:K1:7)
tSubject:="Notification for "+tMailNote

If ([LSS_Inspection:164]LSS_Approved_L:43=BMS Rejected)
	If (vtRevComments#"")
		tMailNote:=tMailNote+" was Rejected with the following comments : "+Char:C90(13)
		tMailNote:=tMailNote+[LSS_Inspection:164]LSS_ApprovalComments_txt:49+Char:C90(13)
	Else 
		tMailNote:=tMailNote+" was Rejected with no comments"+Char:C90(13)
	End if 
Else 
	If (vtRevComments#"")
		tMailNote:=tMailNote+" was Approved with the following comments : "+Char:C90(13)
		tMailNote:=tMailNote+vtRevComments+Char:C90(13)
	Else 
		tMailNote:=tMailNote+" was Approved."+Char:C90(13)
	End if 
	
End if 
tMailNote:=tMailNote+Char:C90(13)+"----------------------------------"+Char:C90(13)
tMailNote:=tMailNote+"E-mail sent from 4D process executed by user "+<>PERS_MyFullName_txt+" on "+String:C10(Current date:C33(*); Internal date short:K1:7)+Char:C90(13)

CONFIRM:C162("Send automated email to TL and Proj Mgr?"; "Send"; "Do Not Send")
If (OK=1)
	$SentOK:=False:C215
	<>SHOWERRORS:=True:C214
	AuthUserName_txt:=""  //no authorization
	
	If (<>EmailMethod#"Outlook")
		
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
		
		//CLOSE WINDOW
		
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
			vTextMsg:="Error Sending Email!  Contents of the email are below. You can copy and paste these contents to your email client to send manually."
			C_LONGINT:C283($emailWin_L)
			$emailWin_L:=Open form window:C675("EmailDialog"; Plain form window:K39:10)
			DIALOG:C40("EmailDialog")
			CLOSE WINDOW:C154
			
		End if 
	End if 
	
End if 

tFromEmailAddress:=""
$tToBuilt:=""
$tCCBuilt:=""
$tbCCBuilt:=""
tSubject:=""
tMailNote:=""

//End LSS_SendAcceptRejectEmail