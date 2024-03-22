//%attributes = {"invisible":true}
//Method: ut_DegMinSecToDeg
//Description
//  `convert degrees min seconds to decimal degrees
//  ` Parameters
//  ` $0 : $decDeg_r
//  ` $1 : $Degr_r
//  ` $2 : $Min_r
//  ` $3 : $sec_r
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/14/13, 16:02:14
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 

//
C_REAL:C285($decDeg_r; $Deg_r; $Min_r; $sec_r)
C_REAL:C285($0)
$decDeg_r:=0
$Deg_r:=0
$Min_r:=0
$sec_r:=0

If (Count parameters:C259>0)
	C_REAL:C285($1)
	$Deg_r:=$1
End if 
If (Count parameters:C259>1)
	C_REAL:C285($2)
	$Min_r:=$2
End if 
If (Count parameters:C259>2)
	C_REAL:C285($3)
	$sec_r:=$3
End if 

$decDeg_r:=$Deg_r+($Min_r/60)+($sec_r/3600)

$0:=$decDeg_r
//End ut_DegMinSecToDeg