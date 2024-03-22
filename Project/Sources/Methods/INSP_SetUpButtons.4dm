//%attributes = {"invisible":true}
// ----------------------------------------------------
// INSP_SetUpButtons
// User name (OS): charlesmiller
// Date and time: 07/13/11, 10:30:17
// ----------------------------------------------------
// Description
// This method will set up buttons on load phase for the following forms
//[Inspections];"Culvert Combined"  `page 3
//[Inspections];"RailRoutineInput"  `page 2
//[Inspections];"Routine Combined"  `page 2
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_07  // CJ Miller`07/13/11, 10:30:19      ` Modify how buttons get set so common code for all places
	Mods_2013_09  //r001 ` 
	//Modified by: Charles Miller (9/24/13 14:15:00)
	//Add fields to [TunnelInspection] to track 
	//Structural Collision Damage
	//[TunnelInspection]StructuralCollisionValue_s
	//[TunnelInspection]StructuralCollisionComments_txt
	//Roadway collision damage
	//[TunnelInspection]RoadwayCollisionValue_s
	//[TunnelInspection]RoadwayCollisionComments_txt
End if 
If (([Inspections:27]LoadVibration:15#"N") & ([Inspections:27]LoadVibration:15#""))
	OBJECT SET ENABLED:C1123(*; "DE I59Vib@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "DE I59Vib@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
If ([Inspections:27]UnderMining:19)
	OBJECT SET ENABLED:C1123(*; "DE I60Under@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "DE I60Under@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
If (([Inspections:27]CollisionDamSup:13#"N") & ([Inspections:27]CollisionDamSup:13#""))
	OBJECT SET ENABLED:C1123(*; "DE I59Coll@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "DE I59Coll@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
If (([TunnelInspection:152]StructuralCollisionValue_s:27#"N") & ([TunnelInspection:152]StructuralCollisionValue_s:27#""))
	OBJECT SET ENABLED:C1123(*; "DE I62aCollision@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "DE I62aCollision@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
If (([TunnelInspection:152]RoadwayCollisionValue_s:29#"N") & ([TunnelInspection:152]RoadwayCollisionValue_s:29#""))
	OBJECT SET ENABLED:C1123(*; "DE I62bColl@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "DE I62bColl@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
If ([Inspections:27]Insp Type:6#"CUL")
	
	If (([Inspections:27]LoadDeflection:14#"N") & ([Inspections:27]LoadDeflection:14#""))
		OBJECT SET ENABLED:C1123(*; "DE I59Defl@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(*; "DE I59Defl@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End if 
	
	If (([Inspections:27]CollisionDamSub:18#"N") & ([Inspections:27]CollisionDamSub:18#""))
		OBJECT SET ENABLED:C1123(*; "DE I60Coll@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(*; "DE I60Coll@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End if 
	If (([Inspections:27]Scour:20#"N") & ([Inspections:27]Scour:20#""))
		OBJECT SET ENABLED:C1123(*; "DE I60Scour@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(*; "DE I60Scour@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End if 
End if 



//End INSP_SetUpButtons