//%attributes = {}
If (False:C215)
	//f_Date2String
	//July 18, 2003
	//Albert Leung
	//Convert date to string. 
	//@param $1date to format
	//@param $2 format constant
	//@param $3 value if 00/00/00
	Mods_2011_06  // CJ Miller`06/13/11, 17:00:25      ` Type all local variables for v11
End if 

C_TEXT:C284($0; $strdate)  // Command Replaced was o_C_STRING length was 255
C_DATE:C307($1; $date)
C_TEXT:C284($3; $null)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($2; $format)

$date:=$1
$format:=$2
$null:=$3

If ($date=!00-00-00!)
	$strdate:=$null
Else 
	$strdate:=String:C10($date; $format)
End if 
$0:=$strdate