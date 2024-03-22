//%attributes = {"invisible":true}
//GP GetPath
//1997, Thomas D. Nee
//Returns the path of the last document accessed, whose name is
//stored in the system string variable Document.
//
// Modified 10-2000 :  CM
// Adjust behavior for Mac or Windows operating system

C_TEXT:C284($0; $1; $Doc)
C_LONGINT:C283($len; $i; $vi)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($vsDirSymbol)  // Command Replaced was o_C_STRING length was 1

If (Count parameters:C259=0)
	$Doc:=Document
Else 
	$Doc:=$1
End if 

$len:=Length:C16($Doc)
$i:=0
// 2-10-2000 : CM
// Modifications to account for Operating system
$vsDirSymbol:=<>PL_DirectorySep_s

//Find the last occurence of ":", which separates the path from the file name.
For ($vi; $len; 1; -1)
	If ($Doc[[$vi]]=$vsDirSymbol)
		$i:=$vi
		$vi:=0
	End if 
End for 
//The returned path includes the last colon.
If ($i>0)
	$0:=Substring:C12($Doc; 1; $i)
Else 
	$0:=$Doc
End if 