//%attributes = {"invisible":true}
If (False:C215)
	//str_Txt2Lines
	//return number of lines needed to print text $1 based on
	//$2 chars per line,
	// $3 : pointer to string 255 array
	//
	// usage
	//  Array string(255;arrayoflines) -- process var, NOT local
	//  c_integer($charperline)
	//   c_text($MyText)
	//  str_Txt2Lines($MyText;$CharperLine;->arrayoflines)
End if 

C_LONGINT:C283($2; $char_line; $numlines)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($1; $mytext; $nextline)
C_POINTER:C301($3; $pStrArray)

C_LONGINT:C283($lineSt; $LineEnd; $numchars; $CRPos; $StrLen; $SPos)
C_BOOLEAN:C305($search_over)

$mytext:=$1
$char_line:=$2
$pStrArray:=$3

$numchars:=Length:C16($mytext)
$numlines:=0
$LineSt:=1
$LineEnd:=1

Repeat 
	//scan by chars from the current line start up to charsperline  
	$nextline:=Substring:C12($mytext; $LineSt; $char_line)
	$StrLen:=Length:C16($nextline)
	$CRPos:=Position:C15(<>sCR; $nextline)
	If ($CRPos=0)
		//no CR in the next group of chars
		If (($LineSt+$StrLen)>$numchars)
			//this the last piece of the text
			$LineEnd:=$StrLen
		Else 
			//there is more, so..
			Case of 
					
				: ($mytext[[($LineSt+$StrLen)]]=<>sCR)
					//include the CR after
					$LineEnd:=$StrLen+1
					
				: ($mytext[[($LineSt+$StrLen)]]=" ")
					//go until we find a non-space
					$LineEnd:=$StrLen
					$search_over:=False:C215
					Repeat 
						$LineEnd:=$LineEnd+1
						If (($LineSt+$LineEnd)>$numchars)
							$search_over:=True:C214
						Else 
							If ($mytext[[($LineSt+$LineEnd)]]#" ")
								$search_over:=True:C214
							End if 
						End if 
					Until ($search_over)
					If (($LineSt+$LineEnd)<=$numchars)
						//if we reached a CR include the 1st CR too  
						If ($mytext[[($LineSt+$StrLen)]]=<>sCR)
							$LineEnd:=$LineEnd+1
						End if 
					End if 
				: ($mytext[[($LineSt+$StrLen)]]#" ")
					//not a space ahead,
					//if we are in a space then the next char is a start of word so OK
					If ($mytext[[($LineSt+$StrLen-1)]]=" ")
						$LineEnd:=$StrLen
					Else 
						// move back for a space
						$SPos:=fLastPos(" "; $nextline)
						If ($SPos=0)
							//there is no space before, split the text here
							$LineEnd:=$StrLen
						Else 
							//next line starts after the last space
							$LineEnd:=$SPos
						End if 
					End if 
					
			End case 
			
		End if 
	Else 
		//there is a CR in the next char_line
		// the start of the line will be at $CRPos +1
		$LineEnd:=$CRPos
	End if 
	
	$numlines:=$numlines+1
	INSERT IN ARRAY:C227($pStrArray->; $numlines)
	$pStrArray->{$numlines}:=Substring:C12($mytext; $LineSt; $LineEnd)
	$LineSt:=$LineSt+$LineEnd
	
Until ($LineSt>$numchars)