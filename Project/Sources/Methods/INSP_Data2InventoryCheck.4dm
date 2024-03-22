//%attributes = {"invisible":true}
//Method: INSP_Data2InventoryCheck
//Description
// Compare inv field with source field and add to pointer arrays if not the same
// Parameters
// $1 : $InvField_ptr
// $2 : $SourceField_ptr
// $3 : $FieldsToChange_ptr - pointer to array of pointers
// $4 : $SourceFields_ptr - pointer to array of pointers
// $5 : $UseVerify_b - optional : use method G_Insp_VerifyItem when comparing
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/08/17, 15:58:34
	// ----------------------------------------------------
	//Created : 
	Mods_2017_09
	
	C_POINTER:C301(INSP_Data2InventoryCheck; $1)
	C_POINTER:C301(INSP_Data2InventoryCheck; $2)
	C_POINTER:C301(INSP_Data2InventoryCheck; $3)
	C_POINTER:C301(INSP_Data2InventoryCheck; $4)
	C_BOOLEAN:C305(INSP_Data2InventoryCheck; $5)
End if 
//

C_POINTER:C301($1; $2; $3; $4)
C_POINTER:C301($InvField_ptr; $SourceField_ptr; $FieldsToChange_ptr; $SourceFields_ptr)
$InvField_ptr:=$1
$SourceField_ptr:=$2
$FieldsToChange_ptr:=$3
$SourceFields_ptr:=$4
C_BOOLEAN:C305($UseVerify_b)
$UseVerify_b:=False:C215
If (Count parameters:C259>4)
	C_BOOLEAN:C305($5)
	$UseVerify_b:=$5
End if 

If ($UseVerify_b)
	If ($InvField_ptr->#G_Insp_VerifyItem($SourceField_ptr->))
		APPEND TO ARRAY:C911($FieldsToChange_ptr->; $InvField_ptr)
		APPEND TO ARRAY:C911($SourceFields_ptr->; $SourceField_ptr)
	End if 
	
Else 
	If ($InvField_ptr->#$SourceField_ptr->)
		APPEND TO ARRAY:C911($FieldsToChange_ptr->; $InvField_ptr)
		APPEND TO ARRAY:C911($SourceFields_ptr->; $SourceField_ptr)
	End if 
	
End if 
//End INSP_Data2InventoryCheck