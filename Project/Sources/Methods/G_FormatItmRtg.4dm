//%attributes = {"invisible":true}
//G_FormatItmRtg
//Used in Damage and FCR/CMI inspection printed reports.
C_TEXT:C284($1; $vsItemRtg)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($0; $vsRes)  // Command Replaced was o_C_STRING length was 1

$vsItemRtg:=$1

If (Position:C15($vsItemRtg; "0;1;2;3;4;5;6;7;8;9")>0)
	$vsRes:=$vsItemRtg
Else 
	$vsRes:="-"
End if 
$0:=$vsRes