//%attributes = {"invisible":true}
//Method: PRV_SortByBRGINFO_s
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/12/12, 10:46:49
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1)

PRV_Variables("RELATEBRIDGEINFO")

Case of 
	: ($1="DIST")
		$0:=PRV_Dist_txt
	: ($1="BDEPT")
		$0:=PRV_BDEPT_txt
	: ($1="OVERUNDER")
		$0:=PRV_OverUnder_txt
	: ($1="ONOFF")
		$0:=PRV_OnOff_txt
		
End case 

//End PRV_SortByBRGINFO_s