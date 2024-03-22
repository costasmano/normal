//%attributes = {"invisible":true}
//Method: RtgReq_GetBridgeInfo
//Description
//  ` retrieve a field from a BIN return it as string 80
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:39:17
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($1; $BIN_s)  // Command Replaced was o_C_STRING length was 3
C_POINTER:C301($2; $BrgField_ptr)
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$1)
$0:=$2->

//End RtgReq_GetBridgeInfo