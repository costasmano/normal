//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_AdditionalBridges
// User name (OS): cjmiller
// Date and time: 02/02/06, 12:05:36
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
ARRAY TEXT:C222($PRJ_SelectedBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $PRJ_SelectedBins_as)
FIRST RECORD:C50([Bridge MHD NBIS:1])
PRJ_DEBridgeNo_s:=[Bridge MHD NBIS:1]BDEPT:1
QUERY WITH ARRAY:C644([TownLineInfo:73]BIN:1; $PRJ_SelectedBins_as)
ARRAY TEXT:C222($AdditionalBridges_atxt; 0)
DISTINCT VALUES:C339([TownLineInfo:73]BDEPT:2; $AdditionalBridges_atxt)
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274($AdditionalBridges_atxt))
	If ($AdditionalBridges_atxt{$Loop_l}#"")
		PRJ_DEBridgeNo_s:=PRJ_DEBridgeNo_s+"="+$AdditionalBridges_atxt{$Loop_l}
	End if 
End for 
ARRAY TEXT:C222($AdditionalBridges_atxt; 0)

//End PRJ_AdditionalBridges