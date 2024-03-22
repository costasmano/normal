//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/05/08, 13:28:46
	// ----------------------------------------------------
	// QR_Itm26_Category 
	// Description
	//  `Return a general descr of the Func Class category or  a number based on item 26
	//  ` Interstate, (1), Arterial (2), Collector (3), Local (4)
	// 
	// 
	// Parameters
	// $0 : $RetVal_Txt
	// $1 : $Itm26
	// $2 : $RetValOpt_txt
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_TEXT:C284($0; $RetVal_Txt; $StateLoc_txt)
$RetVal_Txt:=""
C_TEXT:C284($1; $Itm26)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($2; $RetValOpt_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 2
	$Itm26:=$1
Else 
	$Itm26:=[Bridge MHD NBIS:1]Item26:120
End if 
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$RetValOpt_txt:=$2
Else 
	$RetValOpt_txt:="TEXT"
End if 
$StateLoc_txt:=""
Case of 
	: (Position:C15("."+$Itm26+"."; ".01.11.")>0)
		Case of 
			: ($RetValOpt_txt="TEXT")
				$RetVal_Txt:="Interstate"
			: ($RetValOpt_txt="NUM")
				$RetVal_Txt:="1"
		End case 
	: (Position:C15("."+$Itm26+"."; ".02.06.12.14.16.")>0)
		Case of 
			: ($RetValOpt_txt="TEXT")
				$RetVal_Txt:="Arterial"
			: ($RetValOpt_txt="NUM")
				$RetVal_Txt:="2"
				
		End case 
	: (Position:C15("."+$Itm26+"."; ".07.08.17.")>0)
		Case of 
			: ($RetValOpt_txt="TEXT")
				$RetVal_Txt:="Collector"
			: ($RetValOpt_txt="NUM")
				$RetVal_Txt:="3"
				
		End case 
	: (Position:C15("."+$Itm26+"."; ".09.19.")>0)
		Case of 
			: ($RetValOpt_txt="TEXT")
				$RetVal_Txt:="Local"
			: ($RetValOpt_txt="NUM")
				$RetVal_Txt:="4"
				
		End case 
		
End case 

$0:=$RetVal_Txt