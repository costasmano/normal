//%attributes = {"invisible":true}
If (False:C215)
	//PM: ut_PutFieldDescriptionIntoBlob
	//Description:
	//This method will call INIT_FIELDS_DES with one parameter.
	//The purpose is as a utility to create a bdocument containing a blob of
	//arrays created by  INIT_FIELDS_DES 
	//The method will create a document that will be placed in win4dx 
	//and mac4dx folder on server so that it will download automatically
	Mods_2004_CJM03
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(1/31/2006 14:45:58)
	Mods_2006_CM03
End if 
C_BLOB:C604($Blob_blb)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)
C_BOOLEAN:C305($UseFile_b; $NoChange_b)
Startup_PL
Characters
$Filename:="InitVariables.txt"
$Blob_blb:=INIT_FIELDS_DES("1")
If (False:C215)
	$UseFile_b:=ut_LoadBlobArrDoc($Filename)
	$NoChange_b:=F_CompareBlobs($Blob_blb; vBLobDocArrays)
End if 
$NoChange_b:=ut_CompareStoredBlobData
If (Not:C34($NoChange_b))
	ut_SaveBlobDataToDoc($Blob_blb; $Filename)
End if 

SET BLOB SIZE:C606($Blob_blb; 0)
SET BLOB SIZE:C606(vBLobDocArrays; 0)