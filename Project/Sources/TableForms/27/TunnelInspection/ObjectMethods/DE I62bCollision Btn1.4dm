
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/18/13, 11:02:13
//----------------------------------------------------
//Method: Object Method: [Inspections].TunnelInspection.vbI62bCollcmts
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_09  //r001 ` 
	//Modified by: Charles Miller (9/18/13 11:02:14)
	//Add fields to [TunnelInspection] to track 
	//Structural Collision Damage
	//[TunnelInspection]StructuralCollisionValue_s
	//[TunnelInspection]StructuralCollisionComments_txt
	//Roadway collision damage
	//[TunnelInspection]RoadwayCollisionValue_s
	//[TunnelInspection]RoadwayCollisionComments_txt
	
	// Modified by: Costas Manousakis-(Designer)-(12/3/13 09:24:36)
	Mods_2013_12
	//  `fix bug of wrong change stack
	
End if 
G_InspExtraCmtsBtn("Item 62b Roadway Collision Comments"; ->[TunnelInspection:152]RoadwayCollisionComments_txt:30; Self:C308; 5)

//End Object Method: [Inspections].TunnelInspection.vbI62bCollcmts

