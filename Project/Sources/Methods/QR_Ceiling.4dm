//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/22/10, 21:28:46
	// ----------------------------------------------------
	// Method: QR_Ceiling
	//  ` Return the lowest multiple of 2nd param that is greater than or equal to the 1st Param.
	//  ` Emultates the Floor Excel function.
	// 
	// Parameters
	// $0 : $Group_r
	// $1 : $Value_r
	// $2 : $Spacing_r
	// ----------------------------------------------------
	
	Mods_2010_03
End if 
C_REAL:C285($0; $Group_l)
$Group_l:=-9999999
C_REAL:C285($1; $Value_r)
C_REAL:C285($2; $Spacing_r; $Delta_r)
$Value_r:=$1
$Spacing_r:=$2
$Delta_r:=0.00001  //a bit higher than the epsilon used in real comparison
If (Abs:C99($Spacing_r)>($Delta_r))
	$Group_l:=Int:C8($Value_r/$Spacing_r)
	$Group_l:=$Group_l*$Spacing_r
	If (($Group_l+$Delta_r)>$Value_r)
	Else 
		$Group_l:=$Group_l+$Spacing_r
	End if 
	
End if 

$0:=$Group_l