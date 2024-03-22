If (False:C215)
	Mods_2011_07  // CJ Miller`07/12/11, 13:58:56      `Modify how buttons get set so common code for all places
End if 
POPUPMENUC(->aI59LoadDefl; ->aCollisionCode; ->[Inspections:27]LoadDeflection:14)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Inspections:27]LoadDeflection:14)
End if 

C_BOOLEAN:C305($bNone)
$bNone:=(([Inspections:27]LoadDeflection:14="N") | ([Inspections:27]LoadDeflection:14="R") | ([Inspections:27]LoadDeflection:14=""))
If ($bNone)
	If (Form event code:C388=On Clicked:K2:4)
		[Inspections:27]LoadDeflSuper:99:=""
		PushChange(1; ->[Inspections:27]LoadDeflSuper:99)
	End if 
	INSP_ResetButton($bNone; "DE I59Defl"; [Inspections:27]LoadDeflection:14; "R")
	//If ([Inspections]LoadDeflection="R")
	//ENABLE BUTTON(*;"DE I59Defl@")
	//SET COLOR(*;"DE I59Defl@";-(Black ))
	//Else 
	//DISABLE BUTTON(*;"DE I59Defl@")
	//End if 
Else 
	INSP_ResetButton($bNone; "DE I59Defl"; [Inspections:27]LoadDeflSuper:99; "R")
	//ENABLE BUTTON(*;"DE I59Defl@")
	//If ([Inspections]LoadDeflSuper="")
	//  `Alert user to enter text
	//SET COLOR(*;"DE I59Defl@";-(Red ))
	//Else 
	//SET COLOR(*;"DE I59Defl@";-(Black ))
	//End if 
End if 

