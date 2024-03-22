//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/25/08, 10:02:35
	// ----------------------------------------------------
	// Method: FN_IFF
	// Description
	// IF function. Returns a text depending on the 1st param.
	// Ex.
	// $Result_txt:=FN_IFF (($a>$b);"A is greater than B";"A is not !!!")
	// 
	// Parameters
	// $0 : $Result_txt
	// $1 : $cond_b (Boolean)
	// $2 : $TrueRes_txt
	// $3 : $FalseRes_txt
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
C_BOOLEAN:C305($1)
C_TEXT:C284($0; $2; $3)
If ($1)
	$0:=$2
Else 
	$0:=$3
End if 