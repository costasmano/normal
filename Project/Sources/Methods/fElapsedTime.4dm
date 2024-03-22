//%attributes = {"invisible":true}
If (False:C215)
	//fElapsedTime
	//Time in seconds elapsed between two pairs of date/time values
	//fElapsedTime(Date1;Time1;Date2;Time2) ->Longint
	// 
End if 

C_DATE:C307($1; $3)
C_TIME:C306($2; $4; $timediff)
C_LONGINT:C283($0; $seconds; $datediff)

$datediff:=$3-$1
$timediff:=$4-$2

$seconds:=$timediff+($datediff*24*60*60)

$0:=$seconds