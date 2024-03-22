//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/18/13, 10:59:33
//----------------------------------------------------
//Method: Object Method: [Inspections].TunnelInspection.aI62bCollisionDamage
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_09  //r001 ` Created
	//Modified by: Charles Miller (9/18/13 10:59:34)
	//Add fields to [TunnelInspection] to track 
	//Structural Collision Damage
	//[TunnelInspection]StructuralCollisionValue_s
	//[TunnelInspection]StructuralCollisionComments_txt
	//Roadway collision damage
	//[TunnelInspection]RoadwayCollisionValue_s
	//[TunnelInspection]RoadwayCollisionComments_txt
	// Modified by: Costas Manousakis-(Designer)-(11/20/13 08:38:23)
	Mods_2013_11
	//  `fixed stack number for the changes on table [TunnelInspection]
End if 
POPUPMENUC(->aI62bCollisionDamage; ->aCollisionCode; ->[TunnelInspection:152]RoadwayCollisionValue_s:29)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(5; ->[TunnelInspection:152]RoadwayCollisionValue_s:29)
End if 

C_BOOLEAN:C305($bNone)
$bNone:=(([TunnelInspection:152]RoadwayCollisionValue_s:29="N") | ([TunnelInspection:152]RoadwayCollisionValue_s:29=""))
If ($bNone)
	If (Form event code:C388=On Clicked:K2:4)
		[TunnelInspection:152]RoadwayCollisionComments_txt:30:=""
		PushChange(5; ->[TunnelInspection:152]RoadwayCollisionComments_txt:30)
	End if 
	//DISABLE BUTTON(*;"DE I59Coll@")
	INSP_ResetButton($bNone; "DE I62bCollision Btn"; [TunnelInspection:152]RoadwayCollisionValue_s:29)
Else 
	INSP_ResetButton($bNone; "DE I62bCollision Btn"; [TunnelInspection:152]RoadwayCollisionComments_txt:30)
	//ENABLE BUTTON(*;"DE I59Coll@")
	//If ([Inspections]CollisionSuper="")
	//  `Alert user to enter text
	//SET COLOR(*;"DE I59Coll@";-(Red ))
	//Else 
	//SET COLOR(*;"DE I59Coll@";-(Black ))
	//End if 
End if 

//End Object Method: [Inspections].TunnelInspection.aI62bCollisionDamage