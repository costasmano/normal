If (False:C215)
	Mods_2011_07  // CJ Miller`07/12/11, 13:58:56      `Modify how buttons get set so common code for all places
End if 
POPUPMENUC(->aCollisionDamage; ->aCollisionCode; ->[Inspections:27]CollisionDamSub:18)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Inspections:27]CollisionDamSub:18)
End if 
C_BOOLEAN:C305($bNone)
$bNone:=(([Inspections:27]CollisionDamSub:18="N") | ([Inspections:27]CollisionDamSub:18=""))
If ($bNone)
	If (Form event code:C388=On Clicked:K2:4)
		[Inspections:27]CollisionSub:101:=""
		PushChange(1; ->[Inspections:27]CollisionSub:101)
	End if 
	//DISABLE BUTTON(*;"DE I60Coll@")
	INSP_ResetButton($bNone; "DE I60Coll"; [Inspections:27]CollisionDamSub:18)
Else 
	INSP_ResetButton($bNone; "DE I60Coll"; [Inspections:27]CollisionSub:101)
	//ENABLE BUTTON(*;"DE I60Coll@")
	//If ([Inspections]CollisionSub="")
	//  `Alert user to enter text
	//SET COLOR(*;"DE I60Coll@";-(Red ))
	//Else 
	//SET COLOR(*;"DE I60Coll@";-(Black ))
	//End if 
End if 
