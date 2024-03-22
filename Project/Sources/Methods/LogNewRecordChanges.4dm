//%attributes = {"invisible":true}
//Method: LogNewRecordChanges
//Description
//
// Parameters
//$1  the pointer id of the parent record key field in the parent record
//$2  the pointer id of the parent record foreign key in the local table
//$3  the pointer id of the Key of local table
//$4  the descriptor for the type of id relations
//$5  the name of the sequencing for this record
//$6  number of change stack
// ${7} pointers to fields to be skipped in the changes
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/16/15, 16:05:15
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
	// Modified by: Costas Manousakis-(Designer)-(11/3/17 11:11:01)
	Mods_2017_11_bug
	//  `skip uuids
End if 
//
C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($4)
C_TEXT:C284($5)
C_LONGINT:C283($6)

ARRAY POINTER:C280($FldsToSkip_aptr; 0)
C_POINTER:C301($Tbl_ptr; $fld_ptr)
C_LONGINT:C283($numFlds_L; $fLoop_L; $pLoop_L; $TblNum_L; $numParams_L; $viFldType; $vlFldLen)
//
//add to the fields to be skipped the foreign and local keys of the table
APPEND TO ARRAY:C911($FldsToSkip_aptr; $2)
APPEND TO ARRAY:C911($FldsToSkip_aptr; $3)
$numParams_L:=Count parameters:C259
//find if there are additional fields to skip in the changes
If ($numParams_L>6)
	C_POINTER:C301(${7})
	For ($pLoop_L; 7; $numParams_L)
		APPEND TO ARRAY:C911($FldsToSkip_aptr; ${$pLoop_L})
	End for 
	
End if 

//log the new record first
LogNewRecord($1; $2; $3; $4; $5)

$TblNum_L:=Table:C252($2)
$Tbl_ptr:=Table:C252($TblNum_L)
$numFlds_L:=Get last field number:C255($Tbl_ptr)
//do all the fields
For ($fLoop_L; 1; $numFlds_L)
	If (Is field number valid:C1000($Tbl_ptr; $fLoop_L))
		$fld_ptr:=Field:C253($TblNum_L; $fLoop_L)
		GET FIELD PROPERTIES:C258($fld_ptr; $viFldType; $vlFldLen)
		If ((Find in array:C230($FldsToSkip_aptr; $fld_ptr)>0) | (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0)))  //Skip Ids //AND subtables
			
		Else 
			PushChange($6; $fld_ptr)
		End if 
	End if 
End for 

FlushGrpChgs($6; $1; $2; $3; $4)

//End LogNewRecordChanges