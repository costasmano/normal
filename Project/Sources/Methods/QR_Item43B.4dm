//%attributes = {"shared":true}
// Method: QR_Item43B
// Description
// Return descr for Item 43B ; If param 1 is passed will use the last 2nd and 3rd chars
// Parameters
// $0 : $retValue_s
// $1 : $Item43  (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/20/15, 15:05:55
	// ----------------------------------------------------
	
	Mods_2015_11
	//add optional param $1 - changed all params to text
	C_TEXT:C284(QR_Item43B; $0)
	C_TEXT:C284(QR_Item43B; $1)
End if 

C_TEXT:C284($0)
C_TEXT:C284($vsItem43B)  // Command Replaced was o_C_STRING length was 2

$vsItem43B:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$vsItem43B:=Substring:C12($1; 2; 2)
End if 

$0:=Get_Description(-><>aDesign; -><>aDesignCod; ->$vsItem43B)
If ($0="")
	$0:="Unknown"
End if 