//%attributes = {"shared":true}
// Method: QR_Item43A
// Description
// Return translation for item43a
// 
// Parameters
// $0 : Material A40
// $1 :  Text (optional) 
//  `  `if not passed uses current record from [bridge mhd nbis]
//  `  `method will use the 1st char from $1
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(9/10/12)
	Mods_2012_09
	//  `Added optional parameter
	// Modified by: Costas Manousakis-(Designer)-(11/20/15 15:10:02)
	Mods_2015_11
	//  `made vsItem43a to a local var - all params to text
	C_TEXT:C284(QR_Item43A; $0)
	C_TEXT:C284(QR_Item43A; $1)
End if 

C_TEXT:C284($0)
C_TEXT:C284($vsItem43a)  // Command Replaced was o_C_STRING length was 1
$vsItem43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$vsItem43a:=Substring:C12($1; 1; 1)
End if 

$0:=Get_Description(-><>aMaterial; -><>aMatCode; ->$vsItem43a)
If ($0="")
	$0:="Unknown"
End if 