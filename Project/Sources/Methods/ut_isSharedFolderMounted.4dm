//%attributes = {"invisible":true}
//Method: ut_isSharedFolderMounted
//Description
//
// Parameters
// $0 : $mounted_b
// $1 : $MountVolume_txt
// $2 : $CompletePath_txt
// $3 : $volumename_ptr
// $4 : text
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/08/19, 15:39:55
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
	Mods_2020_05  //Modified Ratings display so mount and movement can be from windows as well as macs
	//add return of drive letter on windows
	//Modified by: Chuck Miller (05/11/20 16:22:20)
	// Modified by: Costas Manousakis-(Designer)-(4/22/21 21:42:47)
	Mods_2021_04
	//  `on windows if we use ut_MountVolume, return the drive letter that was selected in $3
	// Modified by: Costas Manousakis-(Designer)-(2022-10-06 12:05:12)
	Mods_2022_10
	//  `use new methods  SysDoc_IsShareMounted, SysDoc_GetAvailDriveLetter. 
End if 
//

C_BOOLEAN:C305($0)
$0:=True:C214
C_TEXT:C284($1; $2; $Volume_txt; $MountVolume_txt; $CompletePath_txt)
C_POINTER:C301($3)
$CompletePath_txt:=$2
$MountVolume_txt:=$1
C_TEXT:C284($CurrentHandler_txt; $Letter_txt; $Document_txt; $ResourceFolder_txt; $search_txt; $Path_txt; $Return_txt)
$CurrentHandler_txt:=Method called on error:C704
ON ERR CALL:C155("MountError")
ARRAY TEXT:C222($Volumes_atxt; 0)
C_TEXT:C284($Script_txt)

If (Count parameters:C259>3)
	C_TEXT:C284($4)
	C_OBJECT:C1216($mountInfo_o)
	
	$mountInfo_o:=SysDoc_IsShareMounted($MountVolume_txt)
	
	If ($mountInfo_o.mounted)
		$3->:=$mountInfo_o.VolumeName  // return the volume name assigned by OS to be used with /Volumes/Volumename
		$0:=True:C214
	Else 
		//could not find match in result from mount 
		
		//need to mount the share
		If (Is macOS:C1572)
			$Return_txt:=ut_MountVolume($MountVolume_txt; ""; "")
			//mount volume opens a finder window - we'll try to close it
			$Script_txt:="tell application "+Char:C90(Double quote:K15:41)+"Finder"+Char:C90(Double quote:K15:41)+Char:C90(Carriage return:K15:38)
			$Script_txt:=$Script_txt+"close Finder window 1"+Char:C90(Carriage return:K15:38)
			$Script_txt:=$Script_txt+"end tell"+Char:C90(Carriage return:K15:38)
			$Script_txt:=ut_RunScript($Script_txt)
		Else 
			//for windows we need a drive letter 
			$Return_txt:=ut_MountVolume($MountVolume_txt; ""; ""; SysDoc_GetAvailDriveLetter)
			
		End if 
		
		//then get the volume name
		$mountInfo_o:=SysDoc_IsShareMounted($MountVolume_txt)
		
		If ($mountInfo_o.mounted)
			$3->:=$mountInfo_o.VolumeName  // return the volume name assigned by OS to be used with /Volumes/Volumename
			$0:=True:C214
			
		Else 
			//Still could not find the volume - some error
			$0:=False:C215
		End if 
	End if 
	
Else 
	
	VOLUME LIST:C471($Volumes_atxt)
	C_BOOLEAN:C305($Mounted_B)
	C_LONGINT:C283($Pos_L; $Loop_L)
	ARRAY TEXT:C222($parts_atxt; 0)
	ut_NewTextToArray($MountVolume_txt; ->$parts_atxt; "/")
	
	If (Is macOS:C1572)
		//Mac
		$Mounted_B:=False:C215
		$Pos_L:=Find in array:C230($Volumes_atxt; $parts_atxt{Size of array:C274($parts_atxt)})
		If ($Pos_L>0)
			ARRAY TEXT:C222($parts_atxt; 0)
			ut_NewTextToArray($CompletePath_txt; ->$parts_atxt; "/")
			$CompletePath_txt:=""
			$CompletePath_txt:=$parts_atxt{2}
			For ($Pos_L; 3; Size of array:C274($parts_atxt))
				$CompletePath_txt:=$CompletePath_txt+Folder separator:K24:12+$parts_atxt{$Pos_L}
				
			End for 
			If (Test path name:C476($CompletePath_txt)=Is a folder:K24:2)
				$Mounted_B:=True:C214
			End if 
		Else 
		End if 
		
	Else 
		//Windows
		$MountVolume_txt:=$parts_atxt{1}
		For ($Pos_L; 2; Size of array:C274($parts_atxt))
			$MountVolume_txt:=$MountVolume_txt+Folder separator:K24:12+$parts_atxt{$Pos_L}
			
		End for 
		$Path_txt:=ut_ReturnWindowsMountInfo($MountVolume_txt)
		
		If ($Path_txt="Not Mounted")
			$ResourceFolder_txt:=Get 4D folder:C485(Current resources folder:K5:16)+"Utility"+Folder separator:K24:12+"DriveLetters.txt"
			$Document_txt:=Document to text:C1236($ResourceFolder_txt; Mac text without length:K22:10)
			ARRAY TEXT:C222($Letters_atxt; 0)
			ut_TextToArray($Document_txt; ->$Letters_atxt; ",")
			C_BOOLEAN:C305($Complete_B)
			For ($Loop_L; 1; Size of array:C274($Volumes_atxt))
				$search_txt:=Substring:C12($Volumes_atxt{$loop_L}; 1; Position:C15(":"; $Volumes_atxt{$loop_L})-1)
				
				$Pos_L:=Find in array:C230($Letters_atxt; $search_txt)
				If ($Pos_L>0)
					DELETE FROM ARRAY:C228($Letters_atxt; $Pos_l; 1)
					
				End if 
				
			End for 
			$Letter_txt:=$Letters_atxt{Size of array:C274($Letters_atxt)}
			
		Else 
			$Mounted_B:=True:C214
		End if 
	End if 
	
	If ($Mounted_B)
		$3->:=$Path_txt
	Else 
		
		If (Is macOS:C1572)
			$Return_txt:=ut_MountVolume($MountVolume_txt; ""; "")
			
			$Script_txt:="tell application "+Char:C90(Double quote:K15:41)+"Finder"+Char:C90(Double quote:K15:41)+Char:C90(Carriage return:K15:38)
			$Script_txt:=$Script_txt+"close Finder window 1"+Char:C90(Carriage return:K15:38)
			$Script_txt:=$Script_txt+"end tell"+Char:C90(Carriage return:K15:38)
			
			$Script_txt:=ut_RunScript($Script_txt)
			
		Else 
			
			$Return_txt:=ut_MountVolume($MountVolume_txt; ""; ""; $Letter_txt)
			$3->:=$Letter_txt+":"  //Mods_2021_04
			
		End if 
		
		$0:=($Return_txt="Success")
	End if 
End if 


ON ERR CALL:C155($CurrentHandler_txt)

//End ut_isSharedFolderMounted