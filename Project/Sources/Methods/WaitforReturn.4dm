//%attributes = {"invisible":true}
//procedure: WaitforReturn
//by: Albert Leung
//date: 2/6/97
//revised: 12/24/97 by Tom Nee
//purpose:  pause until user hits enter key

C_TIME:C306($SavedTime; $Interval)

ON EVENT CALL:C190("GetKey")
$Interval:=?00:05:00?  //Sound an alert every 5 minutes until user responds.
$SavedTime:=Current time:C178-$Interval
While (<>Key#3)
	IDLE:C311
	If ((Current time:C178-$SavedTime)>=$Interval)
		$SavedTime:=Current time:C178
		BEEP:C151
		BEEP:C151
		BEEP:C151
	End if 
End while 
<>Key:=0
ON EVENT CALL:C190("")