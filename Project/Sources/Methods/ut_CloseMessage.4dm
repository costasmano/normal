//%attributes = {"invisible":true}
If (False:C215)
	//ut_CloseMessage
	//Close the Message output : either the current window or
	// an open document.
	//Uses process variables vbOnScreenMessage and
	//vfMessageDocRef.
	//usage:
	//ut_CloseMessage 
End if 

C_TIME:C306(vfMessageDocRef)
C_BOOLEAN:C305(vbOnScreenMessage; vbToFileMessage)
If (vbOnScreenMessage)
	//screen window
	CLOSE WINDOW:C154
End if 
If (vbToFileMessage)
	CLOSE DOCUMENT:C267(vfMessageDocRef)
End if 
CLEAR VARIABLE:C89(vbOnScreenMessage)
CLEAR VARIABLE:C89(vbToFileMessage)
CLEAR VARIABLE:C89(vfMessageDocRef)