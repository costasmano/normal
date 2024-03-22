//%attributes = {}
C_TEXT:C284($0; $1; $vStr1)
C_LONGINT:C283($vStrLen; $i)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($vbNotWord)
C_TEXT:C284($vsChar)  // Command Replaced was o_C_STRING length was 1
$vStr1:=$1
$vStrLen:=Length:C16($vStr1)
$vStr1:=Lowercase:C14($vStr1)
$vbNotWord:=True:C214
For ($i; 1; $vStrLen)
	$vsChar:=$vStr1[[$i]]
	If (Position:C15($vsChar; " ,.!:;/?()-_")>0)
		$vbNotWord:=True:C214
	Else 
		If ($vbNotWord)
			$vbNotWord:=False:C215
			$vStr1[[$i]]:=Uppercase:C13($vsChar)
		End if 
	End if 
	
End for 
$0:=$vStr1