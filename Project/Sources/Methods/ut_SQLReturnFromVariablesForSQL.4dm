//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/25/10, 12:08:39
// ----------------------------------------------------
// Method: ut_SQL_ReturnFromVariablesForSQ
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (5/25/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:13:00) 
End if 
C_LONGINT:C283($1; $2; $3)
C_POINTER:C301($4; $5; $Variable_ptr; $Field_Ptr; $Type_ptr)

C_LONGINT:C283($1; $2; $TableNumber_l; $FieldNumber_l; $Type_l; $Length_l)
$TableNumber_l:=$1
$FieldNumber_l:=$2
$Type_l:=$3
C_POINTER:C301($4; $InsertFieldDescriptor_ptr; $InsertBindDescriptor_ptr)
$InsertFieldDescriptor_ptr:=$4
$InsertBindDescriptor_ptr:=$5
C_TEXT:C284($InsertFieldName_txt; $InsertFieldBind_txt)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
$InsertFieldName_txt:=Field name:C257($TableNumber_l; $FieldNumber_l)
C_TEXT:C284($VariableExtension_txt)
Case of 
	: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3) | ($Type_l=Is string var:K8:2)
		$VariableExtension_txt:="_txt"
	: ($Type_l=Is real:K8:4)
		$VariableExtension_txt:="_r"
	: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
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
		$VariableExtension_txt:="_blb"
	Else 
		$VariableExtension_txt:=""
End case 


$Field_Ptr:=Field:C253($TableNumber_l; $FieldNumber_l)

$InsertFieldBind_txt:="v_"+String:C10($TableNumber_l)+"_"+String:C10($FieldNumber_l; "000")+$VariableExtension_txt
$InsertFieldName_txt:="["+$InsertFieldName_txt+"]"



$InsertFieldDescriptor_ptr->:=$InsertFieldName_txt
$InsertBindDescriptor_ptr->:=$InsertFieldBind_txt






