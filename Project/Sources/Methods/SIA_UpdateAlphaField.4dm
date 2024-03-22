//%attributes = {"invisible":true}
//Method: SIA_UpdateAlphaField
//Description
// update a date field in a [bridge table from data from an FHWA tape file
// Parameters
// $1 : $FldPtr
// $2 : $NewData_txt 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 15, 2023, 18:19:13
	Mods_2023_03
	// ----------------------------------------------------
	
	C_POINTER:C301(SIA_UpdateAlphaField; $1)
	C_TEXT:C284(SIA_UpdateAlphaField; $2)
	
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284($new_txt; $old_txt)
$old_txt:=f_TrimStr($1->; False:C215; True:C214)  // trim only trailing blanks
$new_txt:=f_TrimStr($2; False:C215; True:C214)

If (Length:C16($old_txt)#Length:C16($new_txt))
	$1->:=$2
Else 
	
	If (Position:C15($old_txt; $new_txt; *)>0)
	Else 
		$1->:=$2
	End if 
	
End if 

//End SIA_UpdateAlphaField   