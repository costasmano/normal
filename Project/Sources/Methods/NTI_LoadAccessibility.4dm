//%attributes = {"invisible":true}
//Method: NTI_LoadAccessibility
//Description
// load the accesib vars from [TunnelInspection] table
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/16/17, 12:04:32
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
End if 
//
vAccesibN9:=Substring:C12([TunnelInspection:152]AirMeter_s:12; 1; 1)
vAccesibU9:=Substring:C12([TunnelInspection:152]AirMeter_s:12; 2; 1)
vAccesibN10:=Substring:C12([TunnelInspection:152]EscapeAir_s:13; 1; 1)
vAccesibU10:=Substring:C12([TunnelInspection:152]EscapeAir_s:13; 2; 1)
vAccesibN11:=Substring:C12([TunnelInspection:152]ScissorLift_s:14; 1; 1)
vAccesibU11:=Substring:C12([TunnelInspection:152]ScissorLift_s:14; 2; 1)

//End NTI_LoadAccessibility