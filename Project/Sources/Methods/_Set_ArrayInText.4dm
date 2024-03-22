//%attributes = {}
////########Umgekehrt: Get_ArrayFromText###########

//C_TEXT($0; $text)
//C_POINTER($1)
//C_LONGINT($i; $sz)
//C_TEXT($2; $Delim)
//$ptr:=$1  //Pointer auf Array

//$Delim:=$2  //Delimitter

//C_BOOLEAN($isText)
//$arrayTyp:=Type($ptr->)
//If ($arrayTyp=String array) | ($arrayTyp=Text array)
//$isText:=True
//Else 
//$isText:=False
//End if 

//$sz:=Size of array($ptr->)
//For ($i; 1; $sz)
//If ($isText)
//$text:=$text+($ptr->{$i})
//Else 
//$text:=$text+String($ptr->{$i})
//End if 
//If ($i#$sz)
//$text:=$text+$Delim
//End if 
//End for 
//$0:=$text
