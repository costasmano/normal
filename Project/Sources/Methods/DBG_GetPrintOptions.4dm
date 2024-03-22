//%attributes = {"invisible":true}
//Method: DBG_GetPrintOptions
//Description
// Get Print options in a text var
// Parameters
// $0 : $opts_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/22/17, 12:53:34
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
	
	C_TEXT:C284(DBG_GetPrintOptions; $0)
	
End if 
//

C_TEXT:C284($0)
C_TEXT:C284($opts_txt)
C_LONGINT:C283($val1_L; $Val2_L)
C_TEXT:C284($val2_txt)

GET PRINT OPTION:C734(Color option:K47:6; $val1_L)
$opts_txt:=$opts_txt+"Color option "+Char:C90(9)+String:C10($val1_L)+Char:C90(13)
GET PRINT OPTION:C734(Destination option:K47:7; $val1_L; $val2_txt)
$opts_txt:=$opts_txt+"Destination option "+Char:C90(9)+String:C10($val1_L)+Char:C90(9)+$val2_txt+Char:C90(13)
GET PRINT OPTION:C734(Double sided option:K47:9; $val1_L; $val2_L)
$opts_txt:=$opts_txt+"Double sided option "+Char:C90(9)+String:C10($val1_L)+Char:C90(9)+String:C10($val2_L)+Char:C90(13)
//GET PRINT OPTION(_o_Hide printing progress option; $val1_L)
//$opts_txt:=$opts_txt+"Hide printing progress option "+Char(9)+String($val1_L)+Char(13)
GET PRINT OPTION:C734(Mac spool file format option:K47:11; $val1_L)
$opts_txt:=$opts_txt+"Mac spool file format option "+Char:C90(9)+String:C10($val1_L)+Char:C90(13)
GET PRINT OPTION:C734(Number of copies option:K47:4; $val1_L)
$opts_txt:=$opts_txt+"Number of copies option "+Char:C90(9)+String:C10($val1_L)+Char:C90(13)
GET PRINT OPTION:C734(Orientation option:K47:2; $val1_L)
$opts_txt:=$opts_txt+"Orientation option "+Char:C90(9)+String:C10($val1_L)+Char:C90(13)
GET PRINT OPTION:C734(Paper option:K47:1; $val1_L; $val2_L)
$opts_txt:=$opts_txt+"Paper option "+Char:C90(9)+String:C10($val1_L)+Char:C90(9)+String:C10($val2_L)+Char:C90(13)
GET PRINT OPTION:C734(Paper option:K47:1; $val2_txt)
$opts_txt:=$opts_txt+"Paper option "+Char:C90(9)+$val2_txt+Char:C90(13)
GET PRINT OPTION:C734(Paper source option:K47:5; $val1_L)
$opts_txt:=$opts_txt+"Paper source option "+Char:C90(9)+String:C10($val1_L)+Char:C90(13)
GET PRINT OPTION:C734(Scale option:K47:3; $val1_L)
$opts_txt:=$opts_txt+"Scale option "+Char:C90(9)+String:C10($val1_L)+Char:C90(13)
GET PRINT OPTION:C734(Spooler document name option:K47:10; $val2_txt)
$opts_txt:=$opts_txt+"Spooler document name option "+Char:C90(9)+$val2_txt+Char:C90(13)

$0:=$opts_txt
//End DBG_GetPrintOptions