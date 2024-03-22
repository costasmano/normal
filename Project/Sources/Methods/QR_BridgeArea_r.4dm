//%attributes = {"shared":true}
// Method: QR_BridgeArea_r
// Description
//  ` Calculate the Bridge Area for the current bridge record
// Parameters
// $0 : $Area_r
//  `Optional parameters for all items
// $1 : [Bridge MHD NBIS]Item49 
// $2 : [Bridge MHD NBIS]Item52
// $3 : [Bridge MHD NBIS]Item34
// $4 : [Bridge MHD NBIS]Item32
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/10, 09:32:22
	// ----------------------------------------------------
	// Method: QR_BridgeArea_r
	// Description
	//  ` Calculate the Bridge Area for the current bridge record
	// 
	// ----------------------------------------------------
	
	Mods_2010_11
	// Modified by: Costas Manousakis-(Designer)-(2/22/13 20:34:00)
	Mods_2013_02
	//  `Added optional parameters for all items
End if 

C_REAL:C285($0; $Area_r)
C_REAL:C285($i49_r; $i52_r; $i34_r; $i32_r)

If (Count parameters:C259>0)
	C_REAL:C285($1; $2; $3; $4)
	$i49_r:=$1
	$i52_r:=$2
	$i34_r:=$3
	$i32_r:=$4
Else 
	$i49_r:=[Bridge MHD NBIS:1]Item49:93
	$i52_r:=[Bridge MHD NBIS:1]Item52:97
	$i34_r:=[Bridge MHD NBIS:1]Item34:100
	$i32_r:=[Bridge MHD NBIS:1]Item32:98
End if 

If ($i52_r>0)
	$Area_r:=$i49_r*$i52_r  //Normal bridge
Else 
	If ($i34_r<=90)
		$Area_r:=$i32_r*($i49_r*Cos:C18($i34_r*Degree:K30:2))  // Culvert
	Else 
		//Large variation of skew - assume no skew
		$Area_r:=$i32_r*$i49_r  // Culvert
	End if 
	
End if 

$0:=$Area_r