//%attributes = {"invisible":true,"executedOnServer":true}
//Method: SIA_ReturnBINtoAvailable
//Description
// Return a BIN to the list of available BINs
// Parameters
// $1 : $BIN_
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jul 6, 2023, 12:04:56
	Mods_2023_07
	// ----------------------------------------------------
	
	C_TEXT:C284(SIA_ReturnBINtoAvailable; $1)
	
End if 
//
C_TEXT:C284($1; $BIN_)
$BIN_:=$1
// check if AvailableBINs is defined
If (Storage:C1525.AvailableBINs=Null:C1517)
	Use (Storage:C1525)
		Storage:C1525.AvailableBINs:=New shared collection:C1527
	End use 
	Use (Storage:C1525.AvailableBINs)
		ARRAY TEXT:C222($availBins_atxt; 0)
		ut_MissingBINStoArray(->$availBins_atxt)
		ARRAY TO COLLECTION:C1563(Storage:C1525.AvailableBINs; $availBins_atxt)
	End use 
	
End if 

Use (Storage:C1525.AvailableBINs)
	Storage:C1525.AvailableBINs.push($BIN_)
	Storage:C1525.AvailableBINs.sort()
End use 

//End SIA_ReturnBINtoAvailable   