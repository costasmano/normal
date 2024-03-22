//%attributes = {}
// Method bIsNumeric
//Check if a string has all numeric characters
//excluding + or -
// return false if the string is blank zero length

C_TEXT:C284($mystring; $1)  // Command Replaced was o_C_STRING length was 255
C_BOOLEAN:C305($0; $test)
C_LONGINT:C283($numchars; $i)

$mystring:=$1

//assume true for starters

$test:=True:C214

$numchars:=Length:C16($mystring)

If ($numchars=0)
	$test:=False:C215
Else 
	For ($i; 1; $numchars)
		
		If ((Character code:C91($mystring[[$i]])<Character code:C91("0")) | (Character code:C91($mystring[[$i]])>Character code:C91("9")))
			If (($mystring[[$i]]#"+") & ($mystring[[$i]]#"-"))
				$test:=False:C215
			End if 
		End if 
		
	End for 
End if 

$0:=$test