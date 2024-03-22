//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): manousakisc
// Date and time: 09/01/11, 11:02:32
// ----------------------------------------------------
// Method: ut_LookupSMTPserver
// Description
// use nslookup to find the smtp server
// for testing puroposesƒ

//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($syscmd_txt; $incmd_txt; $outCmd_txt; $errmsg_txt)
C_TEXT:C284(<>pref_SMTP)
If (<>pref_SMTP="")
	<>pref_SMTP:=ut_GetSysParameter("MAIL_BRGSTATSMTP")
End if 

$syscmd_txt:="nslookup "+<>pref_SMTP

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")

LAUNCH EXTERNAL PROCESS:C811($syscmd_txt; $incmd_txt; $outCmd_txt; $errmsg_txt)

ut_BigAlert("Lookup for "+<>pref_SMTP+Char:C90(13)+$outCmd_txt+Char:C90(13)+$errmsg_txt)