If (False:C215)
	Mods_2011_07  // CJ Miller`07/12/11, 13:58:56      `Modify how buttons get set so common code for all places
End if 
POPUPMENUC(->aScour; ->aCollisionCode; ->[Inspections:27]Scour:20)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Inspections:27]Scour:20)
End if 
C_BOOLEAN:C305($bNone)
$bNone:=(([Inspections:27]Scour:20="N") | ([Inspections:27]Scour:20=""))
If ($bNone)
	If (Form event code:C388=On Clicked:K2:4)
		[Inspections:27]ScourTxt:103:=""
		PushChange(1; ->[Inspections:27]ScourTxt:103)
	End if 
	//DISABLE BUTTON(*;"DE I60Scour@")
	INSP_ResetButton($bNone; "DE I60Scour"; [Inspections:27]Scour:20)
Else 
	INSP_ResetButton($bNone; "DE I60Scour"; [Inspections:27]ScourTxt:103)
	//ENABLE BUTTON(*;"DE I60Scour@")
	//If ([Inspections]ScourTxt="")
	//Alert user to enter text
	//SET COLOR(*;"DE I60Scour@";-(Red ))
	//Else 
	//SET COLOR(*;"DE I60Scour@";-(Black ))
	//End if 
End if 