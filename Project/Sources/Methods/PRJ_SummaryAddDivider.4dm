//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SummaryAddDivider
// User name (OS): cjmiller
// Date and time: 03/30/06, 11:40:27
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_LONGINT:C283($0; $1; $Increment_l)
$Increment_l:=$1
$Increment_l:=$Increment_l+1
INSERT IN ARRAY:C227(PRJ_DetailHead_atxt; $Increment_l; 1)
INSERT IN ARRAY:C227(PRJ_Detail_atxt; $Increment_l; 1)
PRJ_DetailHead_atxt{$Increment_l}:="-----------"
PRJ_Detail_atxt{$Increment_l}:="-----------"
$Increment_l:=$Increment_l+1

$0:=$Increment_l
//End PRJ_SummaryAddDivider