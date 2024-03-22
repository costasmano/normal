//SC aElem: array in popup menu on layout [Cond Units];"Cond Units In".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_LONGINT:C283($Default)
C_BOOLEAN:C305($New)

//TRACE

REDRAW:C174(aElem)
$Default:=1  // Position of default.
$New:=False:C215  //The array has not been reset.
POPUP(->aElem; ->[Cond Units:45]Element ID:3; $Default; $New; ->aElemID)

If (Form event code:C388=On Clicked:K2:4)
	If ([Cond Units:45]Element ID:3#Old:C35([Cond Units:45]Element ID:3))
		PushChange(2; ->[Cond Units:45]Element ID:3)
	End if 
	SETUP_CSs
End if 