//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Server_SetUpCronJob
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/14/20, 11:43:10
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08
End if 
//
TRACE:C157

//IcJ_Initialize 
//C_BOOLEAN($SendMail_b)
//If ($RunServerProcess_b)// no lonmger used as no registration needed
//C_LONGINT($Key;$Connected;$MaxUsers)
//C_STRING(80;$User)
//C_STRING(80;$Company)
//$Key:=0
//GET SERIAL INFORMATION($Key;$User;$Company;$Connected;$MaxUsers)
//C_BOOLEAN($RunServerProcess_b)
//$RunServerProcess_b:=True
//Case of 
//: ($Key=-1212100782)  `test machine license valid
//IcJ_Register("946275-600985-009488-596390")
//: ($Key=0)  `production machine
//IcJ_Register("946275-600985-009488-596390")
//: ($Key=0)  `external server
//IcJ_Register("946275-600985-009488-596390")
//Else 
//$RunServerProcess_b:=False
//End case 
//If ($RunServerProcess_b)

//$SendMail_b:=False
//C_TEXT($From_txt;$SMTPServer_txt;$Password_txt;$To_Txt;$Icj_DefaulHour_txt)
//C_LONGINT($IcJ_DefaultWaitAtStartUp_L;$IcJ_DefaultDelayInSeconds_L)
//$From_txt:=ut_GetSysParameter ("MAIL_BRGSTATFROM";"Costas.Manousakis@MHD.state.ma.us")
//$To_txt:=ut_GetSysParameter ("MAIL_TRANSFCHKLIST";"costas.manousakis@MHD.state.ma.us,cjmiller@informed-solutions.com")

//C_LONGINT($Port_l)
//$Port_l:=0
//$SMTPServer_txt:=ut_GetSysParameter ("MAIL_BRGSTATSMTP";"eot-mail.mhd.root.eot.gov")

//$Password_txt:=""
//IcJ_EmailInitialize (->$SendMail_b;->$SMTPServer_txt;->$From_txt;->$To_Txt;->$Port_l;->$From_txt;->$Password_txt)
//$Icj_DefaulHour_txt:="02:00"
//$IcJ_DefaultWaitAtStartUp_L:=60*60*5  //time to wait at startup
//$IcJ_DefaultDelayInSeconds_L:=60*60*1  //time between process runs
//IcJ_InitServerProcess (->$Icj_DefaulHour_txt;->$IcJ_DefaultWaitAtStartUp_L;->$IcJ_DefaultDelayInSeconds_L)
//end if
//End Server_SetUpCronJob