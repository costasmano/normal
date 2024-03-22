If (False:C215)
	//[DCM_Project];"DistrWorkOrderInput".DCM_DBIENOTIF_btn
	// Modified by: costasmanousakis-(Designer)-(12/13/10 09:48:10)
	Mods_2010_12
	// Modified by: costasmanousakis-(Designer)-(8/30/11 09:08:59)
	Mods_2011_08
	//Added call to ut_GenericHelp_OM
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		If (User in group:C338(Current user:C182; "DistrictMaintenance"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		If ([DCM_Project:138]Work_End_d:18#!00-00-00!)
			
			C_TEXT:C284($MailBody_txt; $Source)
			$Source:=ut_GetSysParameter("XML_DCMMAILTODBIE"; "")
			If ($source#"")
				READ ONLY:C145([Bridge MHD NBIS:1])
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[DCM_Project:138]BIN:5)
				GetDBIEinfo(String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60)))
				PROCESS 4D TAGS:C816($Source; $MailBody_txt)
				C_TEXT:C284(tMailNote; tSubject; tbCCBuilt; tCCBuilt_txt; tToBuilt_txt; tFromEmailAddress; tFromEmailAddress)
				tMailNote:=""
				tSubject:=""
				tbCCBuilt:=""
				tCCBuilt_txt:=""
				tToBuilt_txt:=""
				tFromEmailAddress:=""
				tFromEmailAddress:=""
				ARRAY TEXT:C222(MAILHeaderTypes_atxt; 0)
				tMailNote:=$MailBody_txt
				SET TEXT TO PASTEBOARD:C523(tMailNote)
				tToBuilt_txt:=vDBIEEmail
				tFromEmailAddress:=<>PERS_MyEmail_txt
				G_MyConfirm("Send the follwowing email to "+tToBuilt_txt+<>sCR+tMailNote; "SEND Email"; "Cancel")
				If (OK=1)
					ut_ControlSendMail
				End if 
				
			Else 
				ALERT:C41("Could not load required email template XML_DCMMAILTODBIE !!")
			End if 
		Else 
			ALERT:C41("Work End Date has not been entered yet!")
		End if 
	Else 
		ut_GenericHelp_OM("Send e-mail to DBIE about Work completion")
End case 