//%attributes = {"invisible":true}
//Method: ut_Launch_IE
//Description
//Launch Internet Explorer with a URL
// Parameters
// $1 : $url_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/09/14, 13:11:58
	// ----------------------------------------------------
	//Created : 
	Mods_2014_10
	C_TEXT:C284(ut_Launch_IE; $1)
End if 

C_TEXT:C284($1)
//
C_TEXT:C284($explorer_txt; $cmd_txt)
$explorer_txt:="C:\\Program Files\\Internet Explorer\\iexplore.exe"
C_LONGINT:C283($testIE_L)
$testIE_L:=Test path name:C476($explorer_txt)
$cmd_txt:="@echo off"+Char:C90(13)+Char:C90(10)
$cmd_txt:=$cmd_txt+"\""+$explorer_txt+"\"  \""+$1+"\""
C_BLOB:C604($batblob_blb)
TEXT TO BLOB:C554($cmd_txt; $batblob_blb)
C_TIME:C306($bat_t)
$bat_t:=Create document:C266(Temporary folder:C486+"mybat.bat")
CLOSE DOCUMENT:C267($bat_t)
BLOB TO DOCUMENT:C526(Temporary folder:C486+"mybat.bat"; $batblob_blb)
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
LAUNCH EXTERNAL PROCESS:C811(Temporary folder:C486+"mybat.bat")

//End ut_Launch_IE