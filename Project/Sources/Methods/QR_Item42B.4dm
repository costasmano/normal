//%attributes = {"shared":true}
// Method: QR_Item42B
// Description
// Return descr for Item 42B ; If param 1 is passed will use the last 2nd char
// Parameters
// $0 : $retValue_s
// $1 : $Item42  (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/20/15, 15:12:07
	// ----------------------------------------------------
	Mods_2015_11
	//add optional param $1 - changed all params to text
	C_TEXT:C284(QR_Item42B; $0)
	C_TEXT:C284(QR_Item42B; $1)
End if 

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 40
C_TEXT:C284($vsItem42b)  // Command Replaced was o_C_STRING length was 1
$vsItem42b:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$vsItem42b:=Substring:C12($1; 2; 1)
End if 
$0:=Get_Description(-><>aServUndr; -><>aSerUndrCod; ->$vsItem42b)
If ($0="")
	$0:="Unknown"
End if 