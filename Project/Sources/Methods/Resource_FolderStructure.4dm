//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Resource_FolderStructure
//Description
//This method will witgher check or create folder structure in resource folder on servcer
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/06/19, 11:40:39
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
C_BOOLEAN:C305($0; $ReturnValue_B)

C_TEXT:C284($1; $2; $Task_txt; $Path_txt; $ResourcePath_txt)
$Task_txt:=$1
$Path_txt:=$2
ARRAY TEXT:C222($parts_atxt; 0)
ut_NewTextToArray($Path_txt; ->$parts_atxt; Folder separator:K24:12)
$ResourcePath_txt:=Get 4D folder:C485(Current resources folder:K5:16)
$ReturnValue_B:=True:C214
C_LONGINT:C283($Loop_L)
4D_Error_B:=False:C215
Case of 
	: ($Task_txt="Check")
		For ($Loop_L; 1; Size of array:C274($parts_atxt))
			$ResourcePath_txt:=$ResourcePath_txt+$parts_atxt{$Loop_L}
			If (Test path name:C476($ResourcePath_txt)=Is a folder:K24:2)
				$ResourcePath_txt:=$ResourcePath_txt+Folder separator:K24:12
			Else 
				$ReturnValue_B:=False:C215
			End if 
		End for 
	: ($Task_txt="Create")
		ON ERR CALL:C155("Resource_Error")
		For ($Loop_L; 1; Size of array:C274($parts_atxt))
			If ($parts_atxt{$Loop_L}="")
			Else 
				$ResourcePath_txt:=$ResourcePath_txt+$parts_atxt{$Loop_L}
				If (Test path name:C476($ResourcePath_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($ResourcePath_txt)
				End if 
				$ResourcePath_txt:=$ResourcePath_txt+Folder separator:K24:12
				$ReturnValue_B:=Not:C34(4D_Error_B)
			End if 
		End for 
End case 
$0:=$ReturnValue_B
//End Resource_FolderStructure