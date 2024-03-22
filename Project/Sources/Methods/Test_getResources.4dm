//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Test_getResources
//Description
// Execute on Server - gets a list of names in the resources folder based on subpath in param 2
// Parameters
// $1 : Pointer to text array to receive the list
// $2 : optional - sub path from the  (Current Resources folder)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/18/17, 13:11:51
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
	
	C_POINTER:C301(Test_getResources; $1)
	C_TEXT:C284(Test_getResources; $2)
	
End if 
//
C_POINTER:C301($1; $Listarray_ptr)
ARRAY TEXT:C222(v_28_001_atxt; 0)  //use the name from the [sequences]name
//TRACE
ARRAY TEXT:C222($folders_atxt; 0)
ARRAY TEXT:C222($files_atxt; 0)

Startup_PL
$Listarray_ptr:=$1
C_TEXT:C284($subPath_txt)
$subPath_txt:=""
If (Count parameters:C259>1)
	C_TEXT:C284($2; $SubPath_txt)
	$SubPath_txt:=$2
End if 
FOLDER LIST:C473(Get 4D folder:C485(Current resources folder:K5:16)+$SubPath_txt; $folders_atxt)
DOCUMENT LIST:C474(Get 4D folder:C485(Current resources folder:K5:16)+$SubPath_txt; $files_atxt)

C_LONGINT:C283($loop_L)
If ($SubPath_txt#"")
	APPEND TO ARRAY:C911($Listarray_ptr->; "..")  //to allow to go up the folder tree
End if 
For ($loop_L; 1; Size of array:C274($folders_atxt))
	APPEND TO ARRAY:C911($Listarray_ptr->; $folders_atxt{$loop_L}+<>PL_DirectorySep_s)
End for 

For ($loop_L; 1; Size of array:C274($files_atxt))
	APPEND TO ARRAY:C911($Listarray_ptr->; $files_atxt{$loop_L})
End for 

//End Test_getResources