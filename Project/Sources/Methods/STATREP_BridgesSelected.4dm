//%attributes = {"invisible":true}
//Method: STATREP_BridgesSelected
//Description
//
// Parameters
// $0 : $BridgeSelection_txt
// $1 : $Method_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/09/19, 15:42:24
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09
	
	C_TEXT:C284(STATREP_BridgesSelected; $0)
	C_LONGINT:C283(STATREP_BridgesSelected; $1)
End if 
//

C_TEXT:C284($BridgeSelection_txt; $0)
C_LONGINT:C283($Method_L; $1)
$Method_L:=$1
$BridgeSelection_txt:=""

Case of 
	: ($Method_L=0)
		$BridgeSelection_txt:="All NBIs"
		
	: ($Method_L=1)
		$BridgeSelection_txt:="All BRIs"
		
	: ($Method_L=2)
		$BridgeSelection_txt:="Non-NBI"
		
	: ($Method_L=3)
		$BridgeSelection_txt:="Mixed NBI and Non-NBI"
		
	: ($Method_L=4)
		$BridgeSelection_txt:="Subset of NBI"
		
	: ($Method_L=5)
		$BridgeSelection_txt:="Subset of BRI"
		
End case 


$0:=$BridgeSelection_txt

//End STATREP_BridgesSelected