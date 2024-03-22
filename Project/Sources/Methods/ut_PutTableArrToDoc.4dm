//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/30/06, 17:54:25
	// ----------------------------------------------------
	// Method: ut_PutTableArrToDoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	
End if 
//TRACE
C_BLOB:C604($Blob_blb)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)
Startup_PL
Characters
C_BOOLEAN:C305($UseFile_b; $NoChange_b)
$Filename:="InitTableSortOrder.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)
$Blob_blb:=G_SortTable_new("1")
$NoChange_b:=F_CompareBlobs($Blob_blb; vBLobDocArrays)
If (Not:C34($NoChange_b))
	ut_SaveBlobDataToDoc($Blob_blb; $Filename)
End if 

SET BLOB SIZE:C606($Blob_blb; 0)
SET BLOB SIZE:C606(vBLobDocArrays; 0)