//%attributes = {"invisible":true}
//Method: ut_ResetBlankUUIDS
//Description
//This method will check and update any UUIDS that are not unique for a table. 
//If we start using UUIDS as links we may have to modify this code 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/08/20, 13:44:11
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12_bug
End if 
//
C_LONGINT:C283($TableLoop_L; $FieldLoop_L; $FieldType_l; $Length_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b)
C_BOOLEAN:C305($FoundUUID_B)
ARRAY LONGINT:C221($table_Numbers_AL; 0)
ARRAY LONGINT:C221($UUIDField_Numbers_AL; 0)
C_POINTER:C301($Table_ptr; $Field_ptr)
For ($TableLoop_L; 1; Get last table number:C254)
	If (Is table number valid:C999($TableLoop_L))
		
		For ($FieldLoop_L; Get last field number:C255($TableLoop_L); 1; -1)
			If (Is field number valid:C1000($TableLoop_L; $FieldLoop_L))
				
				GET FIELD PROPERTIES:C258($TableLoop_L; $FieldLoop_L; $FieldType_l; $Length_l; $Indexed_b; $Unique_b)
				
				If ($FieldType_l=Is alpha field:K8:1) & ($Length_l=0)
					$Table_ptr:=Table:C252($TableLoop_L)
					$Field_ptr:=Field:C253($TableLoop_L; $FieldLoop_L)
					ARRAY TEXT:C222($DistinctValues_atxt; 0)
					ALL RECORDS:C47($Table_ptr->)
					//%W-518.10
					DISTINCT VALUES:C339($Field_ptr->; $DistinctValues_atxt)
					//%W+518.10
					If (Size of array:C274($DistinctValues_atxt)#Records in table:C83($Table_ptr->))
						APPEND TO ARRAY:C911($table_Numbers_AL; $TableLoop_L)
						APPEND TO ARRAY:C911($UUIDField_Numbers_AL; $FieldLoop_L)
						
					End if 
					$FieldLoop_L:=0
				End if 
			End if 
		End for 
	End if 
End for 


For ($TableLoop_L; 1; Size of array:C274($table_Numbers_AL))
	$Table_ptr:=Table:C252($table_Numbers_AL{$TableLoop_L})
	$Field_ptr:=Field:C253($table_Numbers_AL{$TableLoop_L}; $UUIDField_Numbers_AL{$TableLoop_L})
	READ WRITE:C146($Table_ptr->)
	ALL RECORDS:C47($Table_ptr->)
	
	APPLY TO SELECTION:C70($Table_ptr->; $Field_ptr->:=Generate UUID:C1066)
	
End for 

//End ut_ResetBlankUUIDS