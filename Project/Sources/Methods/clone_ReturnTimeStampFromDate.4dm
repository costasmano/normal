//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/03/12, 14:23:01
//----------------------------------------------------
//Method: clone_ReturnTimeStampFromDate method for Informed Cron4Dª
//copyright 2013 Informed Solutions, Inc. All rights reserved.
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
End if 
C_DATE:C307($1; $PassedInDate_d)
C_TIME:C306($2; $PassedInTime_t)
C_TEXT:C284($0)
C_TEXT:C284($ReturnTimeStamp_s; $0; $Year_s; $Month_s; $Day_s; $Time_s)  // Command Replaced was o_C_STRING length was 14
$PassedInDate_d:=$1
If (Count parameters:C259=2)
	$PassedInTime_t:=$2
	$Time_s:=String:C10($PassedInTime_t; HH MM:K7:2)
	$Time_s:=Replace string:C233($Time_s; ":"; "")
Else 
	$Time_s:="0100"
End if 

$Year_s:=String:C10(Year of:C25($PassedInDate_d))
$Month_s:=String:C10(Month of:C24($PassedInDate_d); "00")
$Day_s:=String:C10(Day of:C23($PassedInDate_d); "00")+$Time_s
$ReturnTimeStamp_s:=$Year_s+$Month_s+$Day_s
$0:=$ReturnTimeStamp_s
//End ut_ReturnTimeStampFromCurrentDa

