//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/05/08, 13:28:46
	// ----------------------------------------------------
	// Method: QR_Itm22_Sta_Loc
	// Description
	//  `Return "State"| "Local" based on Item 22 or "1" | "2" if a number is requested
	// 
	// 
	// Parameters
	// $0 : $RetVal_Txt
	// $1 : $Itm22
	// $2 : $RetValOpt_txt
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_TEXT:C284($0; $RetVal_Txt; $StateLoc_txt)
$RetVal_Txt:=""
C_TEXT:C284($1; $Itm22)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($2; $RetValOpt_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 2
	$Itm22:=$1
Else 
	$Itm22:=[Bridge MHD NBIS:1]Item22:128
End if 
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$RetValOpt_txt:=$2
Else 
	$RetValOpt_txt:="TEXT"
End if 
$StateLoc_txt:=""
Case of 
	: (Position:C15("."+$Itm22+"."; ".01.11.21.31.")>0)
		Case of 
			: ($RetValOpt_txt="TEXT")
				$RetVal_Txt:="State"
			: ($RetValOpt_txt="NUM")
				$RetVal_Txt:="1"
		End case 
	: (Position:C15("."+$Itm22+"."; ".03.04.25.32.")>0)
		Case of 
			: ($RetValOpt_txt="TEXT")
				$RetVal_Txt:="Local"
			: ($RetValOpt_txt="NUM")
				$RetVal_Txt:="2"
				
		End case 
End case 

$0:=$RetVal_Txt