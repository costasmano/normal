//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Test_GetFileFromSRVR
//Description
// EXECUTE ON SERVER attribute 
// Get a file from the resources folder
// Parameters
// $0 : BLOB : file contents
// $1 : Text : Name of file including subfolder from Current Resources folder
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/18/17, 16:21:57
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
	C_BLOB:C604(Test_GetFileFromSRVR; $0)
	C_TEXT:C284(Test_GetFileFromSRVR; $1)
	
End if 
//
C_BLOB:C604($0; $doc_x)
C_TEXT:C284($1)
SET BLOB SIZE:C606($doc_x; 0)

If (Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+$1)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+$1; $doc_x)
	COMPRESS BLOB:C534($doc_x)
End if 

$0:=$doc_x

//End Test_GetFileFromSRVR