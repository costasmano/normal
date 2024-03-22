//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/21/10, 23:49:57
	// ----------------------------------------------------
	// Method: QR_Floor
	// Description
	//  ` Return the largest multiple of 2nd param that is less than or equal to the 1st Param.
	//  ` Emultates the Floor Excel function.
	// 
	// Parameters
	// $0 : $Group_r
	// $1 : $Value_r
	// $2 : $Spacing_r
	// ----------------------------------------------------
	
	Mods_2010_03
End if 
C_REAL:C285($0; $Group_r)
$Group_r:=-999999
C_REAL:C285($1; $Value_r)
C_REAL:C285($2; $Spacing_r; $Delta_r)
$Value_r:=$1
$Spacing_r:=$2
$Delta_r:=0.00001  //a bit higher than the epsilon used in real comparison
If (Abs:C99($Spacing_r)>$Delta_r)
	$Group_r:=Int:C8($Value_r/$Spacing_r)
	$Group_r:=$Group_r*$Spacing_r
End if 

$0:=$Group_r