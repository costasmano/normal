//%attributes = {"invisible":true}
//Method: SFA_SharedServerAvail
//Description
// check if a shared server is available. uses ping to check
// Parameters
// $0 : $Availalble_b
// $1 : $ServerName_txt (can be name or IP address
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/17, 14:30:31
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	C_BOOLEAN:C305(SFA_SharedServerAvail; $0)
	C_TEXT:C284(SFA_SharedServerAvail; $1)
End if 
//

C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Availalble_b)
C_TEXT:C284($in; $out; $err; $ServerName_txt)
$ServerName_txt:=$1
C_LONGINT:C283($alive_L)
If (Folder separator:K24:12#":")
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811("ping -n 2 "+$ServerName_txt; $in; $out; $err)
	$alive_L:=Position:C15("could not find host"; $out)
	$Availalble_b:=Not:C34($alive_L>0)
	
Else 
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811("ping -c 2 "+$ServerName_txt; $in; $out; $err)
	$alive_L:=Position:C15("Unknown host"; $err)
	$Availalble_b:=Not:C34($alive_L>0)
	
End if 

$0:=$Availalble_b
//End SFA_SharedServerAvail