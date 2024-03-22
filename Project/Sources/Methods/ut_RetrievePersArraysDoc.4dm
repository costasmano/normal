//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/19/06, 13:48:33
	// ----------------------------------------------------
	// Method: ut_RetrievePersArraysDoc
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
$Filename:="InitPersVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)

If ($UseFile_b=True:C214)
	ARRAY TEXT:C222(aAgency; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222(aJob; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY INTEGER:C220(aJobCode; 0)
	ARRAY TEXT:C222(aPeople; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220(aPeople_ID; 0)
	ARRAY TEXT:C222(aBIE; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220(aBIE_ID; 0)
	ARRAY TEXT:C222(aUOE; 0)  //only one Underwater Engr to start//Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220(aUOEID; 0)
	ARRAY TEXT:C222(aDiveMaster; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220(aDiveMasterID; 0)
	ARRAY TEXT:C222(aTeamLeader; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220(aTeamLdrID; 0)
	ARRAY TEXT:C222(aTeamMbr; 0)  //Command Replaced was o_ARRAY string length was 44
	ARRAY INTEGER:C220(aTeamMbrID; 0)
	//The name and ID of the Underwater Operations Engineer
	C_TEXT:C284(<>UOEName)  // Command Replaced was o_C_STRING length was 44
	C_LONGINT:C283(<>UOEID)  //Command Replaced was o_C_INTEGER
	//variables for usernames of UOE and DBIEs
	C_TEXT:C284(<>UOEUname; <>DBIED1Uname; <>DBIED2Uname; <>DBIED3Uname; <>DBIED4Uname; <>DBIED5Uname)  // Command Replaced was o_C_STRING length was 44
	ARRAY TEXT:C222(<>aDBIEUnames; 5)  //Command Replaced was o_ARRAY string length was 44
	C_LONGINT:C283($BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aAgency; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aJob; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aJobCode; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; aPeople; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aPeople_ID; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>UOEName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>UOEUname; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>UOEID; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aUOE; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aUOEID; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; <>aDBIEUnames; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aBIE; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aBIE_ID; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; aDiveMaster; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aDiveMasterID; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; aTeamLeader; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aTeamLdrID; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; aTeamMbr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; aTeamMbrID; $BlobOffSet_l)
	
Else 
	InitPers
End if 
SET BLOB SIZE:C606(vBlobDocArrays; 0)