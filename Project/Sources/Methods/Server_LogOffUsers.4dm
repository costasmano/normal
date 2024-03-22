//%attributes = {"invisible":true}
// Method: Server_LogOffUsers
// Description
//  ` Logoff users after sending a warning message.
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/19/08, 12:28:07
	// ----------------------------------------------------
	//First Release
	Mods_2008_CM_5403
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:16:45)
	Mods_2023_04
	//  `Remove IDLE after Delay process
End if 

//delay process until it is 3:00 AM on the server - backup time
C_TIME:C306($Starting_t; $RunTime_t)
$Starting_t:=Current time:C178(*)
$RunTime_t:=Time:C179("3:00:00")
C_REAL:C285($TimeDiff)
$TimeDiff:=$RunTime_t-$Starting_t
DELAY PROCESS:C323(Current process:C322; (60*$TimeDiff))
ARRAY TEXT:C222($clients; 0)
ARRAY LONGINT:C221($methods; 0)
GET REGISTERED CLIENTS:C650($clients; $methods)
If (Size of array:C274($Clients)>0)
	C_TEXT:C284($LongMessage)
	$LongMessage:="Database Backup is in effect and cannot proceed unless you Log off the system!"
	$LongMessage:=$LongMessage+<>sCR+"Please Save your work and exit."
	$LongMessage:=$LongMessage+<>sCR+"If you don't your connection will be aborted at the end of this"
	$LongMessage:=$LongMessage+<>sCR+"message."
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($Clients))
		EXECUTE ON CLIENT:C651($clients{$i}; "ut_MessageDia"; $LongMessage; "LOG OFF WARNING!!!"; 2; 7)
	End for 
	
	//Now wait 18 mins - and abort whoever is left
	DELAY PROCESS:C323(Current process:C322; (60*60*18))
	//IDLE
	GET REGISTERED CLIENTS:C650($clients; $methods)
	For ($i; 1; Size of array:C274($Clients))
		EXECUTE ON CLIENT:C651($clients{$i}; "M_QUIT"; $LongMessage; "LOG OFF WARNING!!!"; 2; 7)
	End for 
	
End if 
//
