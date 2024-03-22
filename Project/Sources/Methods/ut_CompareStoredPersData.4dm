//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/03/06, 16:51:13
	// ----------------------------------------------------
	// Method: ut_CompareStoredPersData
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/9/2006 10:01:46)
	Mods_2006_CM03
	Mods_2013_05  //r001 `  Changed to use local arrays for comparison
	//Modified by: Charles Miller (5/2/13 16:32:47)
End if 
C_BOOLEAN:C305($0; $UseFile_b; $ArraysSame_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

$UseFile_b:=False:C215
$ArraysSame_b:=False:C215
$Filename:="InitPersVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)

If ($UseFile_b=True:C214)
	C_LONGINT:C283($BlobOffSet_l)
	$ArraysSame_b:=True:C214
	ARRAY TEXT:C222($Temp_AAgency; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222($Temp_AJob; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY INTEGER:C220($Temp_AJobCode; 0)
	ARRAY TEXT:C222($Temp_APeople; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_APeople_ID; 0)
	ARRAY TEXT:C222($Temp_ABIE; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ABIE_ID; 0)
	ARRAY TEXT:C222($Temp_AUOE; 0)  //only one Underwater Engr to start//Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_AUOEID; 0)
	ARRAY TEXT:C222($Temp_ADiveMaster; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ADiveMasterID; 0)
	ARRAY TEXT:C222($Temp_ATeamLeader; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ATeamLdrID; 0)
	ARRAY TEXT:C222($Temp_ATeamMbr; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ATeamMbrID; 0)
	//The name and ID of the Underwater Operations Engineer
	C_TEXT:C284($TEMP_V_UOEName)  // Command Replaced was o_C_STRING length was 44
	C_TEXT:C284($TEMP_V_UOEUName)  // Command Replaced was o_C_STRING length was 44
	C_LONGINT:C283($TEMP_V_UOEID)  //Command Replaced was o_C_INTEGER
	ARRAY TEXT:C222($Temp_ADBIEUnames; 5)  //Command Replaced was o_ARRAY string length was 44
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_AAgency; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_AJob; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_AJobCode; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_APeople; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_APeople_ID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $TEMP_V_UOEName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $TEMP_V_UOEUName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $TEMP_V_UOEID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_AUOE; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_AUOEID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ADBIEUnames; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ABIE; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ABIE_ID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ADiveMaster; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ADiveMasterID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ATeamLeader; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ATeamLdrID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ATeamMbr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $Temp_ATeamMbrID; $BlobOffSet_l)
	
	Case of 
		: (Not:C34(F_CompareArrays(->$Temp_AAgency; ->aAgency)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_AJob; ->aJob)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_AJobCode; ->aJobCode)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_APeople; ->aPeople)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_APeople_ID; ->aPeople_ID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareVars(->$TEMP_V_UOEName; -><>UOEName)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareVars(->$TEMP_V_UOEUName; -><>UOEUName)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareVars(->$TEMP_V_UOEID; -><>UOEID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_AUOE; ->aUOE)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_AUOEID; ->aUOEID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ADBIEUnames; -><>aDBIEUnames)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ABIE; ->aBIE)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ABIE_ID; ->aBIE_ID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ADiveMaster; ->aDiveMaster)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ADiveMasterID; ->aDiveMasterID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ATeamLeader; ->aTeamLeader)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ATeamLdrID; ->aTeamLdrID)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ATeamMbr; ->aTeamMbr)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_ATeamMbrID; ->aTeamMbrID)))
			$ArraysSame_b:=False:C215
			
	End case 
	
	
	ARRAY TEXT:C222($Temp_AAgency; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222($Temp_AJob; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY INTEGER:C220($Temp_AJobCode; 0)
	ARRAY TEXT:C222($Temp_APeople; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_APeople_ID; 0)
	ARRAY TEXT:C222($Temp_ABIE; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ABIE_ID; 0)
	ARRAY TEXT:C222($Temp_AUOE; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_AUOEID; 0)
	ARRAY TEXT:C222($Temp_ADiveMaster; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ADiveMasterID; 0)
	ARRAY TEXT:C222($Temp_ATeamLeader; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ATeamLdrID; 0)
	ARRAY TEXT:C222($Temp_ATeamMbr; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220($Temp_ATeamMbrID; 0)
	ARRAY TEXT:C222($Temp_ADBIEUnames; 0)  //Command Replaced was o_ARRAY string length was 44
	
End if 
SET BLOB SIZE:C606(vBlobDocArrays; 0)
$0:=$ArraysSame_b