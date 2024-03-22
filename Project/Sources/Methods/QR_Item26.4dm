//%attributes = {"shared":true}
// Method: QR_Item26
// Description
// Item 26
// Parameters
// $0 : $RetValue_s
// $1 : Optional text
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/20/15, 15:57:21
	// ----------------------------------------------------
	Mods_2015_11
	//add optional param $1 - changed all params to text
	C_TEXT:C284(QR_Item26; $0)
	C_TEXT:C284(QR_Item26; $1)
End if 

C_TEXT:C284($0)
C_TEXT:C284($SearchVal_txt)
$SearchVal_txt:=[Bridge MHD NBIS:1]Item26:120
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$SearchVal_txt:=$1
End if 

$0:=Get_Description(->aItem26Des; ->aItem26; ->$SearchVal_txt)
If ($0="")
	$0:="UnKnown"
End if 