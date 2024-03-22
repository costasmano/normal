//%attributes = {"invisible":true}
//Method: Test_SetClientTimeout
//Description
// method to set client timeouts
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/20, 16:42:13
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
C_LONGINT:C283($curr4Dremote_L; $currIdle_L; $newremote; $newIdle)
C_TEXT:C284($newremote_txt; $newidle_txt)

$curr4Dremote_L:=Get database parameter:C643(4D Remote mode timeout:K37:14)
$currIdle_L:=Get database parameter:C643(Idle connections timeout:K37:51)
ALERT:C41("Remote timeout "+String:C10($curr4Dremote_L)+"  Idle timeout "+String:C10($currIdle_L))
$newremote_txt:=Request:C163("4D Remote timeout"; String:C10($curr4Dremote_L))
$newremote:=Num:C11($newremote_txt)
$newidle_txt:=Request:C163("Idle connections timeout"; String:C10($currIdle_L))
$newIdle:=Num:C11($newidle_txt)

If (($newremote>0) & ($newIdle>0))
	CONFIRM:C162("Change Remote timeout to "+String:C10($newremote)+" and idle timeout to "+String:C10($newIdle)+" ?")
	
	If (OK=1)
		
		SET DATABASE PARAMETER:C642(4D Remote mode timeout:K37:14; $newremote)  // 2 minutes
		SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; $newIdle)  // 60 seconds
		SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; -$newIdle)  // 60 seconds
		
	End if 
Else 
	ALERT:C41("Both new settings must be > 0! [Remote timeout : "+String:C10($newremote)+"  Idle timeout : "+String:C10($newIdle)+"]")
End if 

//End Test_SetClientTimeout