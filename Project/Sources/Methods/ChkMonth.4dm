//%attributes = {"invisible":true}
//GP ChkMonth
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284($Month)

$Month:=$1
$Month:=Uppercase:C13($Month)

//If the month is entered as text, convert it to a number.
Case of 
	: (Position:C15("JA"; $Month)>0)
		$Month:="1"
	: (Position:C15("FE"; $Month)>0)
		$Month:="2"
	: (Position:C15("MAR"; $Month)>0)
		$Month:="3"
	: (Position:C15("AP"; $Month)>0)
		$Month:="4"
	: (Position:C15("MAY"; $Month)>0)
		$Month:="5"
	: (Position:C15("JUN"; $Month)>0)
		$Month:="6"
	: (Position:C15("JUL"; $Month)>0)
		$Month:="7"
	: (Position:C15("AU"; $Month)>0)
		$Month:="8"
	: (Position:C15("SE"; $Month)>0)
		$Month:="9"
	: (Position:C15("OC"; $Month)>0)
		$Month:="10"
	: (Position:C15("NO"; $Month)>0)
		$Month:="11"
	: (Position:C15("DE"; $Month)>0)
		$Month:="12"
End case 

$0:=$Month