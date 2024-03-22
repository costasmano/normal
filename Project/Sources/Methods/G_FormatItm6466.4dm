//%attributes = {"invisible":true}
//G_FormatItm6466

//Created to define unit label and the display format
//of Items 64 and 66 depending on values of Items 63,65  
If (False:C215)
	//29-Oct-2004
	
	// Modified by: Costas Manousakis-(Designer)-(10/31/16 13:06:03)
	Mods_2016_10
	//  `changed rating formats to allow more numbers in front
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 12:07:11)
	Mods_2017_03
	//  `use new global vars for MT or RF  rating loads
End if 

C_POINTER:C301($1; $vpItm65fld; $2; $vpItm66fld; $3; $vpUnitLbl)
C_TEXT:C284($4; $vsMtonFMT; $5; $vsRFFmt)  // Command Replaced was o_C_STRING length was 10

$vpItm65fld:=$1
$vpItm66fld:=$2
C_REAL:C285($maxValue)

If (Count parameters:C259>2)
	$vpUnitLbl:=$3
End if 
If (Count parameters:C259>3)
	$vsMtonFMT:=$4
Else 
	$vsMtonFMT:="##00.0"
End if 
If (Count parameters:C259>4)
	$vsRFFmt:=$5
Else 
	$vsRFFmt:="##0.00"
End if 

C_TEXT:C284($vsUnitLabel; $vsFieldFormat)  // Command Replaced was o_C_STRING length was 6
Case of 
	: (Position:C15($vpItm65fld->; <>SIA_LoadRtg_63_MT_txt)>0)
		$vsUnitLabel:="MTONS"
		$vsFieldFormat:=$vsMtonFMT
		$maxValue:=9999.9
	: (Position:C15($vpItm65fld->; <>SIA_LoadRtg_63_RF_txt)>0)
		$vsUnitLabel:="RF"
		$vsFieldFormat:=$vsRFFmt
		$maxValue:=3
End case 

OBJECT SET FORMAT:C236($vpItm66fld->; $vsFieldFormat)
OBJECT SET MAXIMUM VALUE:C1244($vpItm66fld->; $maxValue)
If (Count parameters:C259>2)
	$vpUnitLbl->:=$vsUnitLabel
End if 