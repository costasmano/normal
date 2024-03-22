//%attributes = {"invisible":true,"executedOnServer":true}
//Method: SFA_getServerFileList
//Description
// get list of folders and files under a folder mounted on the server or local machine ; Execute on server = ON
// this assumes it is run on a Mac Platform
// Parameters
// $1 : $Full_pathtosearch_txt
// $2 : $Listarray_ptr
// $3 : $FileSearchOptions_L

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/30/17, 14:12:17
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	
	C_TEXT:C284(SFA_getServerFileList; $1)
	C_POINTER:C301(SFA_getServerFileList; $2)
	C_LONGINT:C283(SFA_getServerFileList; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(1/3/18 17:12:31)
	Mods_2018_01
	//  `added 3rd optional parameter to specify Document List options -
	//  //strip first char of a document if it is a folder separator
End if 

C_TEXT:C284($1; $Full_pathtosearch_txt)
C_POINTER:C301($2; $Listarray_ptr)
$Full_pathtosearch_txt:=$1  // path is expected to be in posix? using / for directory separator - path includes volume
$Listarray_ptr:=$2
C_LONGINT:C283($FileSearchOptions_L)
$FileSearchOptions_L:=Ignore invisible:K24:16
If (Count parameters:C259>2)
	C_LONGINT:C283($3)
	$FileSearchOptions_L:=$3
End if 

ARRAY TEXT:C222($Listarray_ptr->; 0)

ARRAY TEXT:C222($folders_atxt; 0)
ARRAY TEXT:C222($files_atxt; 0)
$Full_pathtosearch_txt:=Replace string:C233($Full_pathtosearch_txt; "/"; <>PL_DirectorySep_s)
//TRACE

If (Test path name:C476($Full_pathtosearch_txt)=Is a folder:K24:2)
	FOLDER LIST:C473($Full_pathtosearch_txt; $folders_atxt)
	DOCUMENT LIST:C474($Full_pathtosearch_txt; $files_atxt; $FileSearchOptions_L)
	
	C_LONGINT:C283($loop_L)
	
	For ($loop_L; 1; Size of array:C274($folders_atxt))
		APPEND TO ARRAY:C911($Listarray_ptr->; $folders_atxt{$loop_L}+"/")  //return folders using POSIX "/"
	End for 
	
	For ($loop_L; 1; Size of array:C274($files_atxt))
		//for files since we do recursive parsing replace dire separator with "/"
		//check if first char is a directory separator
		If (Substring:C12($files_atxt{$loop_L}; 1; 1)=<>PL_DirectorySep_s)
			$files_atxt{$loop_L}:=Substring:C12($files_atxt{$loop_L}; 2)  // skip 1st char
		End if 
		APPEND TO ARRAY:C911($Listarray_ptr->; Replace string:C233($files_atxt{$loop_L}; <>PL_DirectorySep_s; "/"))
	End for 
	
Else 
	//do we have the volume?
	C_LONGINT:C283($VolumeMark_L)
	C_TEXT:C284($VolName_txt)
	$VolumeMark_L:=Position:C15(<>PL_DirectorySep_s; $Full_pathtosearch_txt)
	If ($VolumeMark_L>0)
		$VolName_txt:=Substring:C12($Full_pathtosearch_txt; 1; ($VolumeMark_L-1))
		ARRAY TEXT:C222($Volumes_atxt; 0)
		VOLUME LIST:C471($Volumes_atxt)
		If (Find in array:C230($Volumes_atxt; $VolName_txt)>0)
			//have volume therefore the folder is not found!
			$Listarray_ptr->{0}:="Requested Folder <"+$1+"> Not Found!"
		Else 
			$Listarray_ptr->{0}:="Volume <"+$VolName_txt+">  Not Mounted!!"
			
		End if 
	Else 
		//if no volume name then it must be an invalid search path!
		$Listarray_ptr->{0}:="Invalid Search path <"+$1+">  !!"
	End if 
End if 

//End SFA_getServerFileList