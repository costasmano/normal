//Method: Object Method: [Dialogs].Preferences.3D Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/12, 19:25:14
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
End if 
//
Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S; UPREFS_OldGenMsg_txt)
		UPREFS_OldGenMsg_txt:=vGenericHlpMsgVar1_S
		vGenericHlpMsgVar1_S:="Revert to Saved value."+Char:C90(13)+"Hold Shift key to retrieve value from DB..."
	: (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284(vGenericHlpMsgVar1_S; UPREFS_OldGenMsg_txt)
		If (UPREFS_OldGenMsg_txt#"")
			vGenericHlpMsgVar1_S:=UPREFS_OldGenMsg_txt
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Shift down:C543)
			User_SMTP_Server_txt:=ut_GetSysParameter("MAIL_BRGSTATSMTP")
		Else 
			ut_setPrefSMTPServer
			User_SMTP_Server_txt:=<>pref_SMTP
		End if 
		
End case 

//End Object Method: [Dialogs].Preferences.3D Button