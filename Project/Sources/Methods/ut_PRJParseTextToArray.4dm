//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJParseTextToArray
// User name (OS): cjmiller
// Date and time: 06/01/06, 12:04:55
// ----------------------------------------------------
// Description
// This method will pares text into an areray and return blob with array in it
//
// Parameters
//$1 text ro parse
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_BLOB:C604($0; $Blob_blb)
C_TEXT:C284($1; $TextToParse_txt)
$TextToParse_txt:=$1
$TextToParse_txt:=Replace string:C233($TextToParse_txt; "Approved"; "Approved ")
$TextToParse_txt:=Replace string:C233($TextToParse_txt; "Received"; "Received ")
$TextToParse_txt:=Replace string:C233($TextToParse_txt; "OK"; "OK ")
$TextToParse_txt:=Replace string:C233($TextToParse_txt; "0k"; "OK ")
$TextToParse_txt:=Replace string:C233($TextToParse_txt; "N.H."; "N.H. ")
$TextToParse_txt:=Replace string:C233($TextToParse_txt; "R.M."; "R.M. ")
$TextToParse_txt:=Replace string:C233($TextToParse_txt; "  "; " ")

SET BLOB SIZE:C606($Blob_blb; 0)
C_LONGINT:C283($Position_l; $SizeOfArray_l)
C_BOOLEAN:C305($Complete_b)
ARRAY TEXT:C222($ParsedText_atxt; 0)
$Complete_b:=False:C215
$SizeOfArray_l:=1
$TextToParse_txt:=f_TrimStr($TextToParse_txt; True:C214; True:C214)
ARRAY TEXT:C222($MonthNames_as; 12)  //Command Replaced was o_ARRAY string length was 4
$MonthNames_as{1}:="Jan/"
$MonthNames_as{2}:="Feb/"
$MonthNames_as{3}:="Mar/"
$MonthNames_as{4}:="Apr/"
$MonthNames_as{5}:="May/"
$MonthNames_as{6}:="Jun/"
$MonthNames_as{7}:="Jul/"
$MonthNames_as{8}:="Aug/"
$MonthNames_as{9}:="Sep/"
$MonthNames_as{10}:="Oct/"
$MonthNames_as{11}:="Nov/"
$MonthNames_as{12}:="Dec/"

Repeat 
	$Position_l:=Position:C15(" "; $TextToParse_txt)
	If ($Position_l>0)
		INSERT IN ARRAY:C227($ParsedText_atxt; $SizeOfArray_l; 1)
		$ParsedText_atxt{$SizeOfArray_l}:=Substring:C12($TextToParse_txt; 1; $Position_l-1)
		$TextToParse_txt:=Substring:C12($TextToParse_txt; $Position_l+1)
		$ArrayPosition_l:=Find in array:C230($MonthNames_as; Substring:C12($ParsedText_atxt{$SizeOfArray_l}; 1; 4))
		If ($ArrayPosition_l>0)
			$ParsedText_atxt{$SizeOfArray_l}:=String:C10($ArrayPosition_l; "00")+Substring:C12($ParsedText_atxt{$SizeOfArray_l}; 4)
		End if 
		$SizeOfArray_l:=$SizeOfArray_l+1
	Else 
		If (Length:C16($TextToParse_txt)>0)
			INSERT IN ARRAY:C227($ParsedText_atxt; $SizeOfArray_l; 1)
			C_LONGINT:C283($ArrayPosition_l)
			$ArrayPosition_l:=Find in array:C230($MonthNames_as; Substring:C12($TextToParse_txt; 1; 4))
			If ($ArrayPosition_l>0)
				$TextToParse_txt:=String:C10($ArrayPosition_l; "00")+Substring:C12($TextToParse_txt; 4)
			End if 
			$ParsedText_atxt{$SizeOfArray_l}:=$TextToParse_txt
		End if 
		$Complete_b:=True:C214
	End if 
Until ($Complete_b)


VARIABLE TO BLOB:C532($ParsedText_atxt; $Blob_blb)
$0:=$Blob_blb
//End ut_PRJParseTextToArray