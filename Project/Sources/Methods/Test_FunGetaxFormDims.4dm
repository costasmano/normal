//%attributes = {"invisible":true}
//Test_FunGetaxFormDims
C_POINTER:C301($1)
C_TEXT:C284($2)  //<--- Added// Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($vw; $vh)
FORM GET PROPERTIES:C674($1->; $2; $vw; $vh)
If ($vw>vmaxw)
	vmaxW:=$vw
	vsMAxW:=$2
End if 
If ($vh>vmaxh)
	vmaxh:=$vh
	vsMAxH:=$2
End if 