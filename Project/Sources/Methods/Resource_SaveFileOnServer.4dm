//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Resource_SaveFileOnServer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/29/18, 14:53:24
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
	// Modified by: Costas Manousakis-(Designer)-(2/26/19 12:10:59)
	Mods_2019_02_bug
	//  `display message about file being saved
End if 
//

C_TEXT:C284($0)
C_BLOB:C604($1; $BlobToProcess_blb; $File_blb)
C_LONGINT:C283($Offset_L; $Compressed_L; $Loop_l)
C_BOOLEAN:C305($Complete_B)
4DError_b:=False:C215
ON ERR CALL:C155("4D_errors")
$Offset_L:=0
$BlobToProcess_blb:=$1
C_TEXT:C284($PathToResource_txt; $LocalPath_txt; $FinalPath_txt; $FileName_txt)
$PathToResource_txt:=Get 4D folder:C485(Current resources folder:K5:16)

BLOB PROPERTIES:C536($BlobToProcess_blb; $Compressed_L)
If ($Compressed_L#Is not compressed:K22:11)
	EXPAND BLOB:C535($BlobToProcess_blb)
End if 
$Complete_B:=False:C215
Repeat 
	BLOB TO VARIABLE:C533($BlobToProcess_blb; $LocalPath_txt; $Offset_L)
	If (OK=1)
		BLOB TO VARIABLE:C533($BlobToProcess_blb; $File_blb; $Offset_L)
		$FinalPath_txt:=$PathToResource_txt
		If (Position:C15(Folder separator:K24:12; $LocalPath_txt)=1)
			$LocalPath_txt:=Substring:C12($LocalPath_txt; 2)
			ARRAY TEXT:C222($Parts_atxt; 0)
			
			ut_NewTextToArray($LocalPath_txt; ->$Parts_atxt; Folder separator:K24:12)
			$FileName_txt:=$Parts_atxt{Size of array:C274($Parts_atxt)}
			For ($Loop_l; 1; Size of array:C274($Parts_atxt)-1)
				$FinalPath_txt:=$FinalPath_txt+$Parts_atxt{$Loop_l}
				If (Test path name:C476($FinalPath_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($FinalPath_txt)
					
				End if 
				$FinalPath_txt:=$FinalPath_txt+Folder separator:K24:12
			End for 
			$FinalPath_txt:=$FinalPath_txt+$FileName_txt
		Else 
			$FinalPath_txt:=$PathToResource_txt+$LocalPath_txt
			
		End if 
		ut_Message("File "+$FinalPath_txt+Char:C90(Carriage return:K15:38))
		BLOB TO DOCUMENT:C526($FinalPath_txt; $File_blb)
	End if 
Until (OK=0)
If (4DError_b)
Else 
	$0:=""
End if 

//End Resource_SaveFileOnServer