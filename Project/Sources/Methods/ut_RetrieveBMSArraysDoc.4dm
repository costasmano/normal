//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/21/06, 00:29:25
	// ----------------------------------------------------
	// Method: ut_RetrieveBMSArraysDoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_BOOLEAN:C305($UseFile_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

$UseFile_b:=False:C215
$Filename:="InitBMSArrVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)
If ($UseFile_b=True:C214)
	
	C_LONGINT:C283($BlobOffSet_l)
	
	ARRAY INTEGER:C220(aElemID; 0)
	ARRAY INTEGER:C220(aElemNo; 0)
	ARRAY TEXT:C222(aElem; 0)  //Command Replaced was o_ARRAY string length was 106
	ARRAY TEXT:C222(aEnv; 0)  //Command Replaced was o_ARRAY string length was 43
	ARRAY INTEGER:C220(aEnvID; 0)
	ARRAY TEXT:C222(aNote; 0)
	ARRAY INTEGER:C220(aNoteID; 0)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; aElemNo; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aElemID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aElem; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aEnvID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aEnv; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aNoteID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aNote; $BlobOffSet_l)
	
Else 
	INIT_BMS_LoadArrays
End if 

SET BLOB SIZE:C606(vBlobDocArrays; 0)