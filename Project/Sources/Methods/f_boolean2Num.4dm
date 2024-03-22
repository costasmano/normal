//%attributes = {}
// ----------------------------------------------------
// Method: f_boolean2Num
// Description
//  ` Return a number (0 or 1 , or p2/p3)
// 
// Parameters
// $0 : $Value_r
// $1 : $Bool_b
// $2 : $TrueVal_r (optional default 1)
// $3 : $FalseVar_r (optional default 0)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/20/11, 09:21:38
	// First Release
	Mods_2011_10
End if 
C_REAL:C285($0; $Value_r)
C_BOOLEAN:C305($1)
C_REAL:C285($TrueVal_r; $FalseVar_r)
$TrueVal_r:=1
$FalseVar_r:=0
If (Count parameters:C259>1)
	C_REAL:C285($2)
	$TrueVal_r:=$2
End if 
If (Count parameters:C259>2)
	C_REAL:C285($3)
	$FalseVar_r:=$3
End if 
If ($1)
	$Value_r:=$TrueVal_r
Else 
	$Value_r:=$FalseVar_r
End if 

$0:=$Value_r