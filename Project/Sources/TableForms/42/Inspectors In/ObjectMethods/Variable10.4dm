//SC aJob: array in popup menu on layout [Personnel];"Inspectors In".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

REDRAW:C174(aJob)
POPUPMENUC(->aJob; ->aJobCode; ->[Personnel:42]Job Code:8)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Personnel:42]Job Code:8)
End if 