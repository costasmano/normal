//%attributes = {"invisible":true}
//Method: f_TrimStyledText
//Description
// Trim a styled text similar to f_trimStr
// Parameters
// $0 : $styledtextTrimmed
// $1 : $paramObject
//   .texttotrim : styledtext
//   .trimleading : true/false default true
//   .trimtrailing : true/false default true
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-05-03T00:00:00, 13:06:05
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
	C_TEXT:C284(f_TrimStyledText; $0)
	C_OBJECT:C1216(f_TrimStyledText; $1)
	
End if 
//

C_TEXT:C284($0; $trimed_txt; $styled_txt)
C_OBJECT:C1216($params_o; $1)
$params_o:=$1
$styled_txt:=$params_o.texttotrim
C_BOOLEAN:C305($trimLead_b; $trimTrail_b)
$trimLead_b:=True:C214
$trimTrail_b:=True:C214
If (OB Is defined:C1231($params_o; "trimleading"))
	$trimLead_b:=OB Get:C1224($params_o; "trimleading"; Is boolean:K8:9)
End if 
If (OB Is defined:C1231($params_o; "trimtrailing"))
	$trimTrail_b:=OB Get:C1224($params_o; "trimtrailing"; Is boolean:K8:9)
End if 

C_TEXT:C284($plain_txt; $vsBlanks)
C_LONGINT:C283($numchars)
$plain_txt:=ST Get plain text:C1092($styled_txt; ST 4D Expressions as values:K78:9)
$numchars:=Length:C16($plain_txt)
$vsBlanks:=Char:C90(Space:K15:42)+Char:C90(Tab:K15:37)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)+Char:C90(8232)

If ($numchars=0)
	$0:=""  // return a blank string
	
Else 
	
	C_LONGINT:C283($startTrim_L; $endTrim_L)
	$startTrim_L:=1
	$endTrim_L:=$numchars
	C_BOOLEAN:C305($done_b)
	
	If ($trimLead_b)
		$done_b:=False:C215
		Repeat 
			If (Position:C15(Substring:C12($plain_txt; $startTrim_L; 1); $vsBlanks)>0)
				// a blank char- keep going
				$startTrim_L:=$startTrim_L+1
			Else 
				$done_b:=True:C214
			End if 
		Until ($done_b | ($startTrim_L>$numchars))  // done trimming or reached end of string
	End if 
	
	
	If ($startTrim_L>$numchars)
		//Reached end of text - nothing left
		$0:=""  //return a blank string
		
	Else 
		
		If ($trimTrail_b)
			$done_b:=False:C215
			$endTrim_L:=$numchars
			Repeat 
				If (Position:C15(Substring:C12($plain_txt; $endTrim_L; 1); $vsBlanks)>0)
					// a blank char- keep going
					$endTrim_L:=$endTrim_L-1
				Else 
					$done_b:=True:C214
				End if 
				
			Until ($done_b | ($endTrim_L<$startTrim_L))
			
		End if 
		
		If ($endTrim_L>=$startTrim_L)
			//found at least one character
			$0:=ST Get text:C1116($styled_txt; $startTrim_L; ($endTrim_L+1))  //need to add 1 to endtrim
		Else 
			// nothing left 
			$0:=""
		End if 
		
	End if 
	
End if 

//End f_TrimStyledText