//SC aNote on layout [Cat CS Notes];"Cat_CS Input".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

C_LONGINT:C283(vLastNoteID)

If (Form event code:C388=On Clicked:K2:4)
	[Cat CS Notes:55]CS Note ID:2:=aNoteID{aNoteID}
	vLastNoteID:=aNoteID
End if 