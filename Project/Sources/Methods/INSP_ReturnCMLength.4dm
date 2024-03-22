//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/07/13, 16:30:36
//----------------------------------------------------
//Method: INSP_ReturnCMLength
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` Modify length that can fit in remarks based upon inspection type
	//Modified by: Charles Miller (5/7/13 16:30:37)
	// Modified by: Costas Manousakis-(Designer)-(4/25/14 11:10:54)
	Mods_2014_04
	//  `added  case for rail inspections and check for MBTA bridges
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 17:16:13)
	Mods_2015_01
	//  `added TDA : tunnel damage
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 12:08:50)
	Mods_2015_02
	//  `added  TOT : tunnel  Other
End if 
C_LONGINT:C283($0)

$0:=<>vLimitCharFCR

C_TEXT:C284($InspType_txt)
$InspType_txt:=[Inspections:27]Insp Type:6

If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
	//for mbta bridges use the "Rail "case
	$InspType_txt:="RRR"
End if 

Case of 
	: ($InspType_txt="TAL")
		$0:=60
	: ($InspType_txt="TOV")
		$0:=54
	: (($InspType_txt="TSP") | ($InspType_txt="TDA") | ($InspType_txt="TOT"))
		$0:=60
	: ($InspType_txt="RR@")
		C_TEXT:C284($bridgeType_txt)
		$bridgeType_txt:=mbta_ReturnBridgeType
		Case of 
			: ($bridgeType_txt="Commuter")
				$0:=32
			: ($bridgeType_txt="Highway")
				$0:=28
			: ($bridgeType_txt="Transit")
				$0:=60
		End case 
		
End case 
//End INSP_ReturnCMLength