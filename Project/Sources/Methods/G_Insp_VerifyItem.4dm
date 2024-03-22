//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_VerifyItem
	//Method to Make sure that an NBI Rating Item is an allowable value.
	//If not will return N.
	//Applies to Items 58-62.
	
	Mods_2005_CM05
	
End if 

C_TEXT:C284($1; $0; $vsItem)  // Command Replaced was o_C_STRING length was 2
$vsItem:=$1
If (Position:C15($vsItem; ";N;0;1;2;3;4;5;6;7;8;9;")<=0)
	$vsItem:="N"
End if 

$0:=$vsItem