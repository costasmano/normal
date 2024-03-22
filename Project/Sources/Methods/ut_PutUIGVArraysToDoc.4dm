//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/20/06, 22:23:51
	// ----------------------------------------------------
	// Method: ut_PutUIGVArraysToDoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/31/2006 14:51:12)
	Mods_2006_CM03
End if 
//TRACE
C_BLOB:C604($Blob_blb)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)
C_BOOLEAN:C305($UseFile_b; $NoChange_b)
Startup_PL
Characters
$Filename:="InitUIGVVariables.txt"
$Blob_blb:=INIT_UI_GV_LoadArrays("1")
$UseFile_b:=ut_LoadBlobArrDoc($Filename)
$NoChange_b:=F_CompareBlobs($Blob_blb; vBLobDocArrays)
If (Not:C34($NoChange_b))
	ut_SaveBlobDataToDoc($Blob_blb; $Filename)
End if 

SET BLOB SIZE:C606($Blob_blb; 0)
SET BLOB SIZE:C606(vBLobDocArrays; 0)