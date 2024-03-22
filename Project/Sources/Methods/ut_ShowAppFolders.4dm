//%attributes = {"invisible":true}
//Method: ut_ShowAppFolders
//Description
//Show the folders used by the app currently using Get 4D folder and System folder
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/12, 09:19:30
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
	// Modified by: Costas Manousakis-(Designer)-(5/22/12 10:45:48)
	Mods_2012_05
	//  `Added all the system folder 
	// Modified by: Costas Manousakis-(Designer)-(2022-03-28 18:37:47)
	Mods_2022_03
	//  `modified to build a list and select folder to show on disk ;
End if 
//
C_TEXT:C284($FolderList_txt)
$FolderList_txt:="** 4D Folders"+Char:C90(13)
ARRAY TEXT:C222($Type_atxt; 0)
ARRAY TEXT:C222($Folders_atxt; 0)
APPEND TO ARRAY:C911($Type_atxt; "** 4D Folders")
APPEND TO ARRAY:C911($Folders_atxt; "")
APPEND TO ARRAY:C911($Type_atxt; "4D Client Database Folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(4D Client database folder:K5:13))
APPEND TO ARRAY:C911($Type_atxt; "Active 4D Folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(Active 4D Folder:K5:10))
APPEND TO ARRAY:C911($Type_atxt; "Current resources folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(Current resources folder:K5:16))
APPEND TO ARRAY:C911($Type_atxt; "Database folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(Database folder:K5:14))
APPEND TO ARRAY:C911($Type_atxt; "Database Folder Unix Syntax")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(Database folder UNIX syntax:K5:15))
//APPEND TO ARRAY($Type_atxt; "_o_Extras folder")
//APPEND TO ARRAY($Folders_atxt; Get 4D folder(_o_Extras folder))
APPEND TO ARRAY:C911($Type_atxt; "HTML Root folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(HTML Root folder:K5:20))
APPEND TO ARRAY:C911($Type_atxt; "Licenses folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(Licenses folder:K5:11))
APPEND TO ARRAY:C911($Type_atxt; "Logs folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(Logs folder:K5:19))
APPEND TO ARRAY:C911($Type_atxt; "MobileApps folder")
APPEND TO ARRAY:C911($Folders_atxt; Get 4D folder:C485(MobileApps folder:K5:47))

APPEND TO ARRAY:C911($Type_atxt; "** System Folders")
APPEND TO ARRAY:C911($Folders_atxt; "")
APPEND TO ARRAY:C911($Type_atxt; "User preferences_user")
APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(User preferences_user:K41:4))
APPEND TO ARRAY:C911($Type_atxt; "User preferences_all")
APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(User preferences_all:K41:3))
APPEND TO ARRAY:C911($Type_atxt; "Applications or program files")
APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Applications or program files:K41:17))
APPEND TO ARRAY:C911($Type_atxt; "Desktop")
APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Desktop:K41:16))
APPEND TO ARRAY:C911($Type_atxt; "Documents folder")
APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Documents folder:K41:18))
APPEND TO ARRAY:C911($Type_atxt; "System")
APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(System:K41:1))
APPEND TO ARRAY:C911($Type_atxt; "Fonts")
APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Fonts:K41:2))
APPEND TO ARRAY:C911($Type_atxt; "Temporary folder")
APPEND TO ARRAY:C911($Folders_atxt; Temporary folder:C486)

If (Is Windows:C1573)
	APPEND TO ARRAY:C911($Type_atxt; "** Windows only Folders")
	APPEND TO ARRAY:C911($Folders_atxt; "")
	APPEND TO ARRAY:C911($Type_atxt; "Favorites Win")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Favorites Win:K41:15))
	APPEND TO ARRAY:C911($Type_atxt; "Start menu Win_all")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Start menu Win_all:K41:9))
	APPEND TO ARRAY:C911($Type_atxt; "Start menu Win_user")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Start menu Win_user:K41:10))
	APPEND TO ARRAY:C911($Type_atxt; "Startup Win_all")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Startup Win_all:K41:5))
	APPEND TO ARRAY:C911($Type_atxt; "Startup Win_user")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Startup Win_user:K41:6))
	APPEND TO ARRAY:C911($Type_atxt; "Startup Win_user")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(Startup Win_user:K41:6))
	APPEND TO ARRAY:C911($Type_atxt; "System Win")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(System Win:K41:13))
	APPEND TO ARRAY:C911($Type_atxt; "System32 Win")
	APPEND TO ARRAY:C911($Folders_atxt; System folder:C487(System32 Win:K41:14))
End if 
//ut_BigAlert ($FolderList_txt)
//ut_BigAlert (ut_ArraysToText ("\t";->$Type_atxt;->$Folders_atxt))
ARRAY TEXT:C222($Choices_atxt; Size of array:C274($Type_atxt))
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($Type_atxt))
	$Choices_atxt{$loop_L}:=$Type_atxt{$loop_L}+" - "+$Folders_atxt{$loop_L}
End for 
C_LONGINT:C283($Choice_L)

$Choice_L:=G_PickFromList(->$Choices_atxt; "Choose a folder")
If ($Choice_L>0)
	If ($Folders_atxt{$Choice_L}#"")
		SHOW ON DISK:C922($Folders_atxt{$Choice_L})
	End if 
End if 

//End ut_ShowAppFolders