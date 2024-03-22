//%attributes = {"invisible":true,"publishedSql":true}
//Method: ut_GetUsersToBlob
//Description
// Return in a blob the users. Mainly for calls via SQL connection
// attribute : available through SQL = true
// Parameters
// $0 : $UsersAndGroups_blob
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/06/17, 16:15:08
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
	
	C_BLOB:C604(ut_GetUsersToBlob; $0)
End if 
//

C_BLOB:C604($0; $UsersAndGroups_blob)

USERS TO BLOB:C849($UsersAndGroups_blob)

$0:=$UsersAndGroups_blob
//End ut_GetUsersToBlob