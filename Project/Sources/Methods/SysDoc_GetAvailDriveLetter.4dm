//%attributes = {"invisible":true}
//Method: SysDoc_GetAvailDriveLetter
//Description
// return the last available drive letter for windows excluding the ":" -Windows only
// Parameters
// $0 : $driveLetter
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Oct 6, 2022, 11:57:06
	Mods_2022_10
	// ----------------------------------------------------
	
	C_TEXT:C284(SysDoc_GetAvailDriveLetter; $0)
	
End if 
//
C_TEXT:C284($0; $driveLetter)

If (Is Windows:C1573)
	C_TEXT:C284($ResourceFolder_txt; $Document_txt; $search_txt)
	$ResourceFolder_txt:=Get 4D folder:C485(Current resources folder:K5:16)+"Utility"+Folder separator:K24:12+"DriveLetters.txt"
	$Document_txt:=Document to text:C1236($ResourceFolder_txt; Mac text without length:K22:10)
	ARRAY TEXT:C222($Letters_atxt; 0)
	ARRAY TEXT:C222($Volumes_atxt; 0)
	VOLUME LIST:C471($Volumes_atxt)
	ut_TextToArray($Document_txt; ->$Letters_atxt; ",")
	C_BOOLEAN:C305($Complete_B)
	C_LONGINT:C283($Loop_L; $Pos_L)
	For ($Loop_L; 1; Size of array:C274($Volumes_atxt))
		$search_txt:=Substring:C12($Volumes_atxt{$loop_L}; 1; Position:C15(":"; $Volumes_atxt{$loop_L})-1)
		
		$Pos_L:=Find in array:C230($Letters_atxt; $search_txt)
		If ($Pos_L>0)
			DELETE FROM ARRAY:C228($Letters_atxt; $Pos_l; 1)
		End if 
		
	End for 
	$driveLetter:=$Letters_atxt{Size of array:C274($Letters_atxt)}
End if 

$0:=$driveLetter
//End SysDoc_GetAvailDriveLetter   