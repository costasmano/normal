//%attributes = {"invisible":true}
//G_ElmtRatingTxt
//convert a rating to a text taking into account possible blank rating
C_TEXT:C284($0; $1; $vsRatgT; $vsRatg)  // Command Replaced was o_C_STRING length was 2
$vsRatg:=$1
If (Position:C15($vsRatg; "0123456789N")>0)
	$vsRatgT:=$1
Else 
	$vsRatgT:="N"
End if 
$0:=$vsRatgT