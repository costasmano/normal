//%attributes = {"invisible":true}
//Method: PRJ_LB_ReturnBridgeNo
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 11/05/20, 13:56:06
	// ----------------------------------------------------
	//Created : 
	Mods_2020_11
	
	C_TEXT:C284(PRJ_LB_ReturnBridgeNo; $0)
	C_POINTER:C301(PRJ_LB_ReturnBridgeNo; $1; $2; $3)
	
End if 
//
C_POINTER:C301($1; $2; $3; $Bridge_ptr; $NonBridge_ptr; $TempBridge_ptr)
$Bridge_ptr:=$1
$NonBridge_ptr:=$2
$TempBridge_ptr:=$3
C_TEXT:C284($0; $BridgeNo_txt)

If ($Bridge_ptr->="")
	$BridgeNo_txt:=$NonBridge_ptr->
Else 
	$BridgeNo_txt:=$Bridge_ptr->
End if 
If ($TempBridge_ptr->)
	$BridgeNo_txt:=$BridgeNo_txt+"T"
	C_LONGINT:C283($eqPos_L)
	$eqPos_L:=Position:C15("="; $BridgeNo_txt)
	If ($eqPos_L>0)
		//Equation -add T before = 
		$BridgeNo_txt:=Substring:C12($BridgeNo_txt; 1; ($eqPos_L-1))+"T"+Substring:C12($BridgeNo_txt; $eqPos_L)
	End if 
End if 
$0:=$BridgeNo_txt

//End PRJ_LB_ReturnBridgeNo