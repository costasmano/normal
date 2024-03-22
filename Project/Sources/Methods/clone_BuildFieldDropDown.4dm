//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/09/13, 11:46:00
//----------------------------------------------------
//Method: clone_BuildFieldDropDown
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (Form event code:C388=On Clicked:K2:4)
	C_LONGINT:C283($1; $Row_l; $Loop_L; $fldType_L; $FldLen_L)
	C_BOOLEAN:C305($FldIndx_b; $FldUnique_b; $FldInvis_b)
	$Row_l:=$1
	ARRAY TEXT:C222($Indexed_atxt; 0)
	ARRAY TEXT:C222($Unique_atxt; 0)
	ARRAY TEXT:C222(FieldNames_atxt; 0)
	ARRAY LONGINT:C221(FieldTypes_al; 0)
	ARRAY LONGINT:C221($UFieldTypes_al; 0)
	ARRAY LONGINT:C221($IFieldTypes_al; 0)
	
	For ($Loop_L; 1; Get last field number:C255(ProcessTableNumber_al{$Row_l}))
		
		If (Is field number valid:C1000(ProcessTableNumber_al{$Row_l}; $Loop_L))
			GET FIELD PROPERTIES:C258(ProcessTableNumber_al{$Row_l}; $Loop_L; $fldType_L; $FldLen_L; $FldIndx_b; $FldUnique_b; $FldInvis_b)
			Case of 
				: ($fldType_L=Is real:K8:4)
				: ($fldType_L=Is BLOB:K8:12)
				: ($fldType_L=Is picture:K8:10)
				: ($fldType_L=Is time:K8:8)
				Else 
					Case of 
						: ($FldIndx_b) & ($FldUnique_b)
							APPEND TO ARRAY:C911($Unique_atxt; Field name:C257(ProcessTableNumber_al{$Row_l}; $Loop_L))
							APPEND TO ARRAY:C911($UFieldTypes_al; $fldType_L)
						: ($FldIndx_b)
							APPEND TO ARRAY:C911($Indexed_atxt; Field name:C257(ProcessTableNumber_al{$Row_l}; $Loop_L))
							APPEND TO ARRAY:C911($IFieldTypes_al; $fldType_L)
						Else 
							APPEND TO ARRAY:C911(FieldNames_atxt; Field name:C257(ProcessTableNumber_al{$Row_l}; $Loop_L))
							APPEND TO ARRAY:C911(FieldTypes_al; $fldType_L)
					End case 
			End case 
		End if 
	End for 
	SORT ARRAY:C229(FieldNames_atxt; FieldTypes_al; >)
	SORT ARRAY:C229($Unique_atxt; $UFieldTypes_al; >)
	SORT ARRAY:C229($Indexed_atxT; $IFieldTypes_al; >)
	If (Size of array:C274($Indexed_atxt)>0)
		INSERT IN ARRAY:C227(FieldNames_atxt; 0; 1)
		FieldNames_atxt{1}:="----------"
		INSERT IN ARRAY:C227(FieldTypes_al; 0; 1)
		
		For ($Loop_L; 1; Size of array:C274($Indexed_atxt))
			INSERT IN ARRAY:C227(FieldNames_atxt; 0; 1)
			FieldNames_atxt{1}:=$Indexed_atxt{$Loop_L}
			INSERT IN ARRAY:C227(FieldTypes_al; 0; 1)
			FieldTypes_al{1}:=$IFieldTypes_al{$Loop_L}
			
		End for 
	End if 
	If (Size of array:C274($Unique_atxt)>0)
		INSERT IN ARRAY:C227(FieldNames_atxt; 0; 1)
		FieldNames_atxt{1}:="----------"
		INSERT IN ARRAY:C227(FieldTypes_al; 0; 1)
		For ($Loop_L; 1; Size of array:C274($Unique_atxt))
			INSERT IN ARRAY:C227(FieldNames_atxt; 0; 1)
			FieldNames_atxt{1}:=$Unique_atxt{$Loop_L}
			INSERT IN ARRAY:C227(FieldTypes_al; 0; 1)
			FieldTypes_al{1}:=$UFieldTypes_al{$Loop_L}
		End for 
	End if 
	ButtonpopupText:=FieldNames_atxt{1}
	For ($Loop_L; 2; Size of array:C274(FieldNames_atxt))
		ButtonpopupText:=ButtonpopupText+";"+FieldNames_atxt{$Loop_L}
	End for 
End if 
//End clone_BuildFieldDropDown

