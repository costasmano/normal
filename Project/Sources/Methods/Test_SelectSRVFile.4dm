//%attributes = {"invisible":true}
//Method: Test_SelectSRVFile
//Description
// Select a File trom the Resources
// Parameters
// $0 : Text : selected file name including subfolder
// $1 : Text : optional : prompt used in the selection dialog
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/18/17, 15:27:00
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
	
	C_TEXT:C284(Test_SelectSRVFile; $0)
	C_TEXT:C284(Test_SelectSRVFile; $1)
	
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($Prompt_txt)
$Prompt_txt:="Choose a file or directory to switch to"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Prompt_txt:=$1
End if 
ARRAY TEXT:C222($Files_atxt; 0)
ARRAY TEXT:C222($FolderTree_atxt; 0)
C_TEXT:C284($Path_txt; $FileName_txt)
//start with baase
Test_getResources(->$Files_atxt)
C_BOOLEAN:C305($Done_b)
$Done_b:=False:C215
C_LONGINT:C283($choise_L)
$Path_txt:=""
$FileName_txt:=""
Repeat 
	$choise_L:=G_PickFromList(->$Files_atxt; $Prompt_txt)
	Case of 
		: ($choise_L<=0)
			$done_b:=True:C214
		: ($Files_atxt{$choise_L}="..")  //need to go up
			DELETE FROM ARRAY:C228($FolderTree_atxt; Size of array:C274($FolderTree_atxt); 1)
			$Path_txt:=""
			If (Size of array:C274($FolderTree_atxt)>0)
				$Path_txt:=$FolderTree_atxt{1}
				For ($loop_L; 2; Size of array:C274($FolderTree_atxt))
					$Path_txt:=$Path_txt+$FolderTree_atxt{$loop_L}
				End for 
			End if 
			ARRAY TEXT:C222($Files_atxt; 0)
			Test_getResources(->$Files_atxt; $Path_txt)
			
		: (Substring:C12($Files_atxt{$choise_L}; Length:C16($Files_atxt{$choise_L}); 1)=<>PL_DirectorySep_s)
			//folder - get new list
			APPEND TO ARRAY:C911($FolderTree_atxt; $Files_atxt{$choise_L})
			C_LONGINT:C283($loop_L)
			$Path_txt:=$FolderTree_atxt{1}
			For ($loop_L; 2; Size of array:C274($FolderTree_atxt))
				$Path_txt:=$Path_txt+$FolderTree_atxt{$loop_L}
			End for 
			
			ARRAY TEXT:C222($Files_atxt; 0)
			Test_getResources(->$Files_atxt; $Path_txt)
			
		Else 
			//got a file
			$FileName_txt:=$Files_atxt{$choise_L}
			$done_b:=True:C214
	End case 
Until ($done_b)

$0:=$Path_txt+$FileName_txt

//End Test_SelectSRVFile