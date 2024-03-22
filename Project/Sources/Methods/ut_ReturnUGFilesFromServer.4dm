//%attributes = {"invisible":true,"executedOnServer":true}
//Method: ut_ReturnUGFilesFromServer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/13/21, 14:49:18
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04  //Added code to allow for selected of previously saved Users and Group File
	//Modified by: CJ (4/13/21 15:57:01)
End if 
//

C_BLOB:C604($Blob_blb; $0)
C_TEXT:C284($Folder_txt)
C_LONGINT:C283($Size_L)
$Folder_txt:=Data file:C490
C_LONGINT:C283($Loop_l)

For ($Loop_l; Length:C16($Folder_txt); 1; -1)
	If ($Folder_txt[[$Loop_l]]=Folder separator:K24:12)
		$Folder_txt:=Substring:C12($Folder_txt; 1; $Loop_l)
		$Loop_l:=0
	End if 
	
End for 
$Folder_txt:=$Folder_txt+"UsersandGroups"
ARRAY TEXT:C222($Files_atxt; 0)
DOCUMENT LIST:C474($Folder_txt; $Files_atxt; Ignore invisible:K24:16)
ARRAY DATE:C224($created_ad; 0)
ARRAY TIME:C1223($created_atm; 0)
$Size_L:=Size of array:C274($Files_atxt)
ARRAY DATE:C224($created_ad; $Size_L)
ARRAY TIME:C1223($created_atm; $Size_L)
$Folder_txt:=$Folder_txt+Folder separator:K24:12
C_BOOLEAN:C305($Locked_B; $Invisible_B)
C_DATE:C307($Mod_d)
C_TIME:C306($mod_tm)
For ($Loop_l; 1; $Size_L)
	GET DOCUMENT PROPERTIES:C477($Folder_txt+$Files_atxt{$Loop_l}; $Locked_B; $Invisible_B; $created_ad{$Loop_l}; $created_atm{$Loop_L}; $Mod_d; $mod_tm)
End for 
MULTI SORT ARRAY:C718($created_ad; <; $created_atm; <; $Files_atxt)
VARIABLE TO BLOB:C532($Folder_txt; $Blob_blb; *)
VARIABLE TO BLOB:C532($Files_atxt; $Blob_blb; *)
VARIABLE TO BLOB:C532($created_ad; $Blob_blb; *)
VARIABLE TO BLOB:C532($created_atm; $Blob_blb; *)
$0:=$Blob_blb

//End ut_ReturnUGFilesFromServer