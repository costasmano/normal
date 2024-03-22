//%attributes = {"invisible":true}
// Method: ut_OpenDocument
// Description
//  ` Open a document on disk. ; A replacement for the AP Shellexecute command.
// Parameters
// $1 : $DocPath_txt
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/11, 08:43:35
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2011_03
	// Modified by: costasmanousakis-(Designer)-(3/14/11 16:45:34)
	Mods_2011_03
	//  `Added _4D_OPTION_HIDE_CONSOLE";"true"
	// Modified by: Costas Manousakis-(Designer)-(4/7/21 14:41:51)
	Mods_2021_04
	//  `use folder separator to determine platform
End if 
C_TEXT:C284($1; $DocPath_txt)

$DocPath_txt:=$1
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")


If (Folder separator:K24:12=":")
	//Mac OS
	$DocPath_txt:=ut_HFS_to_POSIX($DocPath_txt)
	LAUNCH EXTERNAL PROCESS:C811("open "+"\""+$DocPath_txt+"\"")
Else 
	//windows
	LAUNCH EXTERNAL PROCESS:C811("cmd.exe /C  start \"\" \""+$DocPath_txt+"\"")
End if 