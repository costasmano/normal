//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Server_SaveDocToResourceFolder
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/06/19, 13:17:15
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
TRACE:C157

C_BOOLEAN:C305($0)
C_BOOLEAN:C305(4D_Error_B)
4D_Error_B:=False:C215
ON ERR CALL:C155("Resource_Error")
C_TEXT:C284($1; $Path_txt; $2; $Name_txt; $PathToResource_txt)
$Path_txt:=$1
$Name_txt:=$2
C_BLOB:C604($3; $Document_blb)

$Document_blb:=$3
C_LONGINT:C283($Loop_L)
ARRAY TEXT:C222($Parts_atxt; 0)
If (Resource_FolderStructure("Create"; $Path_txt))
	$PathToResource_txt:=Get 4D folder:C485(Current resources folder:K5:16)
	If ($Path_txt="")
	Else 
		ut_NewTextToArray($Path_txt; ->$Parts_atxt; Folder separator:K24:12)
		
		For ($Loop_L; 1; Size of array:C274($Parts_atxt))
			$PathToResource_txt:=$PathToResource_txt+$Parts_atxt{$Loop_L}+Folder separator:K24:12
		End for 
	End if 
	BLOB TO DOCUMENT:C526($PathToResource_txt+$Name_txt; $Document_blb)
End if 
$0:=Not:C34(4D_Error_B)
//End Server_SaveDocToResourceFolder