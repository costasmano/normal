//%attributes = {"invisible":true}
// ut_ControlSendMail
// User name (OS): charlesmiller
// Date and time: 02/11/10, 11:10:22
// ----------------------------------------------------
// Description
// This method initializes process variables needed to send the email.
// Then sends the email.
//  ` tFromEmailAddress ; tToBuilt_txt ; tCCBuilt_txt ; tbCCBuilt ; 
//  `tSubject ; tMailNote ; AuthUserName_txt ; AuthPassword_txt ; ◊pref_SMTP ;
//  ` MAILHeaderTypes_atxt ; MAILHeaderValues_atxt ; MAILAttachments_atxt
// Parameters
// $1 : $Task_txt ("INIT" | "SEND" : default)
// ----------------------------------------------------
If (False:C215)
	Mods_2010_02  //r001 CJ Miller`02/11/10, 11:10:24      `Add methods to control sending of email
	// Modified by: costasmanousakis-(Designer)-(2/28/11 11:06:08)
	Mods_2011_02
	//  `Added optional first parameter and case statement to initialize all needed variables
	// Modified by: costasmanousakis-(Designer)-(10/24/11 10:36:06)
	Mods_2011_10
	//  `Use method ut_setPrefSMTPServer
	// Modified by: Costas Manousakis-(Designer)-(2/23/18 12:14:57)
	Mods_2018_02
	//  `remove IT_MacTCPInit
	// Modified by: Costas Manousakis-(Designer)-(2023-10-03 10:41:49)
	Mods_2023_10
	//  `Added handling of attachments and headers
	// Modified by: manousakisc-(Designer)-(10/11/2023 13:04:24)
	Mods_2023_10
	//  `check if running as service or headless before showing Alert in case of error in email sending
End if 
C_BOOLEAN:C305($0; $SentOK; $OK)
C_TEXT:C284($Task_txt)
$Task_txt:="SEND"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	If ($1#"")
		$Task_txt:=$1
	End if 
	
End if 

Case of 
	: ($Task_txt="INIT")
		C_TEXT:C284(tFromEmailAddress; tToBuilt_txt; tCCBuilt_txt; tbCCBuilt; tSubject; tMailNote; AuthUserName_txt; AuthPassword_txt; <>pref_SMTP)
		tFromEmailAddress:=""
		tToBuilt_txt:=""
		tCCBuilt_txt:=""
		tbCCBuilt:=""
		tSubject:=""
		tMailNote:=""
		AuthUserName_txt:=""
		AuthPassword_txt:=""
		If (<>pref_SMTP="")
			ut_setPrefSMTPServer
		End if 
		ARRAY TEXT:C222(MAILHeaderTypes_atxt; 0)
		ARRAY TEXT:C222(MAILHeaderValues_atxt; 0)
		ARRAY TEXT:C222(MAILAttachments_atxt; 0)
		C_BOOLEAN:C305(<>SHOWERRORS)
		
		$0:=True:C214
		
	: ($Task_txt="SEND")
		C_LONGINT:C283($error_l; $smtp_id)
		$error_l:=0
		
		//$error_l:=IT_MacTCPInit 
		$SentOK:=False:C215
		
		
		//$smtpPort:=587  // Google SMTP port
		
		
		If ($error_l=0)
			
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
			
			If (Size of array:C274(MAILAttachments_atxt)>0)
				$email.attachments:=New collection:C1472
				C_LONGINT:C283($attch_L)
				For ($attch_L; 1; Size of array:C274(MAILAttachments_atxt))
					$email.attachments.push(MAIL New attachment:C1644(MAILAttachments_atxt{$attch_L}))
				End for 
				
			End if 
			
			If (Size of array:C274(MAILHeaderTypes_atxt)>0)
				$email.headers:=New collection:C1472
				C_LONGINT:C283($header_L)
				C_TEXT:C284($value_txt)
				For ($header_L; 1; Size of array:C274(MAILHeaderTypes_atxt))
					$value_txt:=MAILHeaderValues_atxt{$header_L}
					Case of 
						: (MAILHeaderTypes_atxt{$header_L}="Disposition-Notification-To")
							//need to make sure that the email address is just that. 
							C_BOOLEAN:C305($embedaddress_b)
							ARRAY LONGINT:C221($pos_aL; 0)
							ARRAY LONGINT:C221($len_aL; 0)
							C_TEXT:C284($notifyEmail_txt)
							$embedaddress_b:=Match regex:C1019("<(.*)@(.*)>"; $value_txt; 1; $pos_aL; $len_aL)
							If ($embedaddress_b)
								$value_txt:=Substring:C12($value_txt; $pos_aL{1}; $len_aL{1})+"@"+Substring:C12($value_txt; $pos_aL{2}; $len_aL{2})
							End if 
					End case 
					
					$email.headers.push(New object:C1471("name"; MAILHeaderTypes_atxt{$header_L}; "value"; $value_txt))
					
				End for 
				
			End if 
			
			$status:=$transporter.send($email)
			
			If (Not:C34($status.success))
				//start of changes Mods_2023_10 10/11/2023
				
				// check if running headless
				If (Get application info:C1599.headless | Get application info:C1599.launchedAsService)
					// don't show alert if headless or running as service
				Else 
					ALERT:C41("An error occurred sending the mail: "+$status.statusText)
				End if 
				//end of changes Mods_2023_10 10/11/2023
			Else 
				$SentOK:=True:C214
			End if 
			
			
			//If ($smtp_id#0)  //If a Message Envelope was created we should clear it now
			//$OK:=mail_ErrorCheck("SMTP_Clear"; SMTP_Clear($smtp_id))  //clear our message from memory and free up space
			//End if 
		End if 
		$0:=$SentOK
		
End case 

//End ut_ControlSendMail