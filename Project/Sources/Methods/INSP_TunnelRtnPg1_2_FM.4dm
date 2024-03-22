//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/23/13, 15:10:48
//----------------------------------------------------
//Method: INSP_TunnelRtnPg1_2_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_04  //r001 ` 
	//Modified by: Charles Miller (4/23/13 15:11:05)
	Mods_2013_09  //r001 ` 
	//Modified by: Charles Miller (9/18/13 11:32:40)
	//Add fields to [TunnelInspection] to track 
	//Structural Collision Damage
	//[TunnelInspection]StructuralCollisionValue_s
	//[TunnelInspection]StructuralCollisionComments_txt
	//Roadway collision damage
	//[TunnelInspection]RoadwayCollisionValue_s
	//[TunnelInspection]RoadwayCollisionComments_txt
	// Modified by: Costas Manousakis-(Designer)-(6/5/18 09:42:21)
	Mods_2018_06_bug
	//  `Change ChemicalAnchors to use the field from tunnel inspection, not tunnelinfo
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
	: ($FormEvent_L=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		INSP_LoadESForReport([Inspections:27]Insp Type:6)
		TNL_AccessibilityPrint
		f_Var_to_Series([Inspections:27]CollisionDamSup:13; "xR"; "NRMS"; "N")
		f_Var_to_Series([TunnelInspection:152]StructuralCollisionValue_s:27; "xR62a"; "NRMS"; "N")
		f_Var_to_Series([TunnelInspection:152]RoadwayCollisionValue_s:29; "xR62b"; "NRMS"; "N")
		
		
		//vChemicalAnchors:=f_Boolean2String ([TunnelInfo]ChemicalAnchors_b;"YN")
		vChemicalAnchors:=Choose:C955([TunnelInspection:152]ChemicalAnchors_b:25; "Y"; "N")
End case 
//End INSP_TunnelRtnPg1_2_FM