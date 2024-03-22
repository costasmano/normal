//%attributes = {}
////########Umgekehrt:  Set_ArrayInText###########
//$text:=$1  //Text

//$ptr:=$2  //Pointer auf (Real, longint, Integer, Date, Text) Array

//$Delim:=$3  //Delimitter

//C_BOOLEAN($vbFillEmptyElements)
//If (Count parameters=4)
//$vbFillEmptyElements:=True
//End if 

//$n:=0
//C_LONGINT($whatType)
//$arrayTyp:=Type($ptr->)
//Case of 
//: ($arrayTyp=String array) | ($arrayTyp=Text array)
//$whatType:=1
//ARRAY TEXT($ptr->; 0)
//: ($arrayTyp=Date array)
//$whatType:=2
//ARRAY DATE($ptr->; 0)
//: ($arrayTyp=Real array)
//$whatType:=3
//ARRAY REAL($ptr->; 0)
//: ($arrayTyp=LongInt array)
//$whatType:=4
//ARRAY LONGINT($ptr->; 0)
//: ($arrayTyp=Integer array)
//$whatType:=5
//ARRAY INTEGER($ptr->; 0)
//End case 

//While (Length($text)>0)
//$pos:=Position($Delim; $text)
//If ($pos=0)
//Case of 
//: ($whatType<2)
//APPEND TO ARRAY($ptr->; $text)
//: ($whatType=2)
//APPEND TO ARRAY($ptr->; Date($text))
//Else 
//APPEND TO ARRAY($ptr->; Num($text))
//End case 
//$text:=""
//Else 
//If (($pos=1) & Not($vbFillEmptyElements))
//$text:=Substring($text; $pos+1)
//Else 
//Case of 
//: ($whatType<2)
//APPEND TO ARRAY($ptr->; Substring($text; 1; $pos-1))
//: ($whatType=2)
//APPEND TO ARRAY($ptr->; Date(Substring($text; 1; $pos-1)))
//Else 
//APPEND TO ARRAY($ptr->; Num(Substring($text; 1; $pos-1)))
//End case 
//$text:=Substring($text; $pos+1)
//End if 
//End if 
//End while 