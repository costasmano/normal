//%attributes = {"invisible":true}
If (False:C215)
	// GetFileExtension
	//Returns the extension of the last document accessed, whose name is
	//stored in the system string variable Document. or of filespec
	//passed in 1st argument
	//
End if 

C_TEXT:C284($0; $1; $Doc)
C_LONGINT:C283($len; $i; $vi)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($vsExtSymbol)  // Command Replaced was o_C_STRING length was 1

If (Count parameters:C259=0)
	$Doc:=Document
Else 
	$Doc:=$1
End if 
$Doc:=Replace string:C233($Doc; GetPath($Doc); "")

$len:=Length:C16($Doc)

$i:=0
$vsExtSymbol:="."
//Find the last occurence of ".", which separates the ext from the file name.
For ($vi; $len; 1; -1)
	If ($Doc[[$vi]]=$vsExtSymbol)
		$i:=$vi
		$vi:=0
	End if 
End for 
//The returned extension includes the last ".".
If ($i>0)
	$0:=Substring:C12($Doc; $i)
Else 
	$0:=""
End if 