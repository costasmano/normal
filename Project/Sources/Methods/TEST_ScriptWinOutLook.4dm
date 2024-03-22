//%attributes = {"invisible":true}
//Method: TEST_ScriptWinOutLook
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/30/15, 11:57:52
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11
End if 
//
ARRAY TEXT:C222($emailsTo_atxt; 0)
ARRAY TEXT:C222($emailsCC_atxt; 0)
ARRAY TEXT:C222($emailsbcc_atxt; 0)
C_TEXT:C284($subj_txt; $body_txt)
ARRAY TEXT:C222($attachments_atxt; 0)
C_TEXT:C284($scriptsource_txt; $scriptFile_txt)

APPEND TO ARRAY:C911($emailsTo_atxt; "addr1@kaka.com")
APPEND TO ARRAY:C911($emailsTo_atxt; "addr2@kaka.com")
APPEND TO ARRAY:C911($emailsTo_atxt; "addr3@kaka.com")
APPEND TO ARRAY:C911($emailsCC_atxt; "addr4@akaka.com")
APPEND TO ARRAY:C911($emailsbcc_atxt; "addr5@akaka.com")
APPEND TO ARRAY:C911($emailsbcc_atxt; "addr6@akaka.com")

$subj_txt:="This is a test "+String:C10(Current date:C33(*))+" "+String:C10(Current time:C178(*))

$body_txt:="Hello there <br><br>"+"This will be fun<br><br>"+"The end"

C_TEXT:C284($To_txt; $CC_txt; $BCC_txt; $vbs_out_t; $vbs_err_t)
C_LONGINT:C283($arr_L)
For ($arr_L; 1; Size of array:C274($emailsTo_atxt))
	$To_txt:=$To_txt+(" ; "*Num:C11($arr_L>1))+$emailsTo_atxt{$arr_L}
End for 
For ($arr_L; 1; Size of array:C274($emailsCC_atxt))
	$CC_txt:=$CC_txt+(" ; "*Num:C11($arr_L>1))+$emailsCC_atxt{$arr_L}
End for 
For ($arr_L; 1; Size of array:C274($emailsbcc_atxt))
	$BCC_txt:=$BCC_txt+(" ; "*Num:C11($arr_L>1))+$emailsbcc_atxt{$arr_L}
End for 
C_TEXT:C284($file_txt; $script_path_t; $cscript_t; $retVal_txt)
ARRAY TEXT:C222($files_atxt; 0)
$file_txt:=Select document:C905(""; ""; "Pick attachment(s)"; Multiple files:K24:7; $files_atxt)
$scriptsource_txt:=$scriptsource_txt+"Set objOutlook = CreateObject(\"Outlook.Application\")"+Char:C90(13)
$scriptsource_txt:=$scriptsource_txt+"Set objMail = objOutlook.CreateItem(0)"+Char:C90(13)
$scriptsource_txt:=$scriptsource_txt+"objMail.To =\""+$To_txt+"\""+Char:C90(13)
$scriptsource_txt:=$scriptsource_txt+"objMail.cc =\""+$CC_txt+"\""+Char:C90(13)
$scriptsource_txt:=$scriptsource_txt+"objMail.bcc =\""+$bcc_txt+"\""+Char:C90(13)

$scriptsource_txt:=$scriptsource_txt+"objMail.Subject =\""+$subj_txt+"\""+Char:C90(13)
$scriptsource_txt:=$scriptsource_txt+"objMail.HTMLbody =\""+$body_txt+"\""+Char:C90(13)

For ($arr_L; 1; Size of array:C274($files_atxt))
	$scriptsource_txt:=$scriptsource_txt+"objMail.Attachments.Add(\""+$files_atxt{$arr_L}+"\")"+Char:C90(13)
End for 

$scriptsource_txt:=$scriptsource_txt+"objMail.Display"+Char:C90(13)+"Set objMail=Nothing"+Char:C90(13)+"Set objOutlook=Nothing"+Char:C90(13)
$script_path_t:=Temporary folder:C486+"$"+String:C10(Milliseconds:C459)+".vbs"
C_BLOB:C604($stdin_x; $stdout_x; $stderr_x; $script_x)
CONVERT FROM TEXT:C1011($scriptsource_txt; "UTF-16LE"; $script_x)
BLOB TO DOCUMENT:C526($script_path_t; $script_x)

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")

$cscript_t:="cscript //Nologo //U \""+$script_path_t+"\""
LAUNCH EXTERNAL PROCESS:C811($cscript_t; $stdin_x; $stdout_x; $stderr_x)
$vbs_out_t:=Convert to text:C1012($stdout_x; "UTF-16LE")

If (BLOB size:C605($stderr_x)#0) & (BLOB size:C605($stdout_x)=0)
	$retVal_txt:=Convert to text:C1012($stderr_x; "UTF-16LE")
Else 
	$retVal_txt:=Substring:C12($vbs_out_t; 1; Length:C16($vbs_out_t)-1)
End if 

If (User in group:C338(Current user:C182; "Design Access Group"))
	SHOW ON DISK:C922($script_path_t)
End if 

//End TEST_ScriptWinOutLook