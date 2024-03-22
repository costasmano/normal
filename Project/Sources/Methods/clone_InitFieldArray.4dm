//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/21/11, 15:56:05
//----------------------------------------------------
//Method: clone_InitFieldArray
//Description
//
// Parameters
// ----------------------------------------------------



If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (9/21/11 15:56:06)
End if 

C_LONGINT:C283($TableNumber_l; $Loop_l; $Type_l; $Length_l; $size_l)

//Dimension 1 is table number
//Dimension 2 is pointer to variables based upon fields
ARRAY POINTER:C280(TableFieldsVars_aptr; 0; 0)  //This array points to variables used in sql stuff
ARRAY POINTER:C280(TableFieldsVars_aptr; Get last table number:C254; 0)

//Dimension 1 is table number
//Dimension 2 is pointer to fields based upon fields
ARRAY POINTER:C280(TableFlds_aptr; 0; 0)  //This array points to variables used in sql stuff
ARRAY POINTER:C280(TableFlds_aptr; Get last table number:C254; 0)


//Dimension 1 is table number
//Dimension 2 is field type
ARRAY LONGINT:C221(TableFidTypes_al; 0; 0)  //This array points to variables used in sql stuff
ARRAY LONGINT:C221(TableFidTypes_al; Get last table number:C254; 0)


C_POINTER:C301($Field_ptr; $Variable_ptr)

C_TEXT:C284($VariableExtension_txt)


For ($TableNumber_l; 1; Get last table number:C254)
	
	If (Is table number valid:C999($TableNumber_l))
		For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
			If (Is field number valid:C1000($TableNumber_l; $Loop_l))
				GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l)
				
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
						$VariableExtension_txt:="_blb"
					Else 
						$VariableExtension_txt:=""
				End case 
				$size_l:=Size of array:C274(TableFieldsVars_aptr{$TableNumber_l})+1
				INSERT IN ARRAY:C227(TableFieldsVars_aptr{$TableNumber_l}; $size_l; 1)
				
				INSERT IN ARRAY:C227(TableFlds_aptr{$TableNumber_l}; $size_l; 1)
				$Field_ptr:=Field:C253($TableNumber_l; $Loop_l)
				TableFlds_aptr{$TableNumber_l}{$Loop_l}:=$Field_ptr
				
				INSERT IN ARRAY:C227(TableFidTypes_al{$TableNumber_l}; $size_l; 1)
				TableFidTypes_al{$TableNumber_l}{$Loop_l}:=$Type_l
				
				
				
				If ($Type_l#7)  //type 7 is subtable we are not using any data from them
					$Variable_ptr:=Get pointer:C304("v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt)
					TableFieldsVars_aptr{$TableNumber_l}{$Loop_l}:=$Variable_ptr
				End if 
			Else 
				$size_l:=Size of array:C274(TableFieldsVars_aptr{$TableNumber_l})+1
				INSERT IN ARRAY:C227(TableFieldsVars_aptr{$TableNumber_l}; $size_l; 1)
				INSERT IN ARRAY:C227(TableFlds_aptr{$TableNumber_l}; $size_l; 1)
				INSERT IN ARRAY:C227(TableFidTypes_al{$TableNumber_l}; $size_l; 1)
			End if 
			
		End for 
		
	End if 
End for 

//End clone_InitFieldArray

