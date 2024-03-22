//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_SaveUsersAndGroups
// User name (OS): charlesmiller
// Date and time: 04/24/09, 15:06:31
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r002  `04/24/09, 15:06:32 `Add methods to store and retieve users and groups on server startup and shutdown
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_TEXT:C284($Folder_txt; $FileName_txt)
$Folder_txt:=ut_ReturnFolderOfDataFile

$Folder_txt:=$Folder_txt+"UsersAndGroups"

If (Test path name:C476($Folder_txt)=Is a folder:K24:2)
	
Else 
	CREATE FOLDER:C475($Folder_txt)
End if 
$Folder_txt:=$Folder_txt+":"  // we are always on a mac
$FileName_txt:=Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*)); 1; 14)+"Users_Groups"
C_BLOB:C604($Blob_blb)
USERS TO BLOB:C849($Blob_blb)
$Folder_txt:=$Folder_txt+$FileName_txt
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266($Folder_txt)
CLOSE DOCUMENT:C267($Doc_tm)
BLOB TO DOCUMENT:C526($Folder_txt; $Blob_blb)

SET BLOB SIZE:C606($Blob_blb; 0)

//End ut_SaveUsersAndGroups