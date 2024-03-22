//%attributes = {"invisible":true}
If (False:C215)
	//INIT_TOWN_DATA 
	//Global Procedure for Initializing the town data.
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//aTownName is local to USER
	
	
	// Modified by: costasmanousakis-(Designer)-(1/30/2006 16:26:05)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(8/10/10 14:44:14)
	Mods_2010_08
	//  `Added new array ◊aOldDist3
	// Modified by: costasmanousakis-(Designer)-(2/8/11 08:39:24)
	Mods_2011_02
	//  `Presized arrays for [Town Data] fields; combined the separate Sele to array statements to two
End if 
//TRACE
C_BOOLEAN:C305($ReturnBlob)
$ReturnBlob:=False:C215
Case of 
	: (Count parameters:C259=0)
	: ($1="1")  //special case to save values to a blob
		C_BLOB:C604($0; $Return_blb)
		SET BLOB SIZE:C606($Return_blb; 0)
		C_LONGINT:C283($OffSet_l)
		$OffSet_l:=0
		$ReturnBlob:=True:C214
	Else 
End case 

C_LONGINT:C283($i; $codes)  //Command Replaced was o_C_INTEGER

ALL RECORDS:C47([Town Data:2])
C_LONGINT:C283($TwnRecs_L)
$TwnRecs_L:=Records in selection:C76([Town Data:2])
ARRAY TEXT:C222(<>aTownName; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(<>aBDEPT; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(<>aOldDist1; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aOldDist2; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aOldDist3; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aPlace_Code; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(<>aDistrict; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aRPC_1; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aRPC_2; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aCounty; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(<>aTownCode; $TwnRecs_L)  //Command Replaced was o_ARRAY string length was 3
ARRAY REAL:C219(<>aSeismic; $TwnRecs_L)
SELECTION TO ARRAY:C260([Town Data:2]BDEPT Prefix:2; <>aBDEPT; [Town Data:2]Town Name:1; <>aTownName; [Town Data:2]OldDistrictNo1:3; <>aOldDist1; [Town Data:2]OldDistrictNo2:4; <>aOldDist2; [Town Data:2]OldDistrictNo3:12; <>aOldDist3)
SELECTION TO ARRAY:C260([Town Data:2]Place_Code:5; <>aPlace_Code; [Town Data:2]District:6; <>aDistrict; [Town Data:2]RPC_1:7; <>aRPC_1; [Town Data:2]RPC_2:8; <>aRPC_2; [Town Data:2]Seismic_Acc:9; <>aSeismic; [Town Data:2]County Code:10; <>aCounty; [Town Data:2]Town Dist Code:11; <>aTownCode)
REDUCE SELECTION:C351([Town Data:2]; 0)

If ($ReturnBlob)
	VARIABLE TO BLOB:C532(<>aBDEPT; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aTownName; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aOldDist1; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aOldDist2; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aOldDist3; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aPlace_Code; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDistrict; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aRPC_1; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aRPC_2; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aSeismic; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aCounty; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aTownCode; $Return_blb; *)
End if 

ARRAY TEXT:C222(<>aKeyDescr; 0)  //Command Replaced was o_ARRAY string length was 35
LIST TO ARRAY:C288("Key Codes Descr"; <>aKeyDescr)
$codes:=Size of array:C274(<>aKeyDescr)
ARRAY TEXT:C222(<>aKeyCodes; $codes)  //Command Replaced was o_ARRAY string length was 3
For ($i; 1; $codes)
	<>aKeyCodes{$i}:=Substring:C12(<>aKeyDescr{$i}; 1; 3)
End for 

ARRAY TEXT:C222(<>aDirDescr; 0)  //Command Replaced was o_ARRAY string length was 25
LIST TO ARRAY:C288("Directional Indicator"; <>aDirDescr)
$codes:=Size of array:C274(<>aDirDescr)
ARRAY TEXT:C222(<>aDirIndex; $codes)  //Command Replaced was o_ARRAY string length was 1
For ($i; 1; $codes)
	<>aDirIndex{$i}:=Substring:C12(<>aDirDescr{$i}; 1; 1)
End for 
If ($ReturnBlob)
	VARIABLE TO BLOB:C532(<>aKeyDescr; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aKeyCodes; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDirDescr; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDirIndex; $Return_blb; *)
End if 

//These arrays are also set up in GP InitProcessVar.  It is needed here
//so that layout [Bridge MHD NBIS];"BDEPT Input" can be used in the
//User Environment.
ARRAY TEXT:C222(aTownName_; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aKeyDescr_; 0)  //Command Replaced was o_ARRAY string length was 35
ARRAY TEXT:C222(aKeyCodes_; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aDirDescr_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aDirIndex_; 0)  //Command Replaced was o_ARRAY string length was 1
COPY ARRAY:C226(<>aTownName; aTownName_)
COPY ARRAY:C226(<>aKeyCodes; aKeyCodes_)
COPY ARRAY:C226(<>aKeyDescr; aKeyDescr_)
COPY ARRAY:C226(<>aDirIndex; aDirIndex_)
COPY ARRAY:C226(<>aDirDescr; aDirDescr_)

ARRAY TEXT:C222(<>aCountyName; 0)  //Command Replaced was o_ARRAY string length was 15
ARRAY TEXT:C222(<>aCountyCode; 0)  //Command Replaced was o_ARRAY string length was 3
LIST TO ARRAY:C288("CountyName"; <>aCountyName)
LIST TO ARRAY:C288("CountyCode"; <>aCountyCode)

ARRAY TEXT:C222(<>aRPCName; 0)  //Command Replaced was o_ARRAY string length was 64
ARRAY TEXT:C222(<>aRPCCode; 0)  //Command Replaced was o_ARRAY string length was 2
ALL RECORDS:C47([RPCs:72])
SELECTION TO ARRAY:C260([RPCs:72]RPC Name:2; <>aRPCName)
SELECTION TO ARRAY:C260([RPCs:72]Code:1; <>aRPCCode)
REDUCE SELECTION:C351([RPCs:72]; 0)

If ($ReturnBlob)
	VARIABLE TO BLOB:C532(<>aCountyName; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aCountyCode; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aRPCName; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aRPCCode; $Return_blb; *)
	$0:=$Return_blb
	SET BLOB SIZE:C606($Return_blb; 0)
End if 