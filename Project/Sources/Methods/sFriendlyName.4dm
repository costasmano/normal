//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: sFriendlyName (Source) -> String
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	// Legend:
	// $1 = String to install spaces
	
	//Returns -> string - User friendly name
	
	// Purpose: Converts upper/lower case w/o spaces to upper/lower
	// case w/ spaces
	// Converts underscores to a space
	
	// Example: "FriendlyName" becomes "Friendly Name"
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modification by Tom Nee, 1/28/98.
	//Don't insert spaces between consecutive Uppercase letters.
	//E.g., Don't change "FHWA" to "F H W A"
End if 

C_TEXT:C284($1; $0; $sSource)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($sChar; $sNext)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($ItemNum; $Len; $LChar; $LAscii; $LNext)
C_BOOLEAN:C305($IsItem; $LastUpper; $LastNumber; $LastSpace)

$sSource:=$1
If (Substring:C12($sSource; 1; 4)="Item")
	$IsItem:=True:C214
	$ItemNum:=Num:C11(Substring:C12($sSource; 4))  //The "e" in "Item" would be interpreted as part of the number.
End if 
$Len:=Length:C16($sSource)
$0:=""
$sChar:=Substring:C12($sSource; 1; 1)
$LAscii:=Character code:C91($sChar)

//This stops a space from being inserted if the name
//begins with an uppercase letter or a number.
$LastUpper:=True:C214
$LastNumber:=True:C214
$LastSpace:=True:C214

For ($LChar; 1; $Len)
	If ($LChar<$Len)
		$sNext:=$sSource[[$LChar+1]]
	Else 
		$sNext:=""
	End if 
	$LNext:=Character code:C91($sNext)
	
	Case of 
		: (($LAscii=95) | ($LAscii=32))  //	Underbar or space.
			//Don't allow two consecutive spaces.
			If (Not:C34($LastSpace) | ($LChar=1))
				$0:=$0+<>sSP
			End if 
			$LastSpace:=True:C214
			$LastUpper:=False:C215
			$LastNumber:=False:C215
			
		: (($LAscii>=65) & ($LAscii<=90))  //Uppercase.
			If (Not:C34($LastSpace))
				If ((Not:C34($LastUpper) & Not:C34($LastNumber)) | (($LNext>=97) & ($LNext<=122)))
					//Add a space if the previous character was not a number nor an uppercase letter,
					//or if the next character is lowercase.
					$0:=$0+<>sSP
				End if 
			End if 
			$0:=$0+$sChar
			$LastUpper:=True:C214
			$LastNumber:=False:C215
			$LastSpace:=False:C215
			
		: (($LAscii>=48) & ($LAscii<=57))  //Number.
			If (Not:C34($LastSpace))
				If (Not:C34($LastUpper) & Not:C34($LastNumber))
					$0:=$0+<>sSP
				End if 
			End if 
			If ($IsItem)
				//Put in leading spaces so the NBIS Items sort properly.        
				If ($ItemNum<100)
					$0:=$0+<>sSP
					If ($ItemNum<10)
						$0:=$0+<>sSP
					End if 
				End if 
				//Do this once only.        
				$IsItem:=False:C215
			End if 
			$0:=$0+$sChar
			$LastNumber:=True:C214
			$LastUpper:=False:C215
			$LastSpace:=False:C215
			
		Else 
			$0:=$0+$sChar
			$LastUpper:=False:C215
			$LastNumber:=False:C215
			$LastSpace:=False:C215
	End case 
	
	$sChar:=$sNext
	$LAscii:=$LNext
End for 
//End of procedure 