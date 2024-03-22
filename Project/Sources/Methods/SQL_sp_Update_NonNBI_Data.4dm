//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/22/06, 12:44:34
	// ----------------------------------------------------
	// Method: SQL_sp_Update_NonNBI_Data
	// Description
	// This method will set up sql state for stored proce named as method name
	//$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings ()+$SingleQuote_s+", "`STRINGS
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMx1
End if 
C_TEXT:C284($0; $SQLStatement_txt)
C_TEXT:C284($SingleQuote_s; $QuoteMark_s)  // Command Replaced was o_C_STRING length was 1
$SingleQuote_s:=Char:C90(39)
$QuoteMark_s:=Char:C90(34)

$SQLStatement_txt:=""

C_TEXT:C284($Spaces_txt)

$SQLStatement_txt:=$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item8:206)+$SingleQuote_s+" "

$0:=$SQLStatement_txt

//End SQL_sp_Update_NonNBI_Data