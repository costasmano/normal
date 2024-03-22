//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:57:31
	// ----------------------------------------------------
	// Method: Method: SC_RemainLife_Net
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 

C_LONGINT:C283($0; $LifeRemain)
C_LONGINT:C283($BridgeAge; $YearAdd_60; $YearAdd_61)
$BridgeAge:=iAgeofBridge
SC_WriteSingleDataCol(String:C10($BridgeAge))
$LifeRemain:=SC_MaxLife_L-$BridgeAge
Case of 
	: ($LifeRemain<0)
		$LifeRemain:=0
	: ($LifeRemain>SC_MaxLife_L)
		$LifeRemain:=SC_MaxLife_L
End case 
$YearAdd_60:=SC_YearAdd_60
$YearAdd_61:=SC_YearAdd_61
SC_WriteSingleDataCol(String:C10($LifeRemain))
SC_WriteSingleDataCol(String:C10($YearAdd_60))
SC_WriteSingleDataCol(String:C10($YearAdd_61))
$LifeRemain:=$LifeRemain+$YearAdd_60+$YearAdd_61
Case of 
	: ($LifeRemain<SC_MinLife_L)
		$LifeRemain:=SC_MinLife_L
	: ($LifeRemain>SC_MaxLife_L)
		$LifeRemain:=SC_MaxLife_L
End case 
SC_WriteSingleDataCol(String:C10($LifeRemain))

$0:=$LifeRemain