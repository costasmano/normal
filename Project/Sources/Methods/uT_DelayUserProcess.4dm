//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_DelayUserProcess
// User name (OS): cjmiller
// Date and time: 12/18/07, 14:43:43
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//r001 `12/18/07, 14:44:02   `Upgrade to 2004 - ODBC pro changes
End if 
C_LONGINT:C283($procID_l; $ticks_l; $seconds_l)
C_TIME:C306($startTime)

$ticks_l:=20
$procID_l:=Current process:C322
// if not user/runtime, just delay process
If (Process number:C372("User/Custom Menus@")#$procID_l)
	DELAY PROCESS:C323($procID_l; $ticks_l)
	
	//if user/runtime, loop w/IDLE
Else 
	$startTime:=Current time:C178
	Repeat 
		IDLE:C311
		$seconds_l:=(Current time:C178-$startTime)+0
		If ($seconds_l<0)  // crossed midnight
			$seconds_l:=$seconds_l+86400  // add days worth of seconds
		End if 
	Until ($seconds_l*60>=$ticks_l)
	
End if 

//End ut_DelayUserProcess

