//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Test_setServerTimeouts
//Description
//method to set timeouts on server - Execute on server attribute = on
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/20, 16:49:25
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
C_LONGINT:C283($servTimeout_L; $Remotetimeout_L; $IdleConnTimeout_L)
$servTimeout_L:=10  //minutes
$Remotetimeout_L:=2  //minutes
$IdleConnTimeout_L:=60  //seconds
ALERT:C41("Server timeout "+String:C10(Get database parameter:C643(4D Server timeout:K37:13))+" "+\
"4d remote "+String:C10(Get database parameter:C643(4D Remote mode timeout:K37:14))+" "+\
"Idle connection "+String:C10(Get database parameter:C643(Idle connections timeout:K37:51)))
$servTimeout_L:=Num:C11(Request:C163("Server timeout"; String:C10($servTimeout_L)))
$Remotetimeout_L:=Num:C11(Request:C163("Remote timeout"; String:C10($Remotetimeout_L)))
$IdleConnTimeout_L:=Num:C11(Request:C163("Idle timeout"; String:C10($IdleConnTimeout_L)))

SET DATABASE PARAMETER:C642(4D Server timeout:K37:13; $servTimeout_L)  // 10 minutes
SET DATABASE PARAMETER:C642(4D Remote mode timeout:K37:14; $Remotetimeout_L)  // 2 minutes
SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; $IdleConnTimeout_L)  // 60 seconds
SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; -$IdleConnTimeout_L)  // 60 seconds

ALERT:C41("Server timeout "+String:C10(Get database parameter:C643(4D Server timeout:K37:13))+" "+\
"4d remote "+String:C10(Get database parameter:C643(4D Remote mode timeout:K37:14))+" "+\
"Idle connection "+String:C10(Get database parameter:C643(Idle connections timeout:K37:51)))

//End Test_setServerTimeouts