//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: sParameter(text;integer) -> string
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - text - text containing parameters
	//$2 - integer - parameter you want returned
	
	//Returns - string - parameter parsed from text
	
	//Purpose: parses through the passed text for a specific parameter in the text
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_TEXT:C284($1; $0; $tStr)
C_LONGINT:C283($i; $LLength; $LCount; $LBegin; $LEnd; $LNumChars)

$LLength:=Length:C16($1)
$LBegin:=1
$LEnd:=$LLength+1  //In case the parameter we are looking for is the last one
$tStr:=$1
$LCount:=0

For ($i; 1; $LLength)
	If ($tStr[[$i]]=";")  //Look for a semicolon
		$LCount:=$LCount+1  //Increment the count found
		If ($LCount=$2)  //Compare the count found to parameter we are looking for
			$LEnd:=$i
			$i:=$LLength+1  //exit loop
		Else 
			$LBegin:=$i+1  //Set the beginning character to the first character of th next parameter
		End if 
	End if 
End for 

$LNumChars:=$LEnd-$LBegin
$0:=Substring:C12($1; $LBegin; $LNumChars)  //Return the parameter
//End of procedure 