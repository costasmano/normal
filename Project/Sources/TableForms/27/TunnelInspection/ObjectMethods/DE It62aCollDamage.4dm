//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/18/13, 10:59:06
//----------------------------------------------------
//Method: [Inspections].TunnelInspection.aI62aCollisionDamage
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_09  //r001 ` 
	//Modified by: Charles Miller (9/18/13 10:59:08)
	//Add fields to [TunnelInspection] to track 
	//Structural Collision Damage
	//[TunnelInspection]StructuralCollisionValue_s
	//[TunnelInspection]StructuralCollisionComments_txt
	//Roadway collision damage
	//[TunnelInspection]RoadwayCollisionValue_s
	//[TunnelInspection]RoadwayCollisionComments_txt
	// Modified by: Costas Manousakis-(Designer)-(11/20/13 08:38:23)
	Mods_2013_11
	//  `fixed stack number for the changes
End if 
POPUPMENUC(->aI62aCollisionDamage; ->aCollisionCode; ->[TunnelInspection:152]StructuralCollisionValue_s:27)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(5; ->[TunnelInspection:152]StructuralCollisionValue_s:27)
End if 
//do we need this for 62a collision damage
C_BOOLEAN:C305($bNone)
$bNone:=(([TunnelInspection:152]StructuralCollisionValue_s:27="N") | ([TunnelInspection:152]StructuralCollisionValue_s:27=""))
If ($bNone)
	If (Form event code:C388=On Clicked:K2:4)
		[TunnelInspection:152]StructuralCollisionComments_txt:28:=""
		PushChange(5; ->[TunnelInspection:152]StructuralCollisionComments_txt:28)
	End if 
	//DISABLE BUTTON(*;"DE I59Coll@")
	
	INSP_ResetButton($bNone; "DE I62aCollision Btn"; [TunnelInspection:152]StructuralCollisionValue_s:27)
Else 
	INSP_ResetButton($bNone; "DE I62aCollision Btn"; [TunnelInspection:152]StructuralCollisionComments_txt:28)
	//ENABLE BUTTON(*;"DE I59Coll@")
	//If ([Inspections]CollisionSuper="")
	//  `Alert user to enter text
	//SET COLOR(*;"DE I59Coll@";-(Red ))
	//Else 
	//SET COLOR(*;"DE I59Coll@";-(Black ))
	//End if 
End if 

//End [Inspections].TunnelInspection.aI62aCollisionDamage