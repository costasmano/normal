//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ParseTextToArray
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
SET BLOB SIZE:C606($Blob_blb; 0)
C_LONGINT:C283($Position_l; $SizeOfArray_l)
C_BOOLEAN:C305($Complete_b)
ARRAY TEXT:C222($ParsedText_atxt; 0)
$Complete_b:=False:C215
$SizeOfArray_l:=1
$TextToParse_txt:=f_TrimStr($TextToParse_txt; True:C214; True:C214)

Repeat 
	$Position_l:=Position:C15(" "; $TextToParse_txt)
	If ($Position_l>0)
		INSERT IN ARRAY:C227($ParsedText_atxt; $SizeOfArray_l; 1)
		$ParsedText_atxt{$SizeOfArray_l}:=Substring:C12($TextToParse_txt; 1; $Position_l-1)
		$TextToParse_txt:=Substring:C12($TextToParse_txt; $Position_l+1)
		$SizeOfArray_l:=$SizeOfArray_l+1
	Else 
		If (Length:C16($TextToParse_txt)>0)
			INSERT IN ARRAY:C227($ParsedText_atxt; $SizeOfArray_l; 1)
			$ParsedText_atxt{$SizeOfArray_l}:=$TextToParse_txt
		End if 
		$Complete_b:=True:C214
	End if 
Until ($Complete_b)


VARIABLE TO BLOB:C532($ParsedText_atxt; $Blob_blb)
$0:=$Blob_blb
//End ut_ParseTextToArray