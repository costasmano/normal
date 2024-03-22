//%attributes = {"invisible":true}
//Method: EncryptDecryptString
//Description
// Encrypt or decrypt string 
// Parameters
// Parameters:
// $0 (Text) - Output string of encrypt/encrypt
// $1 (Text) - String for encrypt/decrypt
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/17/21, 17:39:28
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	
	C_TEXT:C284(EncryptDecryptString; $0; $1)
End if 
//

C_TEXT:C284($0; $outString)
C_TEXT:C284($1; $inString; $keyString)
C_TEXT:C284($char1; $char2)
C_LONGINT:C283($i)

$inString:=$1
$keyString:=Char:C90(Character code:C91("M"))+\
Char:C90(Character code:C91("a"))+\
Char:C90(Character code:C91("D"))+\
Char:C90(Character code:C91("0"))+\
Char:C90(Character code:C91("t"))+\
Char:C90(Character code:C91("B"))+\
Char:C90(Character code:C91("m"))+\
Char:C90(Character code:C91("5"))+\
Char:C90(Character code:C91("*"))+\
Char:C90(Character code:C91("^"))

//make key at least as long as $inString
C_LONGINT:C283($InLen; $keyLen; $factor)
$InLen:=Length:C16($inString)
$keyLen:=Length:C16($keyString)
$factor:=($InLen/$keyLen)+1
$keyString:=$factor*$keyString

//Encrypting/decrypting the data using XOR
For ($i; 1; Length:C16($inString))
	$char1:=Substring:C12($inString; $i; 1)
	$char2:=Substring:C12($keyString; $i; 1)
	
	//XOR bitwise character by character
	$outString:=$outString+Char:C90(Character code:C91($char1) ^| Character code:C91($char2))
End for 

$0:=$outString
//End EncryptDecryptString