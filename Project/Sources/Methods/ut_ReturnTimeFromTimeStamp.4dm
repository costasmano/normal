//%attributes = {"invisible":true}
//ut_ReturnTimeFromTimeStamp
If (False:C215)
	Mods_2004_CM01
End if 
C_TEXT:C284($1; $PassedInTimeStamp_txt; $Hour_txt; $Minute_txt)
$PassedInTimeStamp_txt:=$1

C_TIME:C306($0; $ReturnTime_t)
$ReturnTime_t:=Time:C179("00:00:00")


If (Length:C16($PassedInTimeStamp_txt)>11)
	$Hour_txt:=Substring:C12($PassedInTimeStamp_txt; 9; 2)
	$Minute_txt:=Substring:C12($PassedInTimeStamp_txt; 11; 2)
	$ReturnTime_t:=Time:C179($Hour_txt+":"+$Minute_txt+":00")
End if 

$0:=$ReturnTime_t