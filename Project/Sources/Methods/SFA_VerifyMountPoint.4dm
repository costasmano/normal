//%attributes = {"invisible":true}
//Method: SFA_VerifyMountPoint
//Description
// verify existance of a mount point for shared file access. 
// will return the path to be used in the local machine to access the needed files
// will attempt to mount if mount point not found
// Parameters
// $0 : $TargetPath_txt
// $1 : $BasePath_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/12/19, 11:09:51
	// ----------------------------------------------------
	//Created : 
	Mods_2019_11_bug
	
	C_TEXT:C284(SFA_VerifyMountPoint; $0)
	C_TEXT:C284(SFA_VerifyMountPoint; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(9/4/20 17:53:29)
	Mods_2020_09_bug
	//  `Fixed arguments when calling the mountscript - needed to add {3} in arg2 to match arg1
End if 
//

C_TEXT:C284($0; $1)
C_TEXT:C284($targetPath_txt; $basePath_txt)
$basePath_txt:=$1
$targetPath_txt:=""

C_TEXT:C284($stdin_x; $stdout_x; $stderr_x; $ExtraFile_txt)
C_TEXT:C284($Volume_txt; $VolumeName_txt; $BasePattern_txt; $targetFile_txt; $TrimPath_txt; $openFile_txt)

ARRAY TEXT:C222($basePaths_atxt; 0)
ut_NewTextToArray($basePath_txt; ->$basePaths_atxt; "/")
//$BasePattern_txt:=$basePaths_atxt{1}+"/"+$basePaths_atxt{2}
C_TEXT:C284($BasePattern_txt)
$BasePattern_txt:="\\/\\/(.*)@"+$basePaths_atxt{1}+"(.*)\\/"+$basePaths_atxt{2}+"(\\$*\\/*)(.*) on \\/Volumes\\/(.*) \\("

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
LAUNCH EXTERNAL PROCESS:C811("mount"; $stdin_x; $stdout_x; $stderr_x)
//$vbs_out_t:=Convert to text($stdout_x;"UTF-16LE")
ARRAY TEXT:C222($lines_atxt; 0)
ut_NewTextToArray($stdout_x; ->$lines_atxt; Char:C90(10))
C_LONGINT:C283($myvol_L; $StartVol_L; $EndVol_L; $loop_L)
ARRAY POINTER:C280($test_aptr; 20)
ARRAY TEXT:C222($zero_atxt; 0)
C_BOOLEAN:C305($done_b; $foundIt_b)
$done_b:=False:C215
$foundIt_b:=False:C215
$myvol_L:=MatchArrayRegex(->$lines_atxt; $BasePattern_txt)
Repeat 
	If ($myvol_L>0)
		//get the parts
		ARRAY LONGINT:C221($StartPos_aL; 0)
		ARRAY LONGINT:C221($Lengths_aL; 0)
		C_BOOLEAN:C305($match_b)
		$match_b:=Match regex:C1019($BasePattern_txt; $lines_atxt{$myvol_L}; 1; $StartPos_aL; $Lengths_aL)
		C_TEXT:C284($user_txt; $DNS_txt; $shareddatapath_txt; $VolumeName_txt)
		$user_txt:=Substring:C12($lines_atxt{$myvol_L}; $StartPos_aL{1}; $Lengths_aL{1})
		$DNS_txt:=Substring:C12($lines_atxt{$myvol_L}; $StartPos_aL{2}; $Lengths_aL{2})
		$shareddatapath_txt:=Substring:C12($lines_atxt{$myvol_L}; $StartPos_aL{4}; $Lengths_aL{4})
		$VolumeName_txt:=Substring:C12($lines_atxt{$myvol_L}; $StartPos_aL{5}; $Lengths_aL{5})
		
		//ALERT($lines_atxt{$myvol_L}+"\r"+"User : "+$user_txt+"\r "+"Extra DNS : "+$DNS_txt+"\r "+"Shareddata path : "+$shareddatapath_txt+"\r "+"Volume name : "+$VolumeName_txt)\
			
		ARRAY TEXT:C222($SharedPaths_atxt; 0)
		ut_NewTextToArray($shareddatapath_txt; ->$SharedPaths_atxt; "/")
		C_LONGINT:C283($ploop_L; $StartMatch_L)
		$StartMatch_L:=3
		If (Size of array:C274($SharedPaths_atxt)>0)
			
			If ($SharedPaths_atxt{1}="")
				DELETE FROM ARRAY:C228($SharedPaths_atxt; 1; 1)  //delete the first one if it is blank
			End if 
			
		End if 
		For ($ploop_L; 1; Size of array:C274($SharedPaths_atxt))
			If ($SharedPaths_atxt{$ploop_L}#$basePaths_atxt{$StartMatch_L})
				//exit and bad
				$StartMatch_L:=-1
				$ploop_L:=Size of array:C274($SharedPaths_atxt)+1
			Else 
				//keep checking
				$StartMatch_L:=$StartMatch_L+1
			End if 
		End for 
		
		If ($StartMatch_L>0)
			//Found it
			$foundIt_b:=True:C214
			$done_b:=True:C214
			//$VolumeName_txt:=Substring($lines_atxt{$myvol_L};$StartPos_aL{4};$Lengths_aL{4})
			
		Else 
			//check the next one
			$myvol_L:=MatchArrayRegex(->$lines_atxt; $BasePattern_txt; ($myvol_L+1))
			
		End if 
		
	Else 
		$done_b:=True:C214
	End if 
	
Until ($done_b)

If ($foundIt_b)
	//build needed path with volume
	// add to the volume name the parts of base path starting from where match ended $StartMatch_L
	C_LONGINT:C283($loop_L)
	C_TEXT:C284($targetPath_txt)
	$targetPath_txt:="/Volumes/"+$VolumeName_txt
	For ($loop_L; $StartMatch_L; Size of array:C274($basePaths_atxt))
		$targetPath_txt:=$targetPath_txt+"/"+$basePaths_atxt{$loop_L}
	End for 
	$targetPath_txt:=$targetPath_txt
Else 
	//volume not mounted locally - try to mount it 
	C_TEXT:C284($mymountapp_txt)
	$mymountapp_txt:=Get 4D folder:C485(Current resources folder:K5:16)+"Utility"+Folder separator:K24:12+"mountBoston.scpt"
	If (Test path name:C476($mymountapp_txt)=Is a document:K24:1)
		C_TEXT:C284($in_txt; $out_txt; $err_txt)
		//$err_txt:=ut_runApplescript ($mymountapp_txt+" "+<>sQU+"Boston"+<>sQU+" "+<>sQU+"smb://mhd-shared/shareddata/Boston"+<>sQU)
		
		C_TEXT:C284($script_file_path_txt; $path_system_txt; $target_volume_txt; $system_folder_txt; $boot_volume_txt; $standard_output_txt)
		
		$script_file_path_txt:=Replace string:C233($mymountapp_txt; "/"; ":"; *)
		
		If (Test path name:C476($script_file_path_txt)=Is a document:K24:1)
			
			ALERT:C41("Required Shared drive not mounted on your computer. Will attempt to connect to it. If prompted, enter your Windows username and password.")
			
			$path_system_txt:=Replace string:C233($script_file_path_txt; ":"; "/"; *)  //the POSIX separator
			$target_volume_txt:=Substring:C12($path_system_txt; 1; Position:C15("/"; $path_system_txt; *)-1)
			$system_folder_txt:=System folder:C487(System:K41:1)  // take care of the/Volumes/syntax
			$boot_volume_txt:=Substring:C12($system_folder_txt; 1; Position:C15(":"; $system_folder_txt; *)-1)
			$script_file_path_txt:=Choose:C955($boot_volume_txt=$target_volume_txt; Substring:C12($path_system_txt; Position:C15("/"; $path_system_txt; *)); "/Volumes/"+$path_system_txt)
			
			C_BLOB:C604($standard_input_x; $standard_output_x; $standard_error_x)
			
			LAUNCH EXTERNAL PROCESS:C811("osascript \""+$script_file_path_txt+"\""+\
				" \""+$basePaths_atxt{3}+"\" \"smb://"+$basePaths_atxt{1}+"/"+$basePaths_atxt{2}+"/"+$basePaths_atxt{3})
			
			// check to see if Boston mounted ok - cant' rely on error messages from 
			ARRAY TEXT:C222($Volumes_atxt; 0)
			VOLUME LIST:C471($Volumes_atxt)
			
			If (Find in array:C230($Volumes_atxt; $basePaths_atxt{3})>0)
				//ALERT("Volume Boston mounted correctly. Please try searching for scanned ratings again")
				
				$targetPath_txt:="/Volumes/"+$basePaths_atxt{3}
				For ($loop_L; 4; Size of array:C274($basePaths_atxt))
					$targetPath_txt:=$targetPath_txt+"/"+$basePaths_atxt{$loop_L}
				End for 
				$targetPath_txt:=$targetPath_txt
				
			Else 
				//ALERT("There was an Error mounting the required shared volume")
			End if 
			
		End if 
		
	Else 
		ALERT:C41("Macro to mount the missing shared drive not found in the Resources. Please connect manually to server smb://mhd-shared/shareddata/Boston")
	End if 
End if 

$0:=$targetPath_txt

//End SFA_VerifyMountPoint