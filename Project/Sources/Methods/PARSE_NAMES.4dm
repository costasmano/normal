//%attributes = {"invisible":true}
//GP PARSE_NAMES
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Parse a list of names from a single text variable and record the names
//in a text array.

C_TEXT:C284($list)
C_POINTER:C301($ptr_aNames)

C_LONGINT:C283($i; $n; $b)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($InName)
C_TEXT:C284($CH)  // Command Replaced was o_C_STRING length was 1

$list:=$1
$ptr_aNames:=$2

$i:=1
$n:=0
$InName:=False:C215
While ($i<=Length:C16($list))
	$CH:=Uppercase:C13($list[[$i]])
	If ((($CH>="A") & ($CH<="Z")) | ($CH="'"))
		//This character is part of a name.    
		If (Not:C34($InName))
			//This is the beginning of a new name
			$InName:=True:C214
			$b:=$i  //Mark the beginning position.
			$n:=$n+1
			INSERT IN ARRAY:C227($ptr_aNames->; $n)
		End if 
		If ($i=Length:C16($list))
			//This is the last character; finish up.      
			$ptr_aNames->{$n}:=Substring:C12($list; $b; $i-$b+1)
		End if 
	Else 
		//This character is not part of a name. 
		If ($InName)
			//This is the end of a name.
			$InName:=False:C215
			$ptr_aNames->{$n}:=Substring:C12($list; $b; $i-$b)
		End if 
	End if 
	
	$i:=$i+1
End while 