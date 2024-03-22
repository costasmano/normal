//%attributes = {"shared":true}
// Method: QR_Item42A
// Description
// Return descr for Item 42B ; If param 1 is passed will use the 1st char
// Parameters
// $0 : $retValue_s
// $1 : $Item42  (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/20/15, 15:14:47
	// ----------------------------------------------------
	Mods_2015_11
	//add optional param $1 - changed all params to text
	C_TEXT:C284(QR_Item42A; $0)
	C_TEXT:C284(QR_Item42A; $1)
	
End if 
C_TEXT:C284($0)
C_TEXT:C284($vsItem42a)  // Command Replaced was o_C_STRING length was 1
$vsItem42a:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 1; 1)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$vsItem42a:=Substring:C12($1; 1; 1)
End if 

$0:=Get_Description(-><>aServiceOvr; -><>aSerOvrCode; ->$vsItem42a)
If ($0="")
	$0:="Unknown"
End if 