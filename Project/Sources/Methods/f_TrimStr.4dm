//%attributes = {}
//f_TrimStr
//Trim the trailing and/or leading 'blank' characters from a text string.
//"blank" characters are spaces tabs carriage returns and linefeeds
//Usage
//TrimLead:=True
//TrimTrail:=True
//TrimmedStr:=f_TrimStr(OriginalStr;TrimLead;TrimTrail)
If (False:C215)
	
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 11:00:34)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/14/08 12:34:35)
	Mods_2008_CM_5404
	//Added LineFeed to the trim characters
	// Modified by: manousakisc (1/23/2020)
	Mods_2020_01_bug
	// Fixed cases where one of the trim options (Lead or trail) are false. 
	// the start pos or trim length were not set correctly.
End if 

C_TEXT:C284($1; $0)
C_BOOLEAN:C305($2; $3; $vbTrimSt; $vbTrimTrail)
C_TEXT:C284($vtOriginal; $vtFinal)
C_LONGINT:C283($vlTextLen; $i; $vlTextLenFinal; $vlTextStartFinal)
C_TEXT:C284($vsBlanks)  // old C_STRING length 10

$vtOriginal:=$1
$vbTrimSt:=$2
$vbTrimTrail:=$3
$vlTextLen:=Length:C16($vtOriginal)
$vsBlanks:=Char:C90(Space:K15:42)+Char:C90(Tab:K15:37)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
If ($vlTextLen>0)
	If ($vlTextLen=1)
		If (Position:C15($vtOriginal; $vsBlanks)=0)
			$vtFinal:=$vtOriginal
		Else 
			$vtFinal:=""
		End if 
	Else 
		//Assume all are "Blanks"
		$vlTextStartFinal:=$vlTextLen
		$vlTextLenFinal:=1
		
		If ($vbTrimSt)
			For ($i; 1; $vlTextLen)
				If (Position:C15($vtOriginal[[$i]]; $vsBlanks)=0)
					$vlTextStartFinal:=$i
					$i:=$vlTextLen+1  //exit loop
				End if 
			End for 
		Else 
			$vlTextStartFinal:=1
		End if 
		
		If ($vbTrimTrail)
			//start from end to find 1st non-blank character
			For ($i; $vlTextLen; 1; -1)
				If (Position:C15($vtOriginal[[$i]]; $vsBlanks)=0)
					$vlTextLenFinal:=$i
					$i:=0  //exit loop
				End if 
			End for 
		Else 
			$vlTextLenFinal:=$vlTextLen
		End if 
		
		If (($vlTextLenFinal-$vlTextStartFinal)<=0)
			If (Position:C15(Substring:C12($vtOriginal; $vlTextStartFinal; 1); $vsBlanks)=0)
				$vtFinal:=Substring:C12($vtOriginal; $vlTextStartFinal; 1)
			Else 
				$vtFinal:=""  //there are no non-blanks
			End if 
			
		Else 
			$vtFinal:=Substring:C12($vtOriginal; $vlTextStartFinal; ($vlTextLenFinal-$vlTextStartFinal+1))
		End if 
		
	End if 
	
Else 
	//return a blank string anyway  
	$vtFinal:=""
End if 

$0:=$vtFinal