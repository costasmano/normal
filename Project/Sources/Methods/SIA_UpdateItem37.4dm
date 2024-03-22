//%attributes = {"invisible":true}
//Method: SIA_UpdateItem37
//Description
// Update Item 37 field from data in NBI tape
// Parameters
// $1 : $FldPtr
// $2 : $NewData_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 03/23/23, 14:12:57
	// ----------------------------------------------------
	//C_STRING(11;◊Item37FHWA;◊Item37Code)
	//◊Item37FHWA:="12235334435"  `NBI Coding Guide
	//◊Item37Code:="HEPANCR ?XZ"  `MHD internal code
	//Created : 
	Mods_2023_03
	
	C_POINTER:C301(SIA_UpdateItem37; $1)
	C_TEXT:C284(SIA_UpdateItem37; $2)
	
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2)

If ($2="4")
	// FHWA 4 -> blank or ? or nothing on Mass.- no change in data
Else 
	
	//check if current value converts to the one from the tape
	C_TEXT:C284($CurrEquivalent)
	$CurrEquivalent:=HistoricalTrans($1->)
	
	If ($CurrEquivalent=$2)
		//no need to update
	Else 
		C_LONGINT:C283($pos_L)
		$pos_L:=Position:C15($2; <>Item37FHWA)
		If ($pos_L>0)
			$1->:=<>Item37code[[$pos_L]]
		End if 
	End if 
End if 

//End SIA_UpdateItem37