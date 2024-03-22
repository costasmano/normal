//%attributes = {"invisible":true}
//  ut_ReturnTimeStampFromDate
//----------------------------------------------------
// Description
// This method will return a time stamp from a date and a time
//  `if no time Hours and minutes will be set to 1 Am for now
//
// Parameters
// $1 $PassedInDate_d
// $2 $PassedInTime_t (optional)
// $0 $ReturnTimeStamp_txt
// ----------------------------------------------------
If (False:C215)
	// User name (OS): cjmiller
	// Date and time: 
	// ----------------------------------------------------
	Mods_2004_CJM02
	Mods_2004_CM01
End if 
C_DATE:C307($1; $PassedInDate_d)
C_TIME:C306($2; $PassedInTime_t)
C_TEXT:C284($3)
C_TEXT:C284($ReturnTimeStamp_txt; $0; $Year_txt; $Month_txt; $Day_txt; $Time_txt)
$PassedInDate_d:=$1
If (Count parameters:C259=2)
	$PassedInTime_t:=$2
	$Time_txt:=String:C10($PassedInTime_t; HH MM:K7:2)
	$Time_txt:=Replace string:C233($Time_txt; ":"; "")
Else 
	$Time_txt:="0100"
End if 
If (Count parameters:C259=3)
	$PassedInTime_t:=$2
	$Time_txt:=String:C10($PassedInTime_t; HH MM SS:K7:1)
	$Time_txt:=Replace string:C233($Time_txt; ":"; "")
	C_TEXT:C284($TickCount_txt)
	$TickCount_txt:=String:C10(Tickcount:C458)
	$TickCount_txt:=Substring:C12($TickCount_txt; Length:C16($TickCount_txt)-4)
	$Time_txt:=$Time_txt+"_"+$TickCount_txt
	
End if 

$Year_txt:=String:C10(Year of:C25($PassedInDate_d))
$Month_txt:=String:C10(Month of:C24($PassedInDate_d); "00")
$Day_txt:=String:C10(Day of:C23($PassedInDate_d); "00")+$Time_txt
$ReturnTimeStamp_txt:=$Year_txt+$Month_txt+$Day_txt
$0:=$ReturnTimeStamp_txt