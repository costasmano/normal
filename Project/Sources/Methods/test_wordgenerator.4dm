//%attributes = {"invisible":true}
//Method: test_wordgenerator
//Description
// a test method to generate 'words' from a set of characters using each one once
// Parameters
// $1 : $Letters_txt
// $2 : $Array_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/03/20, 17:22:11
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03
	
	C_TEXT:C284(test_wordgenerator; $1)
	C_POINTER:C301(test_wordgenerator; $2)
End if 
//
C_TEXT:C284($1; $Letters_txt)
$Letters_txt:=$1
C_TEXT:C284($thisChar; $Rest_txt)
C_LONGINT:C283($Char; $len; $Words_L)
$len:=Length:C16($Letters_txt)

If ($len=1)
	APPEND TO ARRAY:C911($2->; $Letters_txt)
Else 
	
	For ($Char; 1; $len)
		$thisChar:=$Letters_txt[[$Char]]
		Case of 
				
			: ($Char=1)
				$Rest_txt:=Substring:C12($Letters_txt; 2)
			: ($Char=$len)
				$Rest_txt:=Substring:C12($Letters_txt; 1; ($len-1))
			Else 
				$Rest_txt:=Substring:C12($Letters_txt; 1; ($Char-1))+Substring:C12($Letters_txt; ($Char+1))
		End case 
		ARRAY TEXT:C222($Mywords_atxt; 0)
		test_wordgenerator($Rest_txt; ->$Mywords_atxt)
		
		$Words_L:=Size of array:C274($Mywords_atxt)
		C_LONGINT:C283($w)
		For ($w; 1; $Words_L)
			APPEND TO ARRAY:C911($2->; ($thisChar+($Mywords_atxt{$w})))
		End for 
		
	End for 
	
End if 

//End test_wordgenerator