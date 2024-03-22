//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/03/09, 17:22:06
	// ----------------------------------------------------
	// Method: SCPOA_TransFtgUtil
	// Description
	// Translate the coding in the HNTB db for foundtion type
	// 
	// Parameters
	// $0 : $Transl_txt
	// $1 : $HNTBCode_txt
	// ----------------------------------------------------
	
	Mods_2009_06
End if 
C_TEXT:C284($0; $1; $Transl_txt; $HNTBCode_txt)
$HNTBCode_txt:=$1
$Transl_txt:=""
Case of 
	: (($HNTBCode_txt="NA") | ($HNTBCode_txt="No Plans@") | ($HNTBCode_txt="UKNOWN@") | ($HNTBCode_txt="UNKNOWN@"))
		$Transl_txt:="UNKNOWN"
	: ($HNTBCode_txt="Spread Footings/Timbr Pls")
		$Transl_txt:=$HNTBCode_txt
	: ($HNTBCode_txt="Spread@")
		$Transl_txt:="SPREAD FOOTINGS"
	: ($HNTBCode_txt="STEEL@")
		$Transl_txt:="STEEL H-PILES"
	Else 
		$Transl_txt:=$HNTBCode_txt
End case 

$0:=$Transl_txt