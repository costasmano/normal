//%attributes = {}
//GP MaxNum
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Return the maximum of any number of parameters.
//The parameters can be a combination of integers and reals.

C_LONGINT:C283($NoPars; $i)  //Command Replaced was o_C_INTEGER
C_REAL:C285($Max; $0)
C_REAL:C285(${1})  //parameters $1 to $n of real

$NoPars:=Count parameters:C259

If ($NoPars=0)
	$Max:=0
Else 
	$Max:=$1
	If ($NoPars>1)
		For ($i; 2; $NoPars)
			If (${$i}>$Max)
				$Max:=${$i}
			End if 
		End for 
	End if 
End if 

$0:=$Max