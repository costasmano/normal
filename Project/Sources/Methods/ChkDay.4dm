//%attributes = {"invisible":true}
//GP ChkDay
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure looks for a day number in a text field.  If there is a
//range of numbers (e.g., "5-7"), it takes the first day.

C_TEXT:C284($Day; $DD)

$Day:=$1
$DD:="  "
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
$i:=1
//Look for a maximum of two consecutive digits.
While (($i<=2) & (Length:C16($Day)>=$i))
	If (($Day[[$i]]>="0") & ($Day[[$i]]<="9"))
		$DD[[$i]]:=$Day[[$i]]
		$i:=$i+1
	Else 
		//This character is not a number.
		If ($i=1)
			//No numbers yet; keep looking.
			$Day:=Delete string:C232($Day; 1; 1)
		Else 
			//There has been a number already ($i=2); call it quits.
			$i:=$i+1
		End if 
	End if 
End while 

$0:=$DD