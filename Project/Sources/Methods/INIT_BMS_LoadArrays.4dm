//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/21/06, 00:47:32
	// ----------------------------------------------------
	// Method: INIT_BMS_LoadArrays
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
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

LOAD_aElem
LOAD_aEnv
LOAD_CS_Notes

If ($ReturnBlob)
	VARIABLE TO BLOB:C532(aElemNo; $Return_blb; *)
	VARIABLE TO BLOB:C532(aElemID; $Return_blb; *)
	VARIABLE TO BLOB:C532(aElem; $Return_blb; *)
	VARIABLE TO BLOB:C532(aEnvID; $Return_blb; *)
	VARIABLE TO BLOB:C532(aEnv; $Return_blb; *)
	VARIABLE TO BLOB:C532(aNoteID; $Return_blb; *)
	VARIABLE TO BLOB:C532(aNote; $Return_blb; *)
	$0:=$Return_blb
	SET BLOB SIZE:C606($Return_blb; 0)
End if 