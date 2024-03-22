//%attributes = {"invisible":true,"executedOnServer":true}
//Method: SIA_GetAvailableBIN
//Description
// Return the first available BIN
// Parameters
// $0 : $BIN_  : return blank if none available
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jul 6, 2023, 11:57:13
	Mods_2023_07
	// ----------------------------------------------------
	
	C_TEXT:C284(SIA_GetAvailableBIN; $0)
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($BIN_)
Compiler_SIA
If (Storage:C1525.AvailableBINs=Null:C1517)  // check if the AvailableBINs have been defined.
	//define them if not there
	Use (Storage:C1525)
		Storage:C1525.AvailableBINs:=New shared collection:C1527
	End use 
	Use (Storage:C1525.AvailableBINs)
		ARRAY TEXT:C222($availBins_atxt; 0)
		ut_MissingBINStoArray(->$availBins_atxt)
		ARRAY TO COLLECTION:C1563(Storage:C1525.AvailableBINs; $availBins_atxt)
	End use 
	
End if 

If (Storage:C1525.AvailableBINs.length>0)
	Use (Storage:C1525.AvailableBINs)
		//take first out of available
		$BIN_:=Storage:C1525.AvailableBINs[0]
		//remove it from the list
		Storage:C1525.AvailableBINs.remove(0; 1)
	End use 
End if 

$0:=$BIN_

//End SIA_GetAvailableBIN   