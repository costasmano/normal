If (False:C215)
	Mods_2011_07  // CJ Miller`07/12/11, 13:58:56      `Modify how buttons get set so common code for all places
End if 
POPUPMENUC(->aI59LoadVibr; ->aCollisionCode; ->[Inspections:27]LoadVibration:15)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Inspections:27]LoadVibration:15)
End if 
C_BOOLEAN:C305($bNone)
$bNone:=(([Inspections:27]LoadVibration:15="N") | ([Inspections:27]LoadVibration:15="R") | ([Inspections:27]LoadVibration:15=""))
If ($bNone)
	If (Form event code:C388=On Clicked:K2:4)
		[Inspections:27]LoadVibSuper:100:=""
		PushChange(1; ->[Inspections:27]LoadVibSuper:100)
	End if 
	INSP_ResetButton($bNone; "DE I59Vibr"; [Inspections:27]LoadVibration:15; "R")
	//DISABLE BUTTON(*;"DE I59Vibr@")
Else 
	INSP_ResetButton($bNone; "DE I59Vibr"; [Inspections:27]LoadVibSuper:100; "R")
	//ENABLE BUTTON(*;"DE I59Vibr@")
	//If ([Inspections]LoadVibSuper="")
	//  `Alert user to enter text
	//SET COLOR(*;"DE I59Vibr@";-(Red ))
	//Else 
	//SET COLOR(*;"DE I59Vibr@";-(Black ))
	//End if 
End if 