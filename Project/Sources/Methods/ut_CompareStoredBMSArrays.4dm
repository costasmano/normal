//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/06/06, 10:01:06
	// ----------------------------------------------------
	// Method: ut_CompareStoredBMSArrays
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	Mods_2013_05  //r001 `  Changed to use local arrays for comparison
	//Modified by: Charles Miller (5/2/13 16:33:10)
End if 
C_BOOLEAN:C305($0; $UseFile_b; $ArraysSame_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

$ArraysSame_b:=False:C215

$UseFile_b:=False:C215
$Filename:="InitBMSArrVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)
If ($UseFile_b=True:C214)
	
	C_LONGINT:C283($BlobOffSet_l)
	$ArraysSame_b:=True:C214
	
	ARRAY INTEGER:C220($Temp_A_ElemID; 0)
	ARRAY INTEGER:C220($Temp_A_ElemNo; 0)
	ARRAY TEXT:C222($Temp_A_Elem; 0)  //Command Replaced was o_ARRAY string length was 106
	ARRAY TEXT:C222($Temp_A_Env; 0)  //Command Replaced was o_ARRAY string length was 43
	ARRAY INTEGER:C220($Temp_A_EnvID; 0)
	ARRAY TEXT:C222($Temp_A_Note; 0)
	ARRAY INTEGER:C220($Temp_A_NoteID; 0)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_A_ElemNo; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_A_ElemID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_A_Elem; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_A_EnvID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_A_Env; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_A_NoteID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_A_Note; $BlobOffSet_l)
	Case of 
		: (Not:C34(F_CompareArrays(->$Temp_A_ElemNo; ->aElemNo)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_ElemID; ->aElemID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_Elem; ->aElem)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_EnvID; ->aEnvID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_Env; ->aEnv)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_NoteID; ->aNoteID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_Note; ->aNote)))
			$ArraysSame_b:=False:C215
	End case 
	
	ARRAY INTEGER:C220($Temp_A_ElemID; 0)
	ARRAY INTEGER:C220($Temp_A_ElemNo; 0)
	ARRAY TEXT:C222($Temp_A_Elem; 0)  //Command Replaced was o_ARRAY string length was 106
	ARRAY TEXT:C222($Temp_A_Env; 0)  //Command Replaced was o_ARRAY string length was 43
	ARRAY INTEGER:C220($Temp_A_EnvID; 0)
	ARRAY TEXT:C222($Temp_A_Note; 0)
	ARRAY INTEGER:C220($Temp_A_NoteID; 0)
End if 

SET BLOB SIZE:C606(vBlobDocArrays; 0)
$Filename:=""
$0:=$ArraysSame_b