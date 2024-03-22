//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/21/10, 14:42:40
// ----------------------------------------------------
// Method: ut_SetSelectForAllFields
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------
//$1 Table number
//$2 Pointer to bind

// Modified by: Charles Miller (6/21/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:15:56) 
End if 

C_TEXT:C284($0; $SQL_Select_txt)
C_LONGINT:C283($1)
C_POINTER:C301($2; $InsertBindDescriptor_ptr)
$TableNumber_l:=$1
$InsertBindDescriptor_ptr:=$2
$SQL_Select_txt:="SELECT  "
C_TEXT:C284($SelectFieldName_txt; $BindToVariable_txt; $SQL_Fields_txt; $SQL_Values_txt)
$SQL_Fields_txt:=""
$SQL_Values_txt:=""
C_LONGINT:C283($Loop_l; $TableNumber_l; $ACTLastFieldNumber_l)

$ACTLastFieldNumber_l:=Get last field number:C255(Table:C252($TableNumber_l))

For ($Loop_l; 1; $ACTLastFieldNumber_l)
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		ut_SQLReturnFromFileForSQL($TableNumber_l; $Loop_l; ->$SelectFieldName_txt; ->$BindToVariable_txt)
		If ($SelectFieldName_txt#"")
			If ($SQL_Fields_txt="")
				$SQL_Fields_txt:=$SelectFieldName_txt
				$InsertBindDescriptor_ptr->:=":"+$BindToVariable_txt
			Else 
				$SQL_Fields_txt:=$SQL_Fields_txt+", "+$SelectFieldName_txt
				$InsertBindDescriptor_ptr->:=$InsertBindDescriptor_ptr->+", :"+$BindToVariable_txt
			End if 
		End if 
	End if 
End for 
$SQL_Select_txt:=$SQL_Select_txt+$SQL_Fields_txt+Char:C90(Carriage return:K15:38)

$0:=$SQL_Select_txt


//End Method ut_SetSelectForAllFields