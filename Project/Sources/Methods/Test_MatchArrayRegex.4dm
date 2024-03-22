//%attributes = {"invisible":true}
//Method: Test_MatchArrayRegex
//Description
//"mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present/A02 Acton/A02023_25B/A02023-25B y0382.pdf"
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/10/18, 10:38:15
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
End if 
//
C_TEXT:C284($targetFile_txt)
C_TEXT:C284($stdin_x; $stdout_x; $stderr_x; $ExtraFile_txt)
C_TEXT:C284($vbs_out_t; $Volume_txt; $VolumeName_txt; $basePath_txt; $BasePattern_txt; $targetFile_txt; $TrimPath_txt; $openFile_txt)
$basePath_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")

$targetFile_txt:="mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present/A02 Acton/A02023_25B/A02023-25B y0382.pdf"

$ExtraFile_txt:=Replace string:C233($targetFile_txt; $basePath_txt; "")

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
	$targetPath_txt:=$targetPath_txt+$ExtraFile_txt
	OPEN URL:C673("file:///"+$targetPath_txt)
	
End if 

//End Test_MatchArrayRegex
