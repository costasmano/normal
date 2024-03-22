//%attributes = {"invisible":true}
If (False:C215)
	//procedure: sFillVar
	//by: Albert Leung
	//created: 5/1/97
	//purpose: fill a variable with specified number of chars
End if 

C_TEXT:C284($1; $s)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($t; $0)

C_LONGINT:C283($i; $2; $n)  //Command Replaced was o_C_INTEGER

$s:=$1  //Fill char
$n:=$2  //length of fill

$t:=""
For ($i; 1; $n)
	$t:=$t+$s
End for 
$0:=$t