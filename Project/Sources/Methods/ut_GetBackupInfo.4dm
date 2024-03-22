//%attributes = {"invisible":true}
// Method: ut_GetBackupInfo
// Description
//  ` send email with backup information and statistics
// 
// Parameters
// $0 : $Return_txt
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/13/10, 09:45:47
	// ----------------------------------------------------
	
	Mods_2010_10
	// Modified by: costasmanousakis-(Designer)-(12/8/11 15:59:32)
	Mods_2011_12
	//  `Fixed email_to address when error : append the email from param MAIL_TRANSFEMRGLIST, not use only that one
	// Modified by: costasmanousakis-(Designer)-(12/12/11 09:03:26)
	Mods_2011_12
	//  `Added additional information on the email text to identify where the email is coming from
	Mods_2012_02  //r003   `Add function call to get backup info
	//Modified by: Charles Miller (2/14/12 16:24:17)
	// Modified by: Costas Manousakis-(Designer)-(6/21/18 09:36:58)
	Mods_2018_06_bug
	//  `added ARRAY TEXT(MAILAttachments_atxt;0)
	// Modified by: Costas Manousakis-(Designer)-(2023-10-10 11:50:52)
	Mods_2023_10
	//  `$priority_b was not evaluated - check if backupinfo contains "Priority Message!!"
End if 
C_BOOLEAN:C305($Priority_b)

C_TEXT:C284($Return_txt)
$Return_txt:=ut_ReturnBackupInfo
C_TEXT:C284($To_txt; $From_txt)
$From_txt:=ut_GetSysParameter("MAIL_BRGSTATFROM"; "Costas.Manousakis@MHD.state.ma.us")
$To_txt:=ut_GetSysParameter("MAIL_TRANSFCHKLIST"; "costas.manousakis@MHD.state.ma.us,cjmiller@informed-solutions.com")
$Priority_b:=(Position:C15("Priority Message!!"; $Return_txt)>0)
If ($Priority_b)
	$To_txt:=$To_txt+","+ut_GetSysParameter("MAIL_TRANSFEMRGLIST"; "costas.manousakis@MHD.state.ma.us,cjmiller@informed-solutions.com")
End if 
ARRAY TEXT:C222(MAILAttachments_atxt; 0)
ut_SendEmail($To_txt; $From_txt; ""; ""; $Return_txt; "Backup Info"; $Priority_b)
//$0:=$Return_txt