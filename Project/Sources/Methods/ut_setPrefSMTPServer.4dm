//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: ut_setPrefSMTPServer
// Description
//  ` Set the SMTP server in global variable ◊pref_SMTP
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/24/11, 10:18:11
	// First Release
	Mods_2011_10
	// Modified by: costasmanousakis-(Designer)-(11/14/11 11:19:26)
	Mods_2011_11
	//  `Added check in the error output of nslookup. In windows the "can't find" might be in there
	// Modified by: Costas Manousakis-(Designer)-(5/14/12 )
	Mods_2012_05
	//  `use ut_ControlUserPrefs to load  the user prefs and supercede the ones in the DB. 
	//  `Added  Enviroment var settings
	// Modified by: Costas Manousakis-(Designer)-(10/17/16 17:20:48)
	Mods_2016_10
	//  `set ◊pref_New4DWR:=True
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 12:10:17)
	Mods_2016_10
	//  `remove set ◊pref_New4DWR:=True
End if 
C_TEXT:C284($db_pref_SMTP; <>pref_SMTP; $User_pref_SMTP)
<>pref_SMTP:=""
$db_pref_SMTP:=ut_GetSysParameter("MAIL_BRGSTATSMTP"; "eot-mail.mhd.root.eot.gov")
C_TEXT:C284($syscmd_txt; $incmd_txt; $outCmd_txt; $errmsg_txt)
$syscmd_txt:="nslookup "+$db_pref_SMTP

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")

LAUNCH EXTERNAL PROCESS:C811($syscmd_txt; $incmd_txt; $outCmd_txt; $errmsg_txt)
If ((Position:C15("can't find "+$db_pref_SMTP; $outCmd_txt)>0) | (Position:C15("can't find "+$db_pref_SMTP; $errmsg_txt)>0))
	//Try the IP SMTP servet
	$db_pref_SMTP:=ut_GetSysParameter("MAIL_BRGSTATSMTP_IP"; $db_pref_SMTP)
End if 
ut_ControlUserPrefs("LOAD")
If (<>pref_SMTP="")  //we got nothing from the user prefs - set it to DB prefs
	<>pref_SMTP:=$db_pref_SMTP
End if 
