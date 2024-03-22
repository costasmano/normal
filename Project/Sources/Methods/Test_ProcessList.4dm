//%attributes = {"invisible":true}
//Test_ProcessList
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($i; $vlpcount; $vlpstate; $vlptime)
C_TEXT:C284($vspname)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($vtmsg)
$vlpcount:=Count tasks:C335
$vtmsg:=$1+Char:C90(13)
For ($i; 1; $vlpcount)
	PROCESS PROPERTIES:C336($i; $vspname; $vlpstate; $vlptime)
	$vtmsg:=$vtmsg+"Prc "+String:C10($i)+" - "+$vspname+" - "+String:C10($vlpstate)+" - "+String:C10($vlptime)+Char:C90(13)
End for 
//g_WrLogMsg ("ProcessList";$vtmsg)
g_WrLogMsg(<>MHDBMSExitLog; $vtmsg)