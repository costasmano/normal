If (False:C215)
	Mods_2011_07  // CJ Miller`07/12/11, 13:58:56      `Modify how buttons get set so common code for all places
End if 
POPUPMENUC(->aI59CollisionDamage; ->aCollisionCode; ->[Inspections:27]CollisionDamSup:13)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Inspections:27]CollisionDamSup:13)
End if 
C_BOOLEAN:C305($bNone)
$bNone:=(([Inspections:27]CollisionDamSup:13="N") | ([Inspections:27]CollisionDamSup:13=""))

If ($bNone)
	If (Form event code:C388=On Clicked:K2:4)
		[Inspections:27]CollisionSuper:98:=""
		PushChange(1; ->[Inspections:27]CollisionSuper:98)
	End if 
	//DISABLE BUTTON(*;"DE I59Coll@")
	INSP_ResetButton($bNone; "DE I59Coll"; [Inspections:27]CollisionDamSup:13)
Else 
	INSP_ResetButton($bNone; "DE I59Coll"; [Inspections:27]CollisionSuper:98)
	//ENABLE BUTTON(*;"DE I59Coll@")
	//If ([Inspections]CollisionSuper="")
	//  `Alert user to enter text
	//SET COLOR(*;"DE I59Coll@";-(Red ))
	//Else 
	//SET COLOR(*;"DE I59Coll@";-(Black ))
	//End if 
End if 

