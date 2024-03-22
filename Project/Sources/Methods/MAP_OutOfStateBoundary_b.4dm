//%attributes = {"invisible":true}
//Method: MAP_OutOfStateBoundary_b
//Description
//  ` return true or false if lat long coords are within a squeare boundary defined by the MA outline
// Parameters
// $0 : $outofBoundary_b
// $1 : $lat_r
// $2 : $long_r
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/02/13, 11:02:15
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
End if 
//

C_BOOLEAN:C305($0; $outofBoundary_b)
C_REAL:C285($1; $2)
$outofBoundary_b:=False:C215
Case of 
	: (($1>=41.23472) & ($1<=42.8864))
	: (($2>=69.92846) & ($2<=73.50851))
	Else 
		$outofBoundary_b:=True:C214
End case 

$0:=$outofBoundary_b

//End MAP_OutOfStateBoundary_b