//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/10/08, 10:09:30
	// ----------------------------------------------------
	// Method: ut_ParseTextToArrayDelim
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("SCOUR")
End if 
C_BLOB:C604($0; $Blob_blb)
C_TEXT:C284($1; $TextToParse_txt)
C_TEXT:C284($delim_txt)
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$delim_txt:=$2
Else 
	$delim_txt:=" "
End if 

$TextToParse_txt:=$1
SET BLOB SIZE:C606($Blob_blb; 0)
C_LONGINT:C283($Position_l; $SizeOfArray_l)
C_BOOLEAN:C305($Complete_b)
ARRAY TEXT:C222($ParsedText_atxt; 0)
$Complete_b:=False:C215
$SizeOfArray_l:=1
$TextToParse_txt:=f_TrimStr($TextToParse_txt; True:C214; True:C214)

Repeat 
	$Position_l:=Position:C15($delim_txt; $TextToParse_txt)
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
SET BLOB SIZE:C606($Blob_blb; 0)
//End ut_ParseTextToArray