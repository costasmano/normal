//%attributes = {"invisible":true}
If (False:C215)
	//F_RemoveFeatIntCode 
	Mods_2004_CM07
	
End if 

C_TEXT:C284($0; $1; $param)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284($code)  // Command Replaced was o_C_STRING length was 10

$param:=$1
$code:=Substring:C12($param; 1; Position:C15(" "; $param)-1)

//remove Feature Intersected Code
Case of 
	: (($code="HWY") | ($code="RR") | ($code="TR") | ($code="WATER") | ($code="OTHER") | ($code="COMB"))
		$param:=Delete string:C232($param; 1; Position:C15(" "; $param))
		
	: (($code="I") | ($code="US") | ($code="ST"))
		$param:=Replace string:C233($param; "  "; " ")
End case 

//remove any leading spaces
C_BOOLEAN:C305($bLoop)
$bLoop:=True:C214
While ($bLoop)
	//the first character  
	If (Substring:C12($param; 1; 1)=" ")
		$param:=Delete string:C232($param; 1; 1)
	Else 
		$bLoop:=False:C215
	End if 
End while 

//remove trailing spaces if any
$bLoop:=True:C214
While ($bLoop)
	//the last character  
	If (Substring:C12($param; Length:C16($param))=" ")
		$param:=Delete string:C232($param; Length:C16($param); Length:C16($param))
	Else 
		$bLoop:=False:C215
	End if 
End while 

$0:=$param