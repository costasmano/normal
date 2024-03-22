//%attributes = {"invisible":true}
//Method: Test_CheckInternetTime
//Description
// check computer time with internet time from US navy org
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/08/18, 17:14:30
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
End if 
//

C_TEXT:C284($usnotimer_txt)
C_LONGINT:C283($httpStatus_L)
$httpStatus_L:=HTTP Get:C1157("http://tycho.usno.navy.mil/timer.html"; $usnotimer_txt)
ARRAY TEXT:C222($usnotimer_atxt; 0)
ut_NewTextToArray($usnotimer_txt; ->$usnotimer_atxt; "<BR>")
C_LONGINT:C283($EasternLine_L)
$EasternLine_L:=Find in array:C230($usnotimer_atxt; "@Eastern@")
C_TEXT:C284($pattern_txt)
$pattern_txt:="([JFMASOND]{1}[a-z]{2})\\. (\\d\\d), (\\d\\d):(\\d\\d):(\\d\\d) ([AP]{1})M "
C_BOOLEAN:C305($pattMatch_b)
ARRAY LONGINT:C221($posfound_aL; 0)
ARRAY LONGINT:C221($Lenfound_aL; 0)

$pattMatch_b:=Match regex:C1019($pattern_txt; $usnotimer_atxt{$EasternLine_L}; 1; $posfound_aL; $Lenfound_aL)
C_TEXT:C284($month_txt; $AMPM_txt)
$month_txt:=Substring:C12($usnotimer_atxt{$EasternLine_L}; $posfound_aL{1}; 3)
$AMPM_txt:=Substring:C12($usnotimer_atxt{$EasternLine_L}; $posfound_aL{6}; 1)
C_LONGINT:C283($daten_L; $Hrs_L; $min_L; $Sec_L; $Month_L)
$daten_L:=Num:C11(Substring:C12($usnotimer_atxt{$EasternLine_L}; $posfound_aL{2}; 2))
$Hrs_L:=Num:C11(Substring:C12($usnotimer_atxt{$EasternLine_L}; $posfound_aL{3}; 2))
$min_L:=Num:C11(Substring:C12($usnotimer_atxt{$EasternLine_L}; $posfound_aL{4}; 2))
$Sec_L:=Num:C11(Substring:C12($usnotimer_atxt{$EasternLine_L}; $posfound_aL{5}; 2))


If ($AMPM_txt="P")
	$Hrs_L:=$Hrs_L+12
End if 

$Month_L:=Find in array:C230(<>aMonths; ($month_txt+"@"))
C_BOOLEAN:C305($date_err_b)
If ($Month_L#Month of:C24(Current date:C33))
	$date_err_b:=True:C214
End if 

If ($daten_L#Day of:C23(Current date:C33))
	$date_err_b:=True:C214
End if 
C_TIME:C306($usnotime_t; $myTime_t)
$myTime_t:=Current time:C178
$usnotime_t:=Time:C179(String:C10($Hrs_L)+":"+String:C10($min_L)+":"+String:C10($Sec_L))
C_LONGINT:C283($timeDiff)
$timeDiff:=Abs:C99($usnotime_t-$myTime_t)  //diff in seconds


Case of 
	: ($date_err_b)
		ALERT:C41("Computer Date is Wrong! Internet date and time is "+$usnotimer_atxt{$EasternLine_L})
	: ($timeDiff>(10*60))  //more than 10 minute time diff
		ALERT:C41("Computer Time is more than 10 minutes off! Internet date and time is "+$usnotimer_atxt{$EasternLine_L})
End case 

//End Test_CheckInternetTime