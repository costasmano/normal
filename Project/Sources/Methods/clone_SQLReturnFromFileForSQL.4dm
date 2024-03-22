//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/02/14, 21:28:23
//----------------------------------------------------
//Method: clone_SQLReturnFromFileForSQL
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	clone_SQLReturnFromFileForSQL
	
End if 
C_LONGINT:C283($1; $2; $TableNumber_l; $FieldNumber_l; $Type_l; $Length_l)

C_TEXT:C284($ConstraintID_txt)
C_LONGINT:C283($Primary_key_field_id_L)


$TableNumber_l:=$1
$FieldNumber_l:=$2
C_POINTER:C301($3; $4; $InsertFieldDescriptor_ptr; $InsertBindDescriptor_ptr)
$InsertFieldDescriptor_ptr:=$3
$InsertBindDescriptor_ptr:=$4

C_BOOLEAN:C305($Continue_B)
$Continue_B:=True:C214
$Primary_key_field_id_L:=Find in array:C230(clone_PrimaryKeyTable_aL; $TableNumber_l)
If ($Primary_key_field_id_L>0)
	$Primary_key_field_id_L:=clone_PrimaryField_aL{$Primary_key_field_id_L}
End if 
If ($FieldNumber_l=$Primary_key_field_id_L)
	If (clone_IncludeUUIDS_B)
	Else 
		$Continue_B:=False:C215
		$InsertFieldName_txt:=""
		$InsertFieldBind_txt:=""
	End if 
	
End if 

If ($Continue_B)
	C_TEXT:C284($InsertFieldName_txt; $InsertFieldBind_txt)
	C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b; $FillReturn_B)
	$InsertFieldName_txt:=Field name:C257($TableNumber_l; $FieldNumber_l)
	C_TEXT:C284($VariableExtension_txt)
	GET FIELD PROPERTIES:C258($TableNumber_l; $FieldNumber_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
	If ($Type_l#7)
		$FillReturn_B:=True:C214
		Case of 
			: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
				$VariableExtension_txt:="_txt"
			: ($Type_l=Is real:K8:4)
				$VariableExtension_txt:="_r"
			: ($Type_l=Is integer:K8:5)
				$VariableExtension_txt:="_i"
			: ($Type_l=Is longint:K8:6)
				$VariableExtension_txt:="_l"
			: ($Type_l=Is date:K8:7)
				$VariableExtension_txt:="_d"
			: ($Type_l=Is time:K8:8)
				$VariableExtension_txt:="_tm"
			: ($Type_l=Is boolean:K8:9)
				$VariableExtension_txt:="_b"
			: ($Type_l=Is picture:K8:10)
				$VariableExtension_txt:="_p"
			: ($Type_l=Is BLOB:K8:12)
				
				If (Not:C34(clone_UseBlobArrays_B))
					$FillReturn_B:=False:C215
					$VariableExtension_txt:=""
					$InsertFieldName_txt:=""
				Else 
					$VariableExtension_txt:="_blb"
				End if 
			Else 
				$FillReturn_B:=False:C215
				$VariableExtension_txt:=""
		End case 
		If ($FillReturn_B)
			$InsertFieldBind_txt:="v_"+String:C10($TableNumber_l)+"_"+String:C10($FieldNumber_l; "000")+$VariableExtension_txt
			$InsertFieldName_txt:="["+$InsertFieldName_txt+"]"
		End if 
	Else 
		$InsertFieldName_txt:=""
		$InsertFieldBind_txt:=""
	End if 
End if 
$InsertFieldDescriptor_ptr->:=$InsertFieldName_txt
$InsertBindDescriptor_ptr->:=$InsertFieldBind_txt

//End ut_SQLReturnFromFileForSQL

