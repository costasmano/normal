//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/11, 08:41:23
	// ----------------------------------------------------
	// Method: ut_HFS_to_POSIX
	// Description
	//  ` Convert a Mac HFS path to a POSIX path
	// 
	// Parameters
	// $0 : $PosixPath_txt
	// $1 : $HFSPath_txt
	// ----------------------------------------------------
	
	Mods_2011_03
	// Modified by: Costas Manousakis-(Designer)-(4/17/20 17:34:06)
	Mods_2020_04
	//  `fixed to use Convert path system to POSIX and then escape other characters.
	//  `the : is escaped because Convert changes / to : , ex 4/17/20 -> 4:17:20
	//  `/Volumes/ does not need to be prefixed to the result  - CallReference #709
	//  `metachar code taken from Nug
End if 
C_TEXT:C284($0; $PosixPath_txt)
C_TEXT:C284($1; $HFSPath_txt; $metacharacters; $metacharacter)

$HFSPath_txt:=$1
$HFSPath_txt:=Convert path system to POSIX:C1106($HFSPath_txt)
//$HFSPath_txt:=Replace string($HFSPath_txt;":";"/")  // special for folder separator
//$HFSPath_txt:=Replace string($HFSPath_txt;" ";"\\ ")
$metacharacters:="\\!\"#$%&'()=~|<>?;*`[]: "

C_LONGINT:C283($i)

For ($i; 1; Length:C16($metacharacters))
	
	$metacharacter:=Substring:C12($metacharacters; $i; 1)
	
	$HFSPath_txt:=Replace string:C233($HFSPath_txt; $metacharacter; "\\"+$metacharacter; *)
	
End for 

$PosixPath_txt:=$HFSPath_txt

$0:=$PosixPath_txt