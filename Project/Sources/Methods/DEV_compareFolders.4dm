//%attributes = {"invisible":true}
//Method: DEV_compareFolders
//Description
// compare contents of two folders
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/26/18, 16:55:02
	// ----------------------------------------------------
	//Created : 
	
	Mods_2018_11
	// Modified by: Costas Manousakis-(Designer)-(2022-06-13 10:56:41)
	Mods_2022_06
	//  `moved start progress bar after choosing the folders; added message getting directories
End if 
//

C_TEXT:C284($rootfolder_1_txt; $rootfolder_2_txt)
ARRAY TEXT:C222($rootfolder_1_atxt; 0)
ARRAY TEXT:C222($rootfolder_2_atxt; 0)
ARRAY TEXT:C222($Errors_atxt; 0)

$rootfolder_1_txt:=Select folder:C670("Choose first folder for comparison"; 1)  //remember the path as #1

$rootfolder_2_txt:=Select folder:C670("Choose second folder for comparison"; 2)  //remember the path as #2

//start the bar
C_OBJECT:C1216($progress_o)
$progress_o:=ProgressNew("Comparing folder contents"; Size of array:C274($rootfolder_1_atxt); True:C214; " files"; 3)

Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Loading dir "+$rootfolder_1_txt)
DOCUMENT LIST:C474($rootfolder_1_txt; $rootfolder_1_atxt; Recursive parsing:K24:13+Ignore invisible:K24:16)

Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Loading dir "+$rootfolder_2_txt)
DOCUMENT LIST:C474($rootfolder_2_txt; $rootfolder_2_atxt; Recursive parsing:K24:13+Ignore invisible:K24:16)

C_TEXT:C284($Digest1_txt; $digest2_txt)

C_LONGINT:C283($loop_L; $In_2_L; $in_1_L)
C_BLOB:C604($file_blb)
C_BOOLEAN:C305($locked_b; $invis_b)
C_DATE:C307($create_d; $mod_d)
C_TIME:C306($create_t; $mod_t)

Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Preparing arrays")

//remove beginning folder separators if any - they are added from the rootfolder
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($rootfolder_1_atxt))
	If (Substring:C12($rootfolder_1_atxt{$loop_L}; 1; 1)=Folder separator:K24:12)
		$rootfolder_1_atxt{$loop_L}:=Substring:C12($rootfolder_1_atxt{$loop_L}; 2)
	End if 
End for 
For ($loop_L; 1; Size of array:C274($rootfolder_2_atxt))
	If (Substring:C12($rootfolder_2_atxt{$loop_L}; 1; 1)=Folder separator:K24:12)
		$rootfolder_2_atxt{$loop_L}:=Substring:C12($rootfolder_2_atxt{$loop_L}; 2)
	End if 
End for 

$progress_o.StartMS:=Milliseconds:C459
$progress_o.total:=Size of array:C274($rootfolder_1_atxt)

For ($loop_L; 1; Size of array:C274($rootfolder_1_atxt))
	//update progress
	UpdateProgressNew($progress_o; $loop_L)
	
	$In_2_L:=Find in array:C230($rootfolder_2_atxt; $rootfolder_1_atxt{$loop_L})
	If ($In_2_L>0)
		//compare the two
		//check size first
		If (Get document size:C479($rootfolder_1_txt+$rootfolder_1_atxt{$loop_L})#Get document size:C479($rootfolder_2_txt+$rootfolder_2_atxt{$In_2_L}))
			APPEND TO ARRAY:C911($Errors_atxt; $rootfolder_1_atxt{$loop_L}+Char:C90(Tab:K15:37)+"Not same size")
			
		Else 
			DOCUMENT TO BLOB:C525($rootfolder_1_txt+$rootfolder_1_atxt{$loop_L}; $file_blb)
			$Digest1_txt:=Generate digest:C1147($file_blb; MD5 digest:K66:1)
			DOCUMENT TO BLOB:C525($rootfolder_2_txt+$rootfolder_2_atxt{$In_2_L}; $file_blb)
			$Digest2_txt:=Generate digest:C1147($file_blb; MD5 digest:K66:1)
			
			If ($Digest1_txt=$Digest2_txt)
				//match
			Else 
				APPEND TO ARRAY:C911($Errors_atxt; $rootfolder_1_atxt{$loop_L}+Char:C90(Tab:K15:37)+"Content is different")
			End if 
			
		End if 
		//remove it from the list of folder 2
		DELETE FROM ARRAY:C228($rootfolder_2_atxt; $In_2_L)
	Else 
		//not found in 2
		APPEND TO ARRAY:C911($Errors_atxt; $rootfolder_1_atxt{$loop_L}+Char:C90(Tab:K15:37)+"Not found in folder "+$rootfolder_2_txt)
	End if 
	
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
		//abort loop
		$loop_L:=Size of array:C274($rootfolder_1_atxt)+1
		ARRAY TEXT:C222($rootfolder_2_atxt; 0)
	End if 
	
End for 

Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Cleanup")

For ($loop_L; 1; Size of array:C274($rootfolder_2_atxt))
	
	//not found in 1
	APPEND TO ARRAY:C911($Errors_atxt; $rootfolder_2_atxt{$loop_L}+Char:C90(Tab:K15:37)+"Not found in folder "+$rootfolder_1_txt)
	
End for 

//quit progress
Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))

ut_DisplayArray(->$Errors_atxt; "Comparing "+$rootfolder_1_txt+" with "+$rootfolder_2_txt; "Error Message")

//End DEV_compareFolders