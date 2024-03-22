//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/20/06, 23:50:04
	// ----------------------------------------------------
	// Method: ut_CompareStoredTOWNData
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(1/30/2006 16:28:46)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(8/10/10 14:43:32)
	Mods_2010_08
	//  `Added code for new array ◊aOldDist3
	Mods_2013_05  //r001 ` Changed to use local arrays for comparison
	//Modified by: Charles Miller (5/2/13 16:32:05)
End if 
C_BOOLEAN:C305($0; $UseFile_b; $ArraysSame_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

$UseFile_b:=False:C215
$ArraysSame_b:=False:C215
$Filename:="InitTWNDATAVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)
If ($UseFile_b=True:C214)
	C_LONGINT:C283($BlobOffSet_l)
	$ArraysSame_b:=True:C214
	ARRAY TEXT:C222($Temp_A_TownName; 0)  //Command Replaced was o_ARRAY string length was 20
	ARRAY TEXT:C222($Temp_A_BDEPT; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_OldDist1; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_OldDist2; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_OldDist3; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_Place_Code; 0)  //Command Replaced was o_ARRAY string length was 5
	ARRAY TEXT:C222($Temp_A_District; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_RPC_1; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_RPC_2; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_County; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_TownCode; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY REAL:C219($Temp_A_Seismic; 0)
	ARRAY TEXT:C222($Temp_A_KeyDescr; 0)  //Command Replaced was o_ARRAY string length was 35
	ARRAY TEXT:C222($Temp_A_KeyCodes; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_DirDescr; 0)  //Command Replaced was o_ARRAY string length was 25
	ARRAY TEXT:C222($Temp_A_DirIndex; 0)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222($Temp_A_CountyName; 0)  //Command Replaced was o_ARRAY string length was 15
	ARRAY TEXT:C222($Temp_A_CountyCode; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_RPCName; 0)  //Command Replaced was o_ARRAY string length was 64
	ARRAY TEXT:C222($Temp_A_RPCCode; 0)  //Command Replaced was o_ARRAY string length was 2
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_BDEPT; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_TownName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_OldDist1; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_OldDist2; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_OldDist3; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Place_Code; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_District; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_RPC_1; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_RPC_2; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Seismic; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_County; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_TownCode; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_KeyDescr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_KeyCodes; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DirDescr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DirIndex; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_CountyName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_CountyCode; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_RPCName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_RPCCode; $BlobOffSet_l)
	Case of 
		: (Not:C34(F_CompareArrays(->$Temp_A_BDEPT; -><>aBDEPT)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_TownName; -><>aTownName)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_OldDist1; -><>aOldDist1)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_OldDist2; -><>aOldDist2)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_OldDist3; -><>aOldDist3)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_Place_Code; -><>aPlace_Code)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_District; -><>aDistrict)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_RPC_1; -><>aRPC_1)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_RPC_2; -><>aRPC_2)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_Seismic; -><>aSeismic)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_County; -><>aCounty)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_TownCode; -><>aTownCode)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_KeyDescr; -><>aKeyDescr)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_KeyCodes; -><>aKeyCodes)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_DirDescr; -><>aDirDescr)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_DirIndex; -><>aDirIndex)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_CountyName; -><>aCountyName)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_CountyCode; -><>aCountyCode)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_RPCName; -><>aRPCName)))
			$ArraysSame_b:=False:C215
		: (Not:C34(F_CompareArrays(->$Temp_A_RPCCode; -><>aRPCCode)))
			$ArraysSame_b:=False:C215
			
	End case 
	
	ARRAY TEXT:C222($Temp_A_TownName; 0)  //Command Replaced was o_ARRAY string length was 20
	ARRAY TEXT:C222($Temp_A_BDEPT; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_OldDist1; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_OldDist2; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_OldDist3; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_Place_Code; 0)  //Command Replaced was o_ARRAY string length was 5
	ARRAY TEXT:C222($Temp_A_District; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_RPC_1; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_RPC_2; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Temp_A_County; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_TownCode; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY REAL:C219($Temp_A_Seismic; 0)
	ARRAY TEXT:C222($Temp_A_KeyDescr; 0)  //Command Replaced was o_ARRAY string length was 35
	ARRAY TEXT:C222($Temp_A_KeyCodes; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_DirDescr; 0)  //Command Replaced was o_ARRAY string length was 25
	ARRAY TEXT:C222($Temp_A_DirIndex; 0)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222($Temp_A_CountyName; 0)  //Command Replaced was o_ARRAY string length was 15
	ARRAY TEXT:C222($Temp_A_CountyCode; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Temp_A_RPCName; 0)  //Command Replaced was o_ARRAY string length was 64
	ARRAY TEXT:C222($Temp_A_RPCCode; 0)  //Command Replaced was o_ARRAY string length was 2
	
End if 
SET BLOB SIZE:C606(vBlobDocArrays; 0)
$Filename:=""
$0:=$ArraysSame_b