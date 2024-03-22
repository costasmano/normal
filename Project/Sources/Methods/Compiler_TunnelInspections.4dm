//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/18/13, 11:35:25
//----------------------------------------------------
//Method: Compiler_TunnelInspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_09  //r001 ` 
	//Modified by: Charles Miller (9/18/13 11:35:26)
	//Add fields to [TunnelInspection] to track 
	//Structural Collision Damage
	//[TunnelInspection]StructuralCollisionValue_s
	//[TunnelInspection]StructuralCollisionComments_txt
	//Roadway collision damage
	//[TunnelInspection]RoadwayCollisionValue_s
	//[TunnelInspection]RoadwayCollisionComments_txt
End if 
If (Not:C34(Is compiled mode:C492))
	C_TEXT:C284(xR62a1; xR62a2; xR62a3; xR62a4; xR62b1; xR62b2; xR62b3; xR62b4)  // Command Replaced was o_C_STRING length was 1
	C_LONGINT:C283(vbI62bCollcmts; vbI59Collcmts; vbI62aCollcmts)
End if 

//End Compiler_TunnelInspections