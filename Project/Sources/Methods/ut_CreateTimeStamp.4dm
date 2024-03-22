//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_CreateTimeStamp
// User name (OS): cjmiller
// ----------------------------------------------------
// Description
// This method will return a 12 character time stamp
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 12
C_DATE:C307($date)
C_LONGINT:C283($time; $hours; $remainder; $minutes; $seconds; $millis)
$time:=Current time:C178(*)+0  //Force to a longint by adding zero
$date:=Current date:C33(*)
$hours:=$time\(3600)
$remainder:=($time-($hours*3600))
$minutes:=$remainder\60

$0:=String:C10(Year of:C25($date); "0000")+String:C10(Month of:C24($date); "00")+String:C10(Day of:C23($date); "00")+String:C10($hours; "00")+String:C10($minutes; "00")