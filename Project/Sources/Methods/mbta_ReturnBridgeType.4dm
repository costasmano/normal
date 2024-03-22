//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/07/13, 15:36:45
//----------------------------------------------------
//Method: mbta_ReturnBridgeType
//Description
//
// Parameters
// $1 : $BridgeCat (Optional) - default is [Bridge MHD NBIS]Item8 BridgeCat
// ----------------------------------------------------
If (False:C215)
	Mods_2013_03  //r001 ` 
	//Modified by: Charles Miller (3/7/13 15:36:47)
	// Modified by: Costas Manousakis-(Designer)-(4/23/13 08:05:36)
	Mods_2013_04
	//  `CLP = Pedestrian
	// Modified by: Costas Manousakis-(Designer)-(10/30/18 16:58:51)
	Mods_2018_10
	//  `added optional parameter 1 for bridge category
	
End if 
C_TEXT:C284($0)
C_TEXT:C284($BridgeCat_txt)
$BridgeCat_txt:=[Bridge MHD NBIS:1]Item8 BridgeCat:207
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$BridgeCat_txt:=$1
End if 
Case of 
	: ($BridgeCat_txt="RRO")
		$0:="Commuter"
	: ($BridgeCat_txt="TRO")
		$0:="Transit"
	: ($BridgeCat_txt="PED")
		$0:="Pedestrian"
	: ($BridgeCat_txt="DES")
		$0:=""
	: ($BridgeCat_txt="REM")
		$0:=""
	: ($BridgeCat_txt="DUM")
		$0:=""
	: ($BridgeCat_txt="CLP")
		$0:="Pedestrian"
	: ($BridgeCat_txt="CLO")
		$0:=""
	Else 
		$0:="Highway"
End case 
//End mbta_ReturnBridgeType