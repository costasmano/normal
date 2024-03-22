//%attributes = {"invisible":true}
//fLastPos
//Find the last position of a string $1 in a string $2

C_TEXT:C284($1; $2)
C_LONGINT:C283($lsource; $lsearch; $i; $0; $pos)
C_TEXT:C284($rSource; $rSearch)

$lsource:=Length:C16($2)
$lsearch:=Length:C16($1)
//reverse both strings
$rSource:=""
$rSearch:=""
For ($i; 1; $lsource)
	$rSource:=$rSource+$2[[($lsource+1-$i)]]
End for 
For ($i; 1; $lsearch)
	$rSearch:=$rSearch+$1[[($lsearch+1-$i)]]
End for 
// look for the reverse string in the reverse source
$pos:=Position:C15($rSearch; $rSource)

If ($pos=0)
	$0:=0
Else 
	//adjust position  
	$0:=($lsource+1)-$pos-($lsearch-1)
End if 