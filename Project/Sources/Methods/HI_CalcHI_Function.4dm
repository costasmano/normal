//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/26/05, 08:40:13
	// ----------------------------------------------------
	// Method: HI_CalcHI_Function
	// Description
	// calculate HI based on CEV, TEV. Return -1 for TEV=0
	//
	// Parameters
	//$1 = CEV
	//$2 = TEV
	// ----------------------------------------------------
	Mods_2005_CM18
End if 
C_REAL:C285($0; $HI)
C_REAL:C285($1; $CEV; $2; $TEV)
$CEV:=$1
$TEV:=$2
$HI:=0
If (Abs:C99($TEV)>0.1)
	$HI:=Round:C94(100*($CEV/$TEV); 2)
Else 
	$HI:=-1
End if 

$0:=$HI