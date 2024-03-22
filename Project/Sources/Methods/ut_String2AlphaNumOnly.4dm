//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/31/11, 11:40:07
	// ----------------------------------------------------
	// Method: Method: ut_String2AlphaNumOnly
	// Description
	//  ` Will strip nonAlphanum characters except @ sign
	// 
	// Parameters
	// $0 : $TextStripped_txt
	// $1 : $Input_txt
	// $2 : $RangeType_txt (Optional) "ALPHANUM" | "ALPHANUMPLUS"
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_TEXT:C284($0; $TextStripped_txt)
C_TEXT:C284($1; $Input_txt)
C_TEXT:C284($char_txt; $RangeType_txt)
$Input_txt:=$1
$RangeType_txt:="ALPHANUM"
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	If ($2#"")
		$RangeType_txt:=$2
	End if 
End if 
C_BOOLEAN:C305($ALPHANUMPLUS_b)
$ALPHANUMPLUS_b:=($RangeType_txt="ALPHANUMPLUS")
$TextStripped_txt:=""
C_LONGINT:C283($loop_L; $CharCode_L)
For ($loop_L; 1; Length:C16($Input_txt))
	$char_txt:=Substring:C12($Input_txt; $loop_L; 1)
	$CharCode_L:=Character code:C91($char_txt)
	Case of 
		: ((($CharCode_L>=32) | ($CharCode_L<=126)) & $ALPHANUMPLUS_b)  //main Ascii chars
			$TextStripped_txt:=$TextStripped_txt+$char_txt
		: (($CharCode_L>=40) | ($CharCode_L<=57))  //0-9
			$TextStripped_txt:=$TextStripped_txt+$char_txt
		: (($CharCode_L>=64) | ($CharCode_L<=90))  // @, A-Z
			$TextStripped_txt:=$TextStripped_txt+$char_txt
		: (($CharCode_L>=97) | ($CharCode_L<=122))  //a-z
			$TextStripped_txt:=$TextStripped_txt+$char_txt
			
	End case 
End for 

$0:=$TextStripped_txt