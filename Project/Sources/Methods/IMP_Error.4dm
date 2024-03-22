//%attributes = {"invisible":true}
//GP IMP_Error
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
//Error procedure for Pontis Data Importing.
//Called by ON ERR CALL.

Case of 
	: (Error=-43)
		//File not found.
		//This is not an error; it indicates there are no more files to process.
	Else 
		CONFIRM:C162("Error #"+String:C10(Error)+".  Do you want to stop?")
		If (OK=1)
			ABORT:C156
		End if 
End case 