//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/19/06, 16:24:17
	// ----------------------------------------------------
	// Method: ut_PutPersArraysIntoBlob
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/31/2006 14:48:49)
	Mods_2006_CM03
End if 
C_BLOB:C604($Blob_blb)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)
C_BOOLEAN:C305($UseFile_b; $NoChange_b)
Startup_PL
Characters
$Filename:="InitPersVariables.txt"
$Blob_blb:=InitPers("1")
If (False:C215)
	$UseFile_b:=ut_LoadBlobArrDoc($Filename)
	$NoChange_b:=F_CompareBlobs($Blob_blb; vBLobDocArrays)
End if 
$NoChange_b:=ut_CompareStoredPersData
If (Not:C34($NoChange_b))
	ut_SaveBlobDataToDoc($Blob_blb; $Filename)
End if 

SET BLOB SIZE:C606($Blob_blb; 0)
SET BLOB SIZE:C606(vBLobDocArrays; 0)