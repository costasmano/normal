//%attributes = {}
//GP MatchInArr
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This works like Find in array except it doesn't have to match exactly.

C_TEXT:C284($name)  //The name to be matched.
C_POINTER:C301($ptr_aNames)  //A pointer to an array of names to be searched.
C_LONGINT:C283($0)  //Command Replaced was o_C_INTEGER//Return the matching array element.

C_LONGINT:C283($elems; $pos; $i)  //Command Replaced was o_C_INTEGER

$name:=$1
$ptr_aNames:=$2

$elems:=Size of array:C274($ptr_aNames->)
$i:=0
Repeat 
	$i:=$i+1
	//The position function ignores case.
	$pos:=Position:C15($name; $ptr_aNames->{$i})
	If (($pos>1) & (Length:C16($name)=1))
		//An initial was supplied but it was found past the first letter; keep looking.
		$pos:=0
	End if 
Until (($Pos>0) | ($i>=$elems))

If ($pos>0)
	$0:=$i
End if 