//%attributes = {"invisible":true}
//Method: TNL_AccessibilityPrint
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/24/13, 13:01:24
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
vLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 2; 1)
vNeedLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 1; 1)

vLadder:=Substring:C12([Inspections:27]Ladder:87; 2; 1)
vNeedLadder:=Substring:C12([Inspections:27]Ladder:87; 1; 1)

vWader:=Substring:C12([Inspections:27]Wader:89; 2; 1)
vNeedWader:=Substring:C12([Inspections:27]Wader:89; 1; 1)

vStaging:=Substring:C12([Inspections:27]Staging:92; 2; 1)
vNeedStaging:=Substring:C12([Inspections:27]Staging:92; 1; 1)

vTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 2; 1)
vNeedTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 1; 1)

vFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 2; 1)
vNeedFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 1; 1)

vPolice:=Substring:C12([Inspections:27]Police:95; 2; 1)
vNeedPolice:=Substring:C12([Inspections:27]Police:95; 1; 1)

vConfinedSpace:=Substring:C12([Inspections:27]ConfinedSp:182; 1; 1)
vNeedConfinedSpace:=Substring:C12([Inspections:27]ConfinedSp:182; 2; 1)

vAirMeter:=Substring:C12([TunnelInspection:152]AirMeter_s:12; 1; 1)
vNeedAirMeter:=Substring:C12([TunnelInspection:152]AirMeter_s:12; 2; 1)

vEscapeAir:=Substring:C12([TunnelInspection:152]EscapeAir_s:13; 1; 1)
vNeedEscapeAir:=Substring:C12([TunnelInspection:152]EscapeAir_s:13; 2; 1)

vScissorLift:=Substring:C12([TunnelInspection:152]ScissorLift_s:14; 1; 1)
vNeedScissorLift:=Substring:C12([TunnelInspection:152]ScissorLift_s:14; 2; 1)

//End TNL_AccessibilityPrint