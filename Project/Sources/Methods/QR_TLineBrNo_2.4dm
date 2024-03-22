//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/05, 15:30:52
	// ----------------------------------------------------
	// Method: QR_TLineBrNo_2
	// Description
	// Retrieve the TownLineBridge number
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM16
End if 

C_TEXT:C284($0; $Res)  // Command Replaced was o_C_STRING length was 6
QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2; >)
SELECTION TO ARRAY:C260([TownLineInfo:73]BDEPT:2; aBDEPT_)
C_LONGINT:C283($i)
$Res:=""
For ($i; 1; Size of array:C274(aBDEPT_))
	If (Length:C16(Replace string:C233(aBDEPT_{$i}; " "; ""))>0)
		$Res:=aBDEPT_{$i}
		$i:=Size of array:C274(aBDEPT_)+1
	End if 
End for 
$0:=$Res