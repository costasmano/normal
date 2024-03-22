
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/28/11, 16:09:58
//----------------------------------------------------
//Method: Object Method: CloneTables.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 


clone_Table
CONFIRM:C162("Close all clone Progress bars"; "Yes"; "No")
If (OK=1)
	Progress QUIT(0)
End if 
CONFIRM:C162("Process another table"; "Yes"; "No")

If (OK=1)
	
Else 
	CANCEL:C270
End if 


//End Object Method: CloneTables.Button1

