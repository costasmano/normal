//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJ_SetDate
// User name (OS): cjmiller
// Date and time: 06/15/06, 14:05:26
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 text or string to check if a date
//$2 pointer to field or variable to set if passed in string is a date

// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_TEXT:C284($1; $Date_txt)
$Date_txt:=$1
C_DATE:C307($Test_d; $0)
$Date_txt:=$1
$0:=!00-00-00!
C_DATE:C307($Test_d)
C_LONGINT:C283($ArrayPosition_l)
ARRAY TEXT:C222($MonthNames_as; 12)  //Command Replaced was o_ARRAY string length was 4
$MonthNames_as{1}:="Jan/"
$MonthNames_as{2}:="Feb/"
$MonthNames_as{3}:="Mar/"
$MonthNames_as{4}:="Apr/"
$MonthNames_as{5}:="May/"
$MonthNames_as{6}:="Jun/"
$MonthNames_as{7}:="Jul/"
$MonthNames_as{8}:="Aug/"
$MonthNames_as{9}:="Sep/"
$MonthNames_as{10}:="Oct/"
$MonthNames_as{11}:="Nov/"
$MonthNames_as{12}:="Dec/"


$ArrayPosition_l:=Find in array:C230($MonthNames_as; Substring:C12($Date_txt; 1; 4))
If ($ArrayPosition_l>0)
	$Date_txt:=String:C10($ArrayPosition_l; "00")+Substring:C12($Date_txt; 4)
End if 
$Test_d:=Date:C102($Date_txt)

If ((String:C10($Test_d; 4)=$Date_txt) | (String:C10($Test_d)=$Date_txt))
	$0:=$Test_d
End if 
//End ut_PRJ_SetDate