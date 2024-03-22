//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/20/06, 23:50:04
	// ----------------------------------------------------
	// Method: ut_RetrieveTOWNDATADoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(1/30/2006 16:28:46)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/19/10 14:37:42)
	Mods_2010_02
	//  `Added a global array ◊D6Towns_atxt for D6 towns - temporary until final setup is complete
	// Modified by: costasmanousakis-(Designer)-(8/10/10 14:44:57)
	Mods_2010_08
	//  `Added new array ◊aOldDist3
	// Modified by: costasmanousakis-(Designer)-(7/1/11 14:10:39)
	Mods_2011_06
	//  `Removed Somerville from the D6 towns
End if 
C_BOOLEAN:C305($UseFile_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

$UseFile_b:=False:C215
$Filename:="InitTWNDATAVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)
If ($UseFile_b=True:C214)
	C_LONGINT:C283($BlobOffSet_l)
	
	ARRAY TEXT:C222(<>aTownName; 0)  //Command Replaced was o_ARRAY string length was 20
	ARRAY TEXT:C222(<>aBDEPT; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222(<>aOldDist1; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(<>aOldDist2; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(<>aOldDist3; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(<>aPlace_Code; 0)  //Command Replaced was o_ARRAY string length was 5
	ARRAY TEXT:C222(<>aDistrict; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(<>aRPC_1; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(<>aRPC_2; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(<>aCounty; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222(<>aTownCode; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY REAL:C219(<>aSeismic; 0)
	ARRAY TEXT:C222(<>aKeyDescr; 0)  //Command Replaced was o_ARRAY string length was 35
	ARRAY TEXT:C222(<>aKeyCodes; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222(<>aDirDescr; 0)  //Command Replaced was o_ARRAY string length was 25
	ARRAY TEXT:C222(<>aDirIndex; 0)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222(aTownName_; 0)  //Command Replaced was o_ARRAY string length was 20
	ARRAY TEXT:C222(aKeyDescr_; 0)  //Command Replaced was o_ARRAY string length was 35
	ARRAY TEXT:C222(aKeyCodes_; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222(aDirDescr_; 0)  //Command Replaced was o_ARRAY string length was 25
	ARRAY TEXT:C222(aDirIndex_; 0)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222(<>aCountyName; 0)  //Command Replaced was o_ARRAY string length was 15
	ARRAY TEXT:C222(<>aCountyCode; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222(<>aRPCName; 0)  //Command Replaced was o_ARRAY string length was 64
	ARRAY TEXT:C222(<>aRPCCode; 0)  //Command Replaced was o_ARRAY string length was 2
	
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aBDEPT; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aTownName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aOldDist1; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aOldDist2; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aOldDist3; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aPlace_Code; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDistrict; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aRPC_1; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aRPC_2; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aSeismic; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aCounty; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aTownCode; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aKeyDescr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aKeyCodes; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDirDescr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDirIndex; $BlobOffSet_l)
	COPY ARRAY:C226(<>aTownName; aTownName_)
	COPY ARRAY:C226(<>aKeyCodes; aKeyCodes_)
	COPY ARRAY:C226(<>aKeyDescr; aKeyDescr_)
	COPY ARRAY:C226(<>aDirIndex; aDirIndex_)
	COPY ARRAY:C226(<>aDirDescr; aDirDescr_)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aCountyName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aCountyCode; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aRPCName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aRPCCode; $BlobOffSet_l)
	
Else 
	INIT_TOWN_DATA
End if 
SET BLOB SIZE:C606(vBlobDocArrays; 0)

ARRAY TEXT:C222(<>D6Towns_atxt; 0)
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Boston")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Braintree")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Brookline")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Cambridge")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Canton")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Chelsea")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Dedham")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Dover")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Milton")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Needham")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Newton")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Quincy")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Randolph")
//APPEND TO ARRAY(◊D6Towns_atxt;"Somerville")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Watertown")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Wellesley")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Weston")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Westwood")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Weymouth")
APPEND TO ARRAY:C911(<>D6Towns_atxt; "Winthrop")