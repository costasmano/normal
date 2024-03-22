//%attributes = {"invisible":true}
//Method: ut_GetStructListsFromServer
//Description
// get the structure lists from a remote server.
// main use is to update a Development structure with lists from a prod server before deploying
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/06/17, 17:34:20
	// ----------------------------------------------------
	//Created :
	Mods_2017_10
End if 
C_BLOB:C604($Return_blb)
clone_ControlConnect
If (OK=1)
	ON ERR CALL:C155("SQL_ERROR")  //
	//ON ERR CALL("")
	Begin SQL
		SELECT {fn ut_StructListsToBlob() AS BLOB} FROM [Preferences] INTO :$Return_blb ;
	End SQL
	ON ERR CALL:C155("")
	SQL LOGOUT:C872
	ut_BlobToStructureLists($Return_blb)
End if 
SET BLOB SIZE:C606($Return_blb; 0)
//End ut_GetStructListsFromServer