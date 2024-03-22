//%attributes = {}
If (False:C215)
	//function: iAgeofBridge
	//by: Albert Leung
	//created: 9/19/97
	//purpose: find the age of bridge
	// Modified by: Costas Manousakis-(Designer)-(4/12/13 11:04:44)
	Mods_2013_04
	//  `Added optional parameter $3 to specify the 'present' year as a value gt zero
	//  `changed declarations to be C_longint to match compiler_methods
	// Modified by: Costas Manousakis-(Designer)-(8/6/14 15:20:56)
	Mods_2014_08_bug
	//  `fixed first Count parameters to > 1 from = 2
End if 

C_LONGINT:C283($0; $1; $2; $yearbuilt; $yrreconst; $presentyr; $age1; $age2)

If (Count parameters:C259>1)
	$yearbuilt:=$1
	$yrreconst:=$2
Else 
	$yearbuilt:=[Bridge MHD NBIS:1]Item27:83
	$yrreconst:=[Bridge MHD NBIS:1]Item106:84
End if 

$presentyr:=Year of:C25(Current date:C33(*))

If (Count parameters:C259>2)
	C_LONGINT:C283($3)
	If ($3>0)
		$presentyr:=$3
	End if 
End if 

$age1:=$presentyr-$yearbuilt
$age2:=$presentyr-$yrreconst
If ($age1<$age2)
	$0:=$age1
Else 
	$0:=$age2
End if 