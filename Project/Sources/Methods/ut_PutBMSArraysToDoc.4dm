//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/21/06, 00:39:14
	// ----------------------------------------------------
	// Method: ut_PutBMSArraysToDoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/31/2006 14:45:34)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/6/2006 10:15:35)
	Mods_2006_CM03
End if 
C_BLOB:C604($Blob_blb)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)
C_BOOLEAN:C305($UseFile_b; $NoChange_b)
Startup_PL
Characters
$Filename:="InitBMSArrVariables.txt"
$Blob_blb:=INIT_BMS_LoadArrays("1")
$NoChange_b:=ut_CompareStoredBMSArrays
If (Not:C34($NoChange_b))
	ut_SaveBlobDataToDoc($Blob_blb; $Filename)
End if 

SET BLOB SIZE:C606($Blob_blb; 0)
SET BLOB SIZE:C606(vBLobDocArrays; 0)