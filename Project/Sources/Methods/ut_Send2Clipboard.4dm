//%attributes = {"invisible":true}
// Method: ut_Send2Clipboard
// Description
// Send a text to the clipboard
// Parameters
// $1 : Text to add - text
// $2 : Add to clipboard option - text (Optional)
//  `"Append" - to append to clipboard : default
//  `"Clear" - clear clipoboard and then add
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/09/06, 16:59:56
	// ----------------------------------------------------
	
	Mods_2006_CM06A
End if 
C_TEXT:C284($1; $2; $Option_txt; $Text_txt)
If (Count parameters:C259=2)
	$Option_txt:=$2
Else 
	$Option_txt:="APPEND"
End if 

Case of 
	: ($Option_txt="APPEND")
		$Text_txt:=Get text from pasteboard:C524
		SET TEXT TO PASTEBOARD:C523($Text_txt+$1)
	: ($Option_txt="CLEAR")
		SET TEXT TO PASTEBOARD:C523($1)
	Else 
		$Text_txt:=Get text from pasteboard:C524
		SET TEXT TO PASTEBOARD:C523($Text_txt+$1)
End case 
