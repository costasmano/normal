//%attributes = {"invisible":true}
//Method: Test_GetNetworkDateTime
//Description
// tests to see if we can get the date and time from the internet
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/25/18, 15:33:07
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
	// Modified by: Costas Manousakis-(Designer)-(6/10/20 13:36:47)
	Mods_2020_06
	//  `force JSON Parse to return an object
End if 
//
C_TEXT:C284($input; $empty; $error; $output; $time)
C_LONGINT:C283($pos; $time_L)
$input:="curl -I https://www.google.com/"  // this gets GMT from Google

$empty:=""

LAUNCH EXTERNAL PROCESS:C811($input; $empty; $output; $error)


If ($output#"")
	
	$pos:=Position:C15("GMT"; $output)
	
	If ($pos>0)
		
		$time:=Substring:C12($output; $pos-9; 8)
		
		$pos:=Position:C15(":"; $time)
		
		If ($pos>0)
			
			$time_L:=Num:C11(Substring:C12($time; 1; $pos-1))
			
		End if 
		
	End if 
	
End if 

C_DATE:C307($netDate_d)
C_TIME:C306($netTime_t)
C_LONGINT:C283($netError_L)
C_LONGINT:C283($myOffset_L)
C_TEXT:C284($myOffset_t)
$myOffset_t:=GEN_GetTimeZoneOffset
$myOffset_L:=Num:C11(Substring:C12($myOffset_t; 1; Position:C15(":"; $myOffset_t)-1))
//$netError_L:=NET_Time ("www.apple.com";$netDate_d;$netTime_t;$myOffset_L)


$input:="curl http://worldclockapi.com/api/json/gmt/now"  // this gets GMT from worldclockapi
$input:="curl http://worldclockapi.com/api/json/est/now"  // this gets est from worldclockapi
$input:="curl http://worldclockapi.com/api/json/utc/now"  // this gets utc from worldclockapi

$empty:=""

LAUNCH EXTERNAL PROCESS:C811($input; $empty; $output; $error)
C_DATE:C307($testDate_d; $testDate2_d)
C_TIME:C306($testTime_t; $testTime2_t)
$testDate_d:=Current date:C33(*)  //server date time
$testTime_t:=Current time:C178(*)
$testDate2_d:=Current date:C33  //local date time
$testTime2_t:=Current time:C178

C_OBJECT:C1216($data_o)
$data_o:=JSON Parse:C1218($output; Is object:K8:27)

ARRAY TEXT:C222($objProps_atxt; 0)
OB GET PROPERTY NAMES:C1232($data_o; $objProps_atxt)

C_DATE:C307($mydate_d)
C_TIME:C306($mytime_t)
C_TEXT:C284($datetime_txt)
$mydate_d:=OB Get:C1224($data_o; "currentDateTime"; Is date:K8:7)  // these do not work
$mytime_t:=OB Get:C1224($data_o; "currentDateTime"; Is time:K8:8)  // these do not work

$datetime_txt:=OB Get:C1224($data_o; "currentDateTime"; Is text:K8:3)  // format is yyyy-mm-ddThh:mm-gg:00 (gg hrs ofset from GMT) 
$datetime_txt:=Substring:C12($datetime_txt; 1; 16)+":00"  //get date and time to minutes , add 00 seconds

C_TEXT:C284($testDateTime_txt)

$testDateTime_txt:=Substring:C12(String:C10($testDate_d; ISO date GMT:K1:10; $testTime_t); 1; 19)  //need to remove the last "Z" from ISO GMT
$testDateTime_txt:=Substring:C12(String:C10($testDate_d; ISO date:K1:8; $testTime_t); 1; 19)

C_TIME:C306($diff_t; $diff2_t)

$diff_t:=GEN_TimestampDifference($testDateTime_txt; $datetime_txt)

$testDateTime_txt:=Substring:C12(String:C10($testDate2_d; ISO date GMT:K1:10; $testTime2_t); 1; 19)
$testDateTime_txt:=Substring:C12(String:C10($testDate2_d; ISO date:K1:8; $testTime2_t); 1; 19)

$diff2_t:=GEN_TimestampDifference($testDateTime_txt; $datetime_txt)

ALERT:C41("Server clock is off by "+String:C10($diff_t)+" - Computer clock is off by : "+String:C10($diff2_t))

//get GMT time from internet
$input:="curl http://worldclockapi.com/api/json/gmt/now"  // this gets GMT from worldclockapi
$empty:=""
LAUNCH EXTERNAL PROCESS:C811($input; $empty; $output; $error)
C_OBJECT:C1216($data_o)
$data_o:=JSON Parse:C1218($output; Is object:K8:27)

$datetime_txt:=OB Get:C1224($data_o; "currentDateTime"; Is text:K8:3)  // format is yyyy-mm-ddThh:mm+XX:00 +XX:00 Need to account for this!!!!
//$datetime_txt:=Replace string($datetime_txt;"T";"Z")  // replace T with Z
$datetime_txt:=Substring:C12($datetime_txt; 1; 16)+":00"  // strip unneeded stuff and add seconds
C_OBJECT:C1216($localdatetime_o)
$localdatetime_o:=GEN_DateTim_GMT_To_Local($datetime_txt)
//convert to string
C_TEXT:C284($NetDateTime_t; $ComputerDateTime_t)
$NetDateTime_t:=OB Get:C1224($localdatetime_o; "string"; Is text:K8:3)
$ComputerDateTime_t:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
//find difference
C_TIME:C306($diff_t)
$diff_t:=GEN_TimestampDifference($ComputerDateTime_t; $NetDateTime_t)
ALERT:C41("Computer time is off from Net Time in worldclockapi by :"+String:C10($diff_t))


$input:="date -u +%Y-%m-%dT%H:%M:%S"
LAUNCH EXTERNAL PROCESS:C811($input; $empty; $output; $error)
$ComputerDateTime_t:=Substring:C12($output; 1; 19)

$input:="curl http://worldclockapi.com/api/json/utc/now"  // this gets utc from worldclockapi
$empty:=""
LAUNCH EXTERNAL PROCESS:C811($input; $empty; $output; $error)
C_OBJECT:C1216($data_o)
$data_o:=JSON Parse:C1218($output; Is object:K8:27)

$datetime_txt:=OB Get:C1224($data_o; "currentDateTime"; Is text:K8:3)  // format is yyyy-mm-ddThh:mm+XX:00 +XX:00 Need to account for this!!!!
//$datetime_txt:=Replace string($datetime_txt;"T";"Z")  // replace T with Z
$NetDateTime_t:=Substring:C12($datetime_txt; 1; 16)+":00"  // strip unneeded stuff and add seconds
$diff_t:=GEN_TimestampDifference($ComputerDateTime_t; $NetDateTime_t)
ALERT:C41("Computer time is off from Net Time in worldclockapi by :"+String:C10($diff_t))

//End Test_GetNetworkDateTime