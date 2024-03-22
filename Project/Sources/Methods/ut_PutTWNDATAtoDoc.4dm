//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/21/06, 00:01:47
	// ----------------------------------------------------
	// Method: ut_PutTWNDATAtoDoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/31/2006 15:01:37)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/6/2006 09:59:54)
	Mods_2006_CM03
	Mods_2007_CJM_v5302  //r001 `10/02/07, 10:57:57
End if 
//TRACE
C_BLOB:C604($Blob_blb; $Blob2_blb; $Blob3_blb)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)
Startup_PL
Characters
C_BOOLEAN:C305($UseFile_b; $NoChange_b)
$Filename:="InitTWNDATAVariables.txt"
$Blob_blb:=INIT_TOWN_DATA("1")  //recalc arrays and store in blob

$NoChange_b:=ut_CompareStoredTOWNData

If (Not:C34($NoChange_b))
	ut_SaveBlobDataToDoc($Blob_blb; $Filename)
End if 

SET BLOB SIZE:C606($Blob_blb; 0)
SET BLOB SIZE:C606($Blob2_blb; 0)
SET BLOB SIZE:C606($Blob3_blb; 0)
SET BLOB SIZE:C606(vBLobDocArrays; 0)