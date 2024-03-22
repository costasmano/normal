//%attributes = {"invisible":true}
//Method: ut_GetUsersFromServer
//Description
// get the users and groups from a remote server and update the local structure

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/10/17, 10:09:43
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
End if 
//
C_BLOB:C604($Return_blb)

clone_ControlConnect
If (OK=1)
	ON ERR CALL:C155("SQL_ERROR")  //
	
	Begin SQL
		SELECT {fn ut_GetUsersToBlob() AS BLOB} FROM Preferences INTO :$Return_blb
	End SQL
	ON ERR CALL:C155("")
	SQL LOGOUT:C872
	
	If (BLOB size:C605($Return_blb)>0)
		//compare returnedblob size with local size 
		C_BLOB:C604($local_blb)
		USERS TO BLOB:C849($local_blb)
		CONFIRM:C162("Blob size from server :"+String:C10(BLOB size:C605($local_blb))+" . Local size :"+String:C10(BLOB size:C605($local_blb))+\
			". Update local with server?"; "Update"; "Cancel")
		If (ok=1)
			BLOB TO USERS:C850($Return_blb)
		End if 
		SET BLOB SIZE:C606($local_blb; 0)
		
	Else 
		ALERT:C41("No Users returned from server!")
	End if 
End if 
SET BLOB SIZE:C606($Return_blb; 0)

//End ut_GetUsersFromServer