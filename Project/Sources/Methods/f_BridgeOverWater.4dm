//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/17/10, 13:19:06
	// ----------------------------------------------------
	// Method: f_BridgeOverWater
	// Description
	//  ` Determine whether a bridge is over water based on item 42B
	// 
	// Parameters
	// $0 : $OverWater_b
	// $1 : $ITM42_txt (Optional)
	// ----------------------------------------------------
	
	Mods_2010_12
End if 
C_BOOLEAN:C305($0; $OverWater_b)
$OverWater_b:=False:C215
C_TEXT:C284($ITM42_txt; $ITM42B_txt; $ITM42BWaterCodes_txt)
$ITM42BWaterCodes_txt:="-5-6-7-8-9-"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$ITM42_txt:=$1
Else 
	$ITM42_txt:=[Bridge MHD NBIS:1]Item42:85
End if 
If (Length:C16($ITM42_txt)>1)
	$ITM42B_txt:=Substring:C12($ITM42_txt; 2; 1)
Else 
	$ITM42B_txt:=$ITM42_txt
End if 
If (Position:C15(("-"+$ITM42B_txt+"-"); $ITM42BWaterCodes_txt)>0)
	$OverWater_b:=True:C214
End if 

$0:=$OverWater_b