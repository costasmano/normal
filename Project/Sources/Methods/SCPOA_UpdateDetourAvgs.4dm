//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/21/09, 12:34:26
	// ----------------------------------------------------
	// Method: SCPOA_UpdateDetourAvgs
	// Description
	// Update the averages for the detour bridges
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
End if 
C_LONGINT:C283($numDetBridges_L)
QUERY:C277([ScourPOA_DetourBridge:133]; [ScourPOA_DetourBridge:133]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
$numDetBridges_L:=Records in selection:C76([ScourPOA_DetourBridge:133])
ARRAY TEXT:C222(SCPOA_DetBIns_atxt; $numDetBridges_L)
If ($numDetBridges_L>0)
	ARRAY LONGINT:C221($DetourRecords_aL; $numDetBridges_L)
	ARRAY TEXT:C222($DetBDepts_atxt; $numDetBridges_L)
	SELECTION TO ARRAY:C260([ScourPOA_DetourBridge:133]; $DetourRecords_aL; [ScourPOA_DetourBridge:133]DetourBIN:3; SCPOA_DetBIns_atxt)
	QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; SCPOA_DetBIns_atxt)
	ARRAY LONGINT:C221($BridgeADTs_aL; $numDetBridges_L)
	ARRAY INTEGER:C220($BridgeYrADTs_aL; $numDetBridges_L)
	ARRAY INTEGER:C220($BridgeTrcpPcts_aL; $numDetBridges_L)
	ARRAY REAL:C219($BridgeLens_ar; $numDetBridges_L)
	ARRAY TEXT:C222($BridgeBdepts_atxt; $numDetBridges_L)
	ARRAY TEXT:C222($BridgeBINS_atxt; $numDetBridges_L)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item29:88; $BridgeADTs_aL; [Bridge MHD NBIS:1]Item109:90; $BridgeTrcpPcts_aL; [Bridge MHD NBIS:1]Item49:93; $BridgeLens_ar; [Bridge MHD NBIS:1]Item30:89; $BridgeYrADTs_aL; [Bridge MHD NBIS:1]BDEPT:1; $BridgeBdepts_atxt; [Bridge MHD NBIS:1]BIN:3; $BridgeBINS_atxt)
	C_LONGINT:C283($Total29; $totalPCt; $TotalYr; $loop; $xref)
	$Total29:=0
	$totalPCt:=0
	$TotalYr:=0
	C_REAL:C285($TotalLen)
	$TotalLen:=0
	For ($loop; 1; $numDetBridges_L)
		$Total29:=$Total29+$BridgeADTs_aL{$loop}
		$totalPCt:=$totalPCt+$BridgeTrcpPcts_aL{$loop}
		$TotalYr:=$TotalYr+$BridgeYrADTs_aL{$loop}
		$TotalLen:=$TotalLen+$BridgeLens_ar{$loop}
		$xref:=Find in array:C230(SCPOA_DetBIns_atxt; $BridgeBINS_atxt{$loop})
		$DetBDepts_atxt{$xref}:=$BridgeBdepts_atxt{$loop}
	End for 
	SCPOACalcAvgADT_L:=$Total29/$numDetBridges_L
	SCPOACalcAvgADTYear_L:=$TotalYr/$numDetBridges_L
	SCPOACalcAvgADTTrckPct_L:=$totalPCt/$numDetBridges_L
	SCPOACalcDetourBrgLen_R:=3.2808*$TotalLen
	SORT ARRAY:C229($DetBDepts_atxt; $DetourRecords_aL)
	//QUERY WITH ARRAY([ScourPOA_DetourBridge]DetourBridgeID_L;$DetourRecords_aL)
	CREATE SELECTION FROM ARRAY:C640([ScourPOA_DetourBridge:133]; $DetourRecords_aL)
Else 
	SCPOACalcAvgADT_L:=0
	SCPOACalcAvgADTYear_L:=0
	SCPOACalcAvgADTTrckPct_L:=0
	SCPOACalcDetourBrgLen_R:=0
	
End if 
