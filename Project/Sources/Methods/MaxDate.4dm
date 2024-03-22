//%attributes = {}
//GP MaxDate

//Return the maximum of any number of Dates.

C_LONGINT:C283($NoPars; $i)  //Command Replaced was o_C_INTEGER
C_DATE:C307($Max; $0)
C_DATE:C307(${1})  //parameters $1 to $n of date

$NoPars:=Count parameters:C259

If ($NoPars=0)
	$Max:=!00-00-00!
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