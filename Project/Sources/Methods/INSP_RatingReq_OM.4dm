//%attributes = {"invisible":true}
//Method: INSP_RatingReq_OM
//Description
// method for Rating request checkbox in bridge inspection input forms
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:31:18
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12_bug
End if 
//

If ([Inspections:27]Rerating:75=True:C214)
	OBJECT SET ENABLED:C1123(x1; True:C214)  // **replaced _ o _ENABLE BUTTON(x1)
	OBJECT SET ENABLED:C1123(x2; True:C214)  // **replaced _ o _ENABLE BUTTON(x2)
	OBJECT SET ENABLED:C1123(x3; True:C214)  // **replaced _ o _ENABLE BUTTON(x3)
Else 
	x1:=0
	x2:=0
	x3:=0
	[Inspections:27]RatingPriority:85:=""
	PushChange(1; ->[Inspections:27]RatingPriority:85)
	OBJECT SET ENABLED:C1123(x1; False:C215)  // **replaced _ o _DISABLE BUTTON(x1)
	OBJECT SET ENABLED:C1123(x2; False:C215)  // **replaced _ o _DISABLE BUTTON(x2)
	OBJECT SET ENABLED:C1123(x3; False:C215)  // **replaced _ o _DISABLE BUTTON(x3)
End if 
PushChange(1; Self:C308)

//End INSP_RatingReq_OM