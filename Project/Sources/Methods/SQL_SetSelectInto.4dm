//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 11/23/10, 09:59:48
// ----------------------------------------------------
// Method: SQL_SetSelectInto
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (11/23/10)
If (False:C215)
	
End if 



C_LONGINT:C283($1; $TableNumber_l; $ACTLastFieldNumber_l; $Loop_l; $FieldType_l; $Length_l)
$TableNumber_l:=$1

C_POINTER:C301($2; $3)


C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; $BindToVariable_txt; $FieldName_txt)

$ACTLastFieldNumber_l:=Get last field number:C255(Table:C252($TableNumber_l))

C_BOOLEAN:C305($Indexed_b; $Unique_b; $Included_b)
For ($Loop_l; 1; $ACTLastFieldNumber_l)
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		
		GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $FieldType_l; $Length_l; $Indexed_b; $Unique_b)
		
		If ($FieldType_l#7)
			clone_SQLReturnFromFileForSQL($TableNumber_l; $Loop_l; ->$FieldName_txt; ->$BindToVariable_txt)
			
			If ($FieldName_txt#"")
				If ($SelectFields_txt="")
					$SelectFields_txt:=$FieldName_txt
					$UpdateFields_txt:=":"+$BindToVariable_txt
					
				Else 
					$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
					$UpdateFields_txt:=$UpdateFields_txt+","+":"+$BindToVariable_txt
				End if 
			End if 
		End if 
		
	End if 
	
	
End for 

$2->:=$SelectFields_txt
$3->:=$UpdateFields_txt