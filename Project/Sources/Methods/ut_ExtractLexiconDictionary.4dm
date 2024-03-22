//%attributes = {"invisible":true}
// ----------------------------------------------------
//ut_ExtractLexiconDictionary 
// User name (OS): charlesmiller
// Date and time: 12/30/10, 14:28:16
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_12  //r002 CJ Miller`12/30/10, 14:28:22      `write code to extract getitwrite dictionary words
	Mods_2011_06  // CJ Miller`06/20/11, 10:27:52      ` Type all local variables for v11
End if 
C_TIME:C306($start; $end; $Doc)
$start:=Current time:C178
//◊My4DXFolder_txt
C_TEXT:C284($Import; $Path)
$Path:=<>My4DXFolder_txt+"GetItRight.lex"

$Doc:=Open document:C264($Path)

ARRAY TEXT:C222($Doc_atxt; 0)

C_LONGINT:C283($Position_l)
C_TEXT:C284($word)
C_BOOLEAN:C305($wordStarted_b)
Repeat 
	RECEIVE PACKET:C104($Doc; $Import; 25000)
	If (OK=1)
		
		$wordStarted_b:=False:C215
		
		$word:=""
		C_LONGINT:C283($Loop_l)
		For ($Loop_l; 1; Length:C16($Import))
			
			Case of 
				: (Character code:C91($Import[[$Loop_l]])>=65) & (Character code:C91($Import[[$Loop_l]])<=90)
					$word:=$word+$Import[[$Loop_l]]
					$wordStarted_b:=True:C214
				: (Character code:C91($Import[[$Loop_l]])>=97) & (Character code:C91($Import[[$Loop_l]])<=122)
					$word:=$word+$Import[[$Loop_l]]
					$wordStarted_b:=True:C214
				: (Character code:C91($Import[[$Loop_l]])=45)
					$word:=$word+$Import[[$Loop_l]]
					$wordStarted_b:=True:C214
				Else 
					If ($wordStarted_b)
						If (Length:C16($word)>2)
							$Position_l:=Find in array:C230($Doc_atxt; $word)
							Case of 
								: ($Position_l<0)
									APPEND TO ARRAY:C911($Doc_atxt; $word)
								: ($word=$Doc_atxt{$Position_l})
								Else 
									APPEND TO ARRAY:C911($Doc_atxt; $word)
							End case 
						End if 
						$word:=""
						$wordStarted_b:=False:C215
					End if 
					
			End case 
			
			
			
		End for 
	End if 
Until (OK=0)


CLOSE DOCUMENT:C267($Doc)
$end:=Current time:C178


$Start:=Current time:C178
C_TEXT:C284($MyDictionaryPath_txt)

If (Application type:C494=4D Remote mode:K5:5)
	$MyDictionaryPath_txt:=Get 4D folder:C485(4D Client database folder:K5:13)
End if 
$Position_l:=Position:C15("MHD "; $MyDictionaryPath_txt)
$MyDictionaryPath_txt:=Substring:C12($MyDictionaryPath_txt; 1; $Position_l)

$MyDictionaryPath_txt:=Get 4D folder:C485(4D Client database folder:K5:13)
$Position_l:=Position:C15("MHD "; $MyDictionaryPath_txt)
$MyDictionaryPath_txt:=Substring:C12($MyDictionaryPath_txt; 1; $Position_l-1)
C_TEXT:C284($CR)
$CR:=Char:C90(13)
If (Test path name:C476($MyDictionaryPath_txt+"perso69632.dic")=Is a document:K24:1)
	$Doc:=Open document:C264($MyDictionaryPath_txt+"perso69632.dic"; "dic")
	
	Repeat 
		RECEIVE PACKET:C104($Doc; $word; $CR)
		$word:=Replace string:C233($word; Char:C90(13); "")
		$word:=Replace string:C233($word; Char:C90(10); "")
		
		If (OK=1)
			$Position_l:=Find in array:C230($Doc_atxt; $word)
			If ($Position_l>0)
				If ($word=$Doc_atxt{$Position_l})
					DELETE FROM ARRAY:C228($Doc_atxt; $Position_l; 1)
				End if 
			End if 
			
		End if 
	Until (OK=0)
	
Else 
	$Doc:=Create document:C266($MyDictionaryPath_txt+"perso69632.dic"; "dic")
	
	
End if 
CLOSE DOCUMENT:C267($Doc)
$end:=Current time:C178

$Start:=Current time:C178
If (Size of array:C274($Doc_atxt)>0)
	
	$Doc:=Append document:C265($MyDictionaryPath_txt+"perso69632.dic"; "dic")
	$Import:=""
	For ($Loop_l; 1; Size of array:C274($Doc_atxt))
		
		$Import:=$Import+$Doc_atxt{$Loop_l}+Char:C90(13)
		
		If (Length:C16($Import)>25000)
			SEND PACKET:C103($doc; $Import)
			$Import:=""
		End if 
		
	End for 
	If (Length:C16($Import)>0)
		SEND PACKET:C103($doc; $Import)
		$Import:=""
	End if 
	
	CLOSE DOCUMENT:C267($Doc)
End if 
$end:=Current time:C178


//End aaaatest