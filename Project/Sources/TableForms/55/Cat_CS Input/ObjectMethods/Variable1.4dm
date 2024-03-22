//SC aNoteID on layout [Cat CS Notes];"Cat_CS Input".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_LONGINT:C283(vLastNoteID)

//TRACE

If (Form event code:C388=On Load:K2:1)
	If (vLastNoteID=0)
		vLastNoteID:=1
	End if 
	If ([Cat CS Notes:55]CS Note ID:2=0)
		aNoteID:=vLastNoteID
		[Cat CS Notes:55]CS Note ID:2:=aNoteID{aNoteID}
	Else 
		aNoteID:=Find in array:C230(aNoteID; [Cat CS Notes:55]CS Note ID:2)
		vLastNoteID:=aNoteID
	End if 
End if 

If (Form event code:C388=On Clicked:K2:4)
	[Cat CS Notes:55]CS Note ID:2:=aNoteID{aNoteID}
	vLastNoteID:=aNoteID
End if 